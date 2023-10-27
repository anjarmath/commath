package controller

import (
	"github.com/anjarmath/jago/repository"
	"github.com/gofiber/fiber/v2"
)

type companyController struct {
	companyRepository repository.CompanyRepository
}

func NewCompanyController(companyRepository *repository.CompanyRepository) companyController {
	return companyController{
		companyRepository: *companyRepository,
	}
}

func (cc *companyController) GetAllCompany(c *fiber.Ctx) error {
	companies, err := cc.companyRepository.FindAll()
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Data tidak ditemukan",
		})
	}

	return c.Status(fiber.StatusOK).JSON(companies)
}
