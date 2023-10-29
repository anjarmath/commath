package middleware

import (
	"os"
	"strings"

	"github.com/gofiber/fiber/v2"
)

const (
	KNoRole    = -1
	KUserRole  = 0
	KCompRole  = 1
	KAdminRole = 2
)

func AuthMiddleware(minRole int) fiber.Handler {
	return func(c *fiber.Ctx) error {
		authHeader := c.Get("Authorization")
		if len(authHeader) == 0 {
			return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
				"message": "authorization header is not provided",
			})
		}
		tokenString := strings.TrimPrefix(authHeader, "Bearer ")
		if tokenString == "" {
			return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
				"message": "Unauthorized access !",
			})
		}

		reqRole, err := getRoleByToken(tokenString)
		if err != nil {
			return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
				"message": err.Error(),
			})
		}

		if reqRole < minRole {
			return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
				"message": "Unauthorized access !",
			})
		}

		return c.Next()
	}
}

func getRoleByToken(token string) (int, error) {
	if token == os.Getenv("API_SECRET_USER") {
		return KUserRole, nil
	} else if token == os.Getenv("API_SECRET_COMP") {
		return KCompRole, nil
	} else if token == os.Getenv("API_SECRET_ADMIN") {
		return KAdminRole, nil
	} else {
		return KNoRole, fiber.NewError(0, "Token Invalid")
	}
}
