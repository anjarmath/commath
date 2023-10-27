package model

import (
	"time"

	"github.com/google/uuid"
)

type Companies struct {
	ID          uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4()" json:"id"`
	Username    string    `json:"username" gorm:"unique"`
	Name        string    `json:"name"`
	Password    string    `json:"password"`
	Profile     string    `json:"profile"`
	Cover       string    `json:"cover"`
	Description string    `json:"description" gorm:"type:text"`
	Problem     string    `json:"problem" gorm:"type:text"`
	Verified    *bool     `json:"verified" gorm:"default:false"`
	AccessToken string    `json:"access_token"`
	CreatedAt   time.Time `gorm:"default:now()" json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}

type CompanyReq struct {
	Username     string `json:"username"`
	Name         string `json:"name"`
	Password     string `json:"password"`
	ConfPassword string `json:"conf_password"`
	Profile      string `json:"profile"`
	Cover        string `json:"cover"`
	Description  string `json:"description"`
	Problem      string `json:"problem"`
}

type CompanyRes struct {
	ID          uuid.UUID `json:"id"`
	Username    string    `json:"username"`
	Name        string    `json:"name"`
	Profile     string    `json:"profile"`
	Cover       string    `json:"cover"`
	Description string    `json:"description"`
	Problem     string    `json:"problem" `
	Verified    *bool     `json:"verified"`
	AccessToken string    `json:"access_token"`
}
