package controller

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/gofiber/fiber/v2"
	"github.com/google/uuid"
)

type fileController struct{}

func NewFileController() fileController {
	return fileController{}
}

func (fc *fileController) UploadImage(c *fiber.Ctx) error {

	// Mengambil file dari form-data
	file, err := c.FormFile("image")
	if err != nil {
		return err
	}

	//Generate nama file baru
	newFileName := fc.generateNewFilename("image", uuid.NewString())

	// Path penyimpanan file di server
	uploadDir := os.Getenv("ASSETS_ROOT") + "/image"
	filePath := filepath.Join(uploadDir, newFileName)

	// Membuat direktori jika belum ada
	err = os.MkdirAll(uploadDir, os.ModePerm)
	if err != nil {
		return err
	}

	// Simpan file ke server
	if err := c.SaveFile(file, filePath); err != nil {
		return err
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"data": filePath,
	})

}

// Fungsi untuk menghasilkan nama file baru
func (fc *fileController) generateNewFilename(userID string, filename string) string {
	ext := filepath.Ext(filename)
	newFilename := fmt.Sprintf("%s%s", userID, ext)
	return newFilename
}
