package controller

import (
	"math/rand"

	"github.com/anjarmath/jago/model"
	"github.com/anjarmath/jago/repository"
	"github.com/gofiber/fiber/v2"
)

type examController struct {
	examRepository    repository.ExamRepository
	companyRepository repository.CompanyRepository
}

func NewExamController(examRepository repository.ExamRepository, companyRepository repository.CompanyRepository) examController {
	return examController{
		examRepository:    examRepository,
		companyRepository: companyRepository,
	}
}

func (ec *examController) CreateExam(c *fiber.Ctx) error {
	examReq := new(model.ExamReq)

	if err := c.BodyParser(examReq); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": "can't handle request",
		})
	}

	exam := model.Exams{
		CompanyID: examReq.CompanyID,
		TopicID:   examReq.TopicID,
		Question:  examReq.Question,
	}

	exam, err := ec.examRepository.Create(&exam)
	if err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": err.Error(),
		})
	}

	_, err = ec.companyRepository.Activate((exam.CompanyID).String())
	if err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": err.Error(),
		})
	}

	return c.Status(fiber.StatusOK).JSON(exam)
}

func (ec *examController) GetExamByCompanyId(c *fiber.Ctx) error {
	companyId := c.Query("company_id")

	exams, err := ec.examRepository.FindByCompanyId(companyId)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Tidak ditemukan",
		})
	}

	exam, err := ec.randomExam(exams)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Tidak ditemukan",
		})
	}

	return c.Status(fiber.StatusOK).JSON(exam)
}

func (ec *examController) randomExam(exams []model.Exams) (*model.Exams, error) {
	if len(exams) == 0 {
		return nil, fiber.NewError(0)
	}
	index := rand.Intn(len(exams))
	return &exams[index], nil
}
