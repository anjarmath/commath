package controller

import (
	"github.com/anjarmath/jago/repository"
	"github.com/gofiber/fiber/v2"
)

type userController struct {
	userRepository repository.UserRepository
}

func NewUserController(userRepository repository.UserRepository) userController {
	return userController{
		userRepository: userRepository,
	}
}

func (uc *userController) GetAllUser(c *fiber.Ctx) error {
	users, err := uc.userRepository.FindAllUser()
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Data tidak ditemukan",
		})
	}

	return c.Status(fiber.StatusOK).JSON(users)
}

func (uc *userController) GetUserById(c *fiber.Ctx) error {
	userId := c.Params("id")

	user, err := uc.userRepository.FindUserById(userId)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{
			"message": "Data tidak ditemukan",
		})
	}

	return c.Status(fiber.StatusOK).JSON(user)
}
