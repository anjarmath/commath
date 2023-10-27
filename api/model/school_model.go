package model

import (
	"time"

	"github.com/google/uuid"
)

type Schools struct {
	ID        uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4()" json:"id"`
	Name      string    `json:"name"`
	CreatedAt time.Time `gorm:"default:now()" json:"created_at"`
}

type SchoolReq struct {
	Name string `json:"name"`
}

type Classes struct {
	ID        uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4()" json:"id"`
	Name      string    `json:"name"`
	SchoolID  uuid.UUID `json:"school_id"`
	School    *Schools  `json:"school" gorm:"foreignKey:SchoolID;references:ID"`
	CreatedAt time.Time `gorm:"default:now()" json:"created_at"`
}

type ClassReq struct {
	Name     string    `json:"name"`
	SchoolID uuid.UUID `json:"school_id"`
}
