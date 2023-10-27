package model

import (
	"time"

	"github.com/google/uuid"
)

type Exams struct {
	ID        uuid.UUID  `gorm:"type:uuid;default:uuid_generate_v4()" json:"id"`
	CompanyID uuid.UUID  `json:"company_id"`
	Company   *Companies `json:"company" gorm:"foreignKey:CompanyID;references:ID"`
	TopicID   uuid.UUID  `json:"topic_id"`
	Topic     *Topics    `json:"topic" gorm:"foreignKey:TopicID;references:ID"`
	Question  string     `json:"question" gorm:"type:text"`
	CreatedAt time.Time  `gorm:"default:now()" json:"created_at"`
	UpdatedAt time.Time  `json:"updated_at"`
}

type ExamReq struct {
	CompanyID uuid.UUID `json:"company_id"`
	TopicID   uuid.UUID `json:"topic_id"`
	Question  string    `json:"question" gorm:"type:text"`
}
