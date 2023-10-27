package model

import (
	"time"

	"github.com/google/uuid"
)

type Answers struct {
	ID         uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4()" json:"id"`
	UserID     uuid.UUID `json:"user_id"`
	User       *Users    `json:"user" gorm:"foreignKey:UserID;references:ID"`
	ExamID     uuid.UUID `json:"exam_id"`
	Exam       *Exams    `json:"exam" gorm:"foreignKey:ExamID;references:ID"`
	Diketahui  string    `json:"diketahui" gorm:"type:text"`
	Ditanya    string    `json:"ditanya" gorm:"type:text"`
	Jawab      string    `json:"jawab" gorm:"type:text"`
	Kesimpulan string    `json:"kesimpulan" gorm:"type:text"`
	Feedback   string    `json:"feedback" gorm:"type:text"`
	CreatedAt  time.Time `gorm:"default:now()" json:"created_at"`
}

type AnswerReq struct {
	ExamID     uuid.UUID `json:"exam_id"`
	Diketahui  string    `json:"diketahui"`
	Ditanya    string    `json:"ditanya"`
	Jawab      string    `json:"jawab"`
	Kesimpulan string    `json:"kesimpulan"`
}

type FeedbackReq struct {
	Feedback string `json:"feedback" form:"feedback"`
}
