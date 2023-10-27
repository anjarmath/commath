package controller

import (
	"github.com/anjarmath/jago/model"
	"github.com/anjarmath/jago/repository"
	"github.com/gofiber/fiber/v2"
)

type schoolController struct {
	schoolRepository repository.SchoolRepository
}

func NewSchoolController(schoolRepository *repository.SchoolRepository) schoolController {
	return schoolController{
		schoolRepository: *schoolRepository,
	}
}

func (sc *schoolController) CreateSchool(c *fiber.Ctx) error {
	schoolReq := new(model.SchoolReq)

	if err := c.BodyParser(schoolReq); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": "can't handle request",
		})
	}

	school := &model.Schools{
		Name: schoolReq.Name,
	}

	school, err := sc.schoolRepository.Add(school)
	if err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": err,
		})
	}

	return c.Status(fiber.StatusOK).JSON(school)
}

func (sc *schoolController) GetAllSchool(c *fiber.Ctx) error {
	var schools []model.Schools

	schoolsRes, err := sc.schoolRepository.FindAll(&schools)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Data tidak ditemukan",
		})
	}

	return c.Status(fiber.StatusOK).JSON(schoolsRes)
}

func (sc *schoolController) DeleteSchool(c *fiber.Ctx) error {
	schoolId := c.Params("id")
	if err := sc.schoolRepository.Delete(schoolId); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": err,
		})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "success",
	})
}

func (sc *schoolController) CreateClass(c *fiber.Ctx) error {
	classReq := new(model.ClassReq)

	if err := c.BodyParser(classReq); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": "can't handle request",
		})
	}

	class := &model.Classes{
		Name:     classReq.Name,
		SchoolID: classReq.SchoolID,
	}

	class, err := sc.schoolRepository.AddClass(class)
	if err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": err,
		})
	}

	return c.Status(fiber.StatusOK).JSON(class)
}

func (sc *schoolController) GetAllClass(c *fiber.Ctx) error {
	schoolId := c.Query("school_id")

	classesRes, err := sc.schoolRepository.FindClassBySchoolId(schoolId)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Data tidak ditemukan",
		})
	}

	return c.Status(fiber.StatusOK).JSON(classesRes)
}

func (sc *schoolController) DeleteClass(c *fiber.Ctx) error {
	classId := c.Params("id")
	if err := sc.schoolRepository.DeleteClass(classId); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": err,
		})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "success",
	})
}

func (sc *schoolController) CreateTopic(c *fiber.Ctx) error {
	topicReq := new(model.TopicReq)

	if err := c.BodyParser(topicReq); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": "can't handle request",
		})
	}

	topic := &model.Topics{
		Name: topicReq.Name,
	}

	topic, err := sc.schoolRepository.AddTopic(topic)
	if err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": err,
		})
	}

	return c.Status(fiber.StatusOK).JSON(topic)
}

func (sc *schoolController) GetAllTopic(c *fiber.Ctx) error {
	var topics []model.Classes

	topicsRes, err := sc.schoolRepository.FindAll(&topics)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Data tidak ditemukan",
		})
	}

	return c.Status(fiber.StatusOK).JSON(topicsRes)
}

func (sc *schoolController) DeleteTopic(c *fiber.Ctx) error {
	topicId := c.Params("id")
	if err := sc.schoolRepository.DeleteTopic(topicId); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": err,
		})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "success",
	})
}
