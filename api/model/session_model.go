package model

import (
	"time"

	"github.com/google/uuid"
)

type Sessions struct {
	ID        uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4()" json:"id"`
	UserID    uuid.UUID `json:"user_id"`
	User      *Users    `json:"user" gorm:"foreignKey:UserID;references:ID"`
	ExpiredAt time.Time `json:"expired_at"`
	CreatedAt time.Time `gorm:"default:now()" json:"created_at"`
}
