package main

import (
	"log"

	"github.com/anjarmath/jago/dal"
	"github.com/anjarmath/jago/routes"
	"github.com/gofiber/fiber/v2"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load(".env")
	if err != nil {
		log.Fatal("Couldn't load .env")
	}
	dal.InitDB()
	r := fiber.New()
	r.Use(func(c *fiber.Ctx) error {
		c.Set("Access-Control-Allow-Origin", "*")
		c.Set("Access-Control-Allow-Methods", "GET, POST, PATCH, PUT, DELETE, OPTIONS")
		c.Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

		// Handle preflight (OPTIONS) requests
		if c.Method() == fiber.MethodOptions {
			return c.SendStatus(fiber.StatusNoContent)
		}
		return c.Next()
	})

	routes.Setup(r)

	if err := r.Listen(":8000"); err != nil {
		log.Print("error di port 8000")
		panic(err)
	}
}
