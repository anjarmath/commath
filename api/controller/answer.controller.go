package controller

import (
	"github.com/anjarmath/jago/model"
	"github.com/anjarmath/jago/repository"
	"github.com/gofiber/fiber/v2"
)

type answerController struct {
	answerRepository repository.AnswerRepository
	userRepository   repository.UserRepository
}

func NewAnswerController(answerRepository repository.AnswerRepository, userRepository repository.UserRepository) answerController {
	return answerController{
		answerRepository: answerRepository,
		userRepository:   userRepository,
	}
}

func (ac *answerController) MakeAnswer(c *fiber.Ctx) error {
	answerReq := new(model.AnswerReq)

	userId := c.Get("UserID")

	// PARSE BODY REQUEST TO OBJECT STRUCT
	if err := c.BodyParser(answerReq); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": "can't handle request",
		})
	}

	user, err := ac.userRepository.FindUserById(userId)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "User tidak ditemukan",
		})
	}

	answer := model.Answers{
		UserID:     user.ID,
		ExamID:     answerReq.ExamID,
		Diketahui:  answerReq.Diketahui,
		Ditanya:    answerReq.Ditanya,
		Jawab:      answerReq.Jawab,
		Kesimpulan: answerReq.Kesimpulan,
	}

	answer, err = ac.answerRepository.Create(&answer)
	if err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": err.Error(),
		})
	}

	return c.Status(fiber.StatusOK).JSON(answer)
}

func (ac *answerController) GetAllAnswer(c *fiber.Ctx) error {
	examId := c.Query("exam_id")

	answers, err := ac.answerRepository.FindByExamId(examId)
	if err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": err.Error(),
		})
	}

	return c.Status(fiber.StatusOK).JSON(answers)
}

func (ac *answerController) GetAnswerByUser(c *fiber.Ctx) error {
	userId := c.Query("user_id")

	answers, err := ac.answerRepository.FindByUserId(userId)
	if err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": err.Error(),
		})
	}

	return c.Status(fiber.StatusOK).JSON(answers)
}

func (ac *answerController) GiveFeedback(c *fiber.Ctx) error {
	feedBackReq := new(model.FeedbackReq)
	id := c.Params("id")

	// PARSE BODY REQUEST TO OBJECT STRUCT
	if err := c.BodyParser(feedBackReq); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": "can't handle request",
		})
	}

	newAnswers, err := ac.answerRepository.GiveFeedback(id, feedBackReq.Feedback)
	if err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": err.Error(),
		})
	}

	_, err = ac.userRepository.AddUserStar((newAnswers.UserID).String())
	if err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": err.Error(),
		})
	}

	return c.Status(fiber.StatusOK).JSON(newAnswers)
}
