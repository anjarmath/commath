package repository

import (
	"github.com/anjarmath/jago/dal"
	"github.com/anjarmath/jago/model"
)

type examRepositoryImpl struct{}

// Create implements ExamRepository.
func (examRepositoryImpl) Create(exam *model.Exams) (model.Exams, error) {
	db := dal.DB.Create(exam)
	return *exam, db.Error
}

// Delete implements ExamRepository.
func (examRepositoryImpl) Delete(id string) error {
	db := dal.DB.Where("id = ?", id).Delete(&model.Exams{})

	return db.Error
}

// FindAll implements ExamRepository.
func (examRepositoryImpl) FindAll() ([]model.Exams, error) {
	var exams []model.Exams
	if err := dal.DB.Find(&exams).Error; err != nil {
		return nil, err
	}
	return exams, nil
}

// FindBySchoolId implements ExamRepository.
func (examRepositoryImpl) FindByCompanyId(id string) ([]model.Exams, error) {
	var exams []model.Exams
	if err := dal.DB.Find(&exams, "company_id = ?", id).Error; err != nil {
		return nil, err
	}
	return exams, nil
}

func NewExamRepository() ExamRepository {
	return examRepositoryImpl{}
}
