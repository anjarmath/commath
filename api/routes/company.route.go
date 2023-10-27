package routes

import (
	"github.com/anjarmath/jago/controller"
	"github.com/anjarmath/jago/repository"
	"github.com/gofiber/fiber/v2"
)

func CompanyRoute(r *fiber.App) {
	companyRepository := repository.NewCompanyRepository()
	companyController := controller.NewCompanyController(&companyRepository)
	r.Get("/company", companyController.GetAllCompany)
}
