package routes

import (
	"github.com/anjarmath/jago/controller"
	"github.com/anjarmath/jago/middleware"
	"github.com/anjarmath/jago/repository"
	"github.com/gofiber/fiber/v2"
)

func ExamRoute(r *fiber.App) {
	companyRepository := repository.NewCompanyRepository()
	examRepository := repository.NewExamRepository()
	examController := controller.NewExamController(examRepository, companyRepository)
	exam := r.Group("/exam")
	exam.Get("/", examController.GetExamByCompanyId)
	exam.Post("/", examController.CreateExam).Use(middleware.AuthMiddleware(middleware.KAdminRole))
}
