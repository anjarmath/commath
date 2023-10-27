package dal

import (
	"log"
	"os"
	"time"

	"github.com/anjarmath/jago/model"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/schema"
)

var DB *gorm.DB

func InitDB() {
	connection := os.Getenv("DATABASE_URL")

	database, err := gorm.Open(postgres.Open(connection), &gorm.Config{
		NamingStrategy: schema.NamingStrategy{SingularTable: true}})
	database.Exec(`CREATE EXTENSION IF NOT EXISTS "uuid-ossp";`)
	if err != nil {
		panic("Cant connect to database")
	}
	log.Default().Println("Connected to database")

	database.AutoMigrate(
		&model.Schools{},
		&model.Classes{},
		&model.Users{},
		&model.Admins{},
		&model.Companies{},
		&model.Sessions{},
		&model.Topics{},
		&model.Exams{},
		&model.Answers{},
		&model.Notifications{},
	)

	db, err := database.DB()
	if err != nil {
		panic("Cant connect to database")
	}
	db.SetMaxIdleConns(10)
	db.SetMaxOpenConns(100)
	db.SetConnMaxLifetime(time.Hour)
	DB = database
}
