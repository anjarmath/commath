package controller

import (
	"os"

	"github.com/anjarmath/jago/model"
	"github.com/anjarmath/jago/repository"
	"github.com/anjarmath/jago/usecase"
	"github.com/gofiber/fiber/v2"
)

type authController struct {
	userRepository    repository.UserRepository
	companyRepository repository.CompanyRepository
}

func NewAuthController(userRepository repository.UserRepository, companyRepository repository.CompanyRepository) authController {
	return authController{
		userRepository:    userRepository,
		companyRepository: companyRepository,
	}
}

func (ac *authController) LoginUser(c *fiber.Ctx) error {
	req := new(model.LoginReq)

	// PARSE BODY REQUEST TO OBJECT STRUCT
	if err := c.BodyParser(req); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": "can't handle request",
		})
	}

	user, err := ac.userRepository.FindUserByUsername(req.Username)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Username salah",
		})
	}

	match := usecase.CheckPasswordHash(req.Password, user.Password)
	if !match {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Password salah",
		})
	}

	return c.Status(fiber.StatusOK).JSON(user)
}

func (ac *authController) LoginAdmin(c *fiber.Ctx) error {
	req := new(model.LoginReq)

	// PARSE BODY REQUEST TO OBJECT STRUCT
	if err := c.BodyParser(req); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": "can't handle request",
		})
	}

	admin, err := ac.userRepository.FindAdminByUsername(req.Username)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Username salah",
		})
	}

	match := usecase.CheckPasswordHash(req.Password, admin.Password)
	if !match {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Password salah",
		})
	}

	admin.AccessToken = os.Getenv("API_SECRET_ADMIN")

	return c.Status(fiber.StatusOK).JSON(admin)
}

func (ac *authController) LoginCompany(c *fiber.Ctx) error {
	req := new(model.LoginReq)

	// PARSE BODY REQUEST TO OBJECT STRUCT
	if err := c.BodyParser(req); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": "can't handle request",
		})
	}

	company, err := ac.companyRepository.FindByUsername(req.Username)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Username salah",
		})
	}

	match := usecase.CheckPasswordHash(req.Password, company.Password)
	if !match {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Password salah",
		})
	}

	return c.Status(fiber.StatusOK).JSON(company)
}

func (ac *authController) SignUpUser(c *fiber.Ctx) error {
	req := new(model.UserRegisterReq)

	// PARSE BODY REQUEST TO OBJECT STRUCT
	if err := c.BodyParser(req); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": "can't handle request",
		})
	}

	if req.Password != req.ConfPassword {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Password salah",
		})
	}

	passwordHashed, err := usecase.HashPassword(req.Password)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Cannot Hash Password",
		})
	}

	user := model.Users{
		Username: req.Username,
		Name:     req.Name,
		Password: passwordHashed,
		ClassID:  req.ClassId,
	}

	_, err = ac.userRepository.CreateUser(&user)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": err.Error(),
		})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "Selamat, akun berhasil dibuat!",
	})
}

func (ac *authController) SignUpCompany(c *fiber.Ctx) error {
	req := new(model.CompanyReq)

	// PARSE BODY REQUEST TO OBJECT STRUCT
	if err := c.BodyParser(req); err != nil {
		return c.Status(fiber.ErrInternalServerError.Code).JSON(fiber.Map{
			"message": "can't handle request",
		})
	}

	if req.Password != req.ConfPassword {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Password salah",
		})
	}

	passwordHashed, err := usecase.HashPassword(req.Password)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Cannot Hash Password",
		})
	}

	comp := model.Companies{
		Username:    req.Username,
		Name:        req.Name,
		Password:    passwordHashed,
		Profile:     req.Profile,
		Cover:       req.Cover,
		Description: req.Description,
		Problem:     req.Problem,
	}

	_, err = ac.companyRepository.Create(&comp)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": err.Error(),
		})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "Selamat, akun berhasil dibuat!",
	})
}
