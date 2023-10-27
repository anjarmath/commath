package model

import (
	"time"

	"github.com/google/uuid"
)

type Notifications struct {
	ID        uuid.UUID  `gorm:"type:uuid;default:uuid_generate_v4()" json:"id"`
	ClassID   uuid.UUID  `json:"class_id"`
	Class     *Classes   `json:"class" gorm:"foreignKey:ClassID;references:ID"`
	CompanyID uuid.UUID  `json:"company_id"`
	Company   *Companies `json:"company" gorm:"foreignKey:CompanyID;references:ID"`
	Date      time.Time  `json:"date"`
	CreatedAt time.Time  `gorm:"default:now()" json:"created_at"`
}
