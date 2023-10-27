package repository

import "github.com/anjarmath/jago/model"

type AnswerRepository interface {
	Create(answer *model.Answers) (model.Answers, error)
	FindAll() ([]model.Answers, error)
	FindByExamId(id string) ([]model.Answers, error)
	FindByUserId(id string) ([]model.Answers, error)
	GiveFeedback(id string, response string) (*model.Answers, error)
	Delete(id string) error
}
