package routes

import (
	"github.com/anjarmath/jago/controller"
	"github.com/anjarmath/jago/middleware"
	"github.com/gofiber/fiber/v2"
)

func FileRoute(r *fiber.App) {
	fileController := controller.NewFileController()
	file := r.Group("/file")
	file.Use(middleware.AuthMiddleware(middleware.KUserRole))
	file.Post("/", fileController.UploadImage)
}
