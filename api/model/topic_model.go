package model

import (
	"time"

	"github.com/google/uuid"
)

type Topics struct {
	ID        uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4()" json:"id"`
	Name      string    `json:"name" form:"name"`
	CreatedAt time.Time `gorm:"default:now()" json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`
}

type TopicReq struct {
	Name string `json:"name" form:"name"`
}
