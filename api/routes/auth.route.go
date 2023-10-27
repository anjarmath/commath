package routes

import (
	"github.com/anjarmath/jago/controller"
	"github.com/anjarmath/jago/repository"
	"github.com/gofiber/fiber/v2"
)

func AuthRoute(r *fiber.App) {
	userRepository := repository.NewUserRepositoryImpl()
	compRepository := repository.NewCompanyRepository()
	authController := controller.NewAuthController(userRepository, compRepository)
	r.Post("/login", authController.LoginUser)
	r.Post("/login/comp", authController.LoginCompany)
	r.Post("/login/admin", authController.LoginAdmin)
	r.Post("/signup", authController.SignUpUser)
	r.Post("/signup/comp", authController.SignUpCompany)

	// user route
	// userRoute := r.Group("/user")
	// userRoute.Use(middleware.AuthMiddleware(middleware.KUserRole))
	// userRoute.Get("/:id")
	// userRoute.Patch("/:id")

	// company route
}
