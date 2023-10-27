package routes

import (
	"github.com/anjarmath/jago/controller"
	"github.com/anjarmath/jago/middleware"
	"github.com/anjarmath/jago/repository"
	"github.com/gofiber/fiber/v2"
)

func AnswerRoute(r *fiber.App) {
	userRepository := repository.NewUserRepositoryImpl()
	answerRepository := repository.NewAnswerRepository()

	answerController := controller.NewAnswerController(answerRepository, userRepository)
	answer := r.Group("/answer")
	answer.Use(middleware.AuthMiddleware(middleware.KUserRole))
	answer.Post("/", answerController.MakeAnswer)
	answer.Get("/", answerController.GetAllAnswer)
	answer.Get("/user", answerController.GetAnswerByUser)
	answer.Patch("/:id", answerController.GiveFeedback).Use(middleware.AuthMiddleware(middleware.KAdminRole))
}
