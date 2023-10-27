package repository

import "github.com/anjarmath/jago/model"

type ExamRepository interface {
	Create(exam *model.Exams) (model.Exams, error)
	FindAll() ([]model.Exams, error)
	FindByCompanyId(id string) ([]model.Exams, error)
	Delete(id string) error
}
