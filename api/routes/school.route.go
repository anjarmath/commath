package routes

import (
	"github.com/anjarmath/jago/controller"
	"github.com/anjarmath/jago/middleware"
	"github.com/anjarmath/jago/repository"
	"github.com/gofiber/fiber/v2"
)

func SchoolRoute(r *fiber.App) {
	schoolRepository := repository.NewSchoolRepository()
	schoolController := controller.NewSchoolController(&schoolRepository)

	s := r.Group("/school")
	s.Post("/", schoolController.CreateSchool).Use(middleware.AuthMiddleware(middleware.KAdminRole))
	s.Get("/", schoolController.GetAllSchool)
	s.Delete("/:id", schoolController.DeleteSchool).Use(middleware.AuthMiddleware(middleware.KAdminRole))

	class := r.Group("/class")
	class.Post("/", schoolController.CreateClass).Use(middleware.AuthMiddleware(middleware.KAdminRole))
	class.Get("/", schoolController.GetAllClass)
	class.Delete("/:id", schoolController.DeleteClass).Use(middleware.AuthMiddleware(middleware.KAdminRole))

	topic := r.Group("/topic")
	topic.Post("/", schoolController.CreateTopic).Use(middleware.AuthMiddleware(middleware.KAdminRole))
	topic.Get("/", schoolController.GetAllTopic)
	topic.Delete("/:id", schoolController.DeleteTopic).Use(middleware.AuthMiddleware(middleware.KAdminRole))
}
