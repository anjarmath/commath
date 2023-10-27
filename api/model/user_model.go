package model

import (
	"time"

	"github.com/google/uuid"
)

type Users struct {
	ID          uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4()" json:"id"`
	Username    string    `json:"username" gorm:"unique"`
	Name        string    `json:"name"`
	Password    string    `json:"password"`
	Stars       int       `json:"stars" gorm:"type:int;default:0"`
	ClassID     uuid.UUID `json:"class_id"`
	Class       *Classes  `json:"class" gorm:"foreignKey:ClassID;references:ID"`
	AccessToken string    `json:"access_token"`
	CreatedAt   time.Time `gorm:"default:now()" json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}

type UserRegisterReq struct {
	Username     string    `json:"username"`
	Name         string    `json:"name"`
	Password     string    `json:"password"`
	ConfPassword string    `json:"conf_password"`
	ClassId      uuid.UUID `json:"class_id"`
}

type UserRes struct {
	ID          uuid.UUID `json:"id"`
	Username    string    `json:"username"`
	Name        string    `json:"name"`
	Stars       int       `json:"stars"`
	Class       *Classes  `json:"class"`
	AccessToken string    `json:"access_token"`
}

type Admins struct {
	ID          uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4()" json:"id"`
	Username    string    `json:"username"`
	Name        string    `json:"name"`
	Password    string    `json:"password"`
	AccessToken string    `json:"access_token"`
	CreatedAt   time.Time `gorm:"default:now()" json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}

type AdminRegisterReq struct {
	Username     string `json:"username"`
	Name         string `json:"name"`
	Password     string `json:"password"`
	ConfPassword string `json:"conf_password"`
}

type AdminRes struct {
	ID          uuid.UUID `json:"id"`
	Username    string    `json:"username"`
	Name        string    `json:"name"`
	Stars       int       `json:"stars"`
	AccessToken string    `json:"access_token"`
}
