package routes

import (
	"github.com/anjarmath/jago/controller"
	"github.com/anjarmath/jago/middleware"
	"github.com/anjarmath/jago/repository"
	"github.com/gofiber/fiber/v2"
)

func UserRoute(r *fiber.App) {
	userRepository := repository.NewUserRepositoryImpl()
	userController := controller.NewUserController(userRepository)
	user := r.Group("/user")
	user.Use(middleware.AuthMiddleware(middleware.KUserRole))

	user.Get("/", userController.GetAllUser)
	user.Get("/:id", userController.GetUserById)
}
