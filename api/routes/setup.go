package routes

import (
	"net/http"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/filesystem"
)

func Setup(r *fiber.App) {
	r.Use(filesystem.New(filesystem.Config{
		Root:   http.Dir("./public"),
		Browse: true,
	}))
	AuthRoute(r)
	UserRoute(r)
	FileRoute(r)
	CompanyRoute(r)
	SchoolRoute(r)
	ExamRoute(r)
}
