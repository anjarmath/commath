package repository

import (
	"github.com/anjarmath/jago/dal"
	"github.com/anjarmath/jago/model"
)

type answerRepository struct{}

// FindByUserId implements AnswerRepository.
func (answerRepository) FindByUserId(id string) ([]model.Answers, error) {
	var answer []model.Answers
	if err := dal.DB.Find(&answer, "user_id = ?", id).Error; err != nil {
		return nil, err
	}
	return answer, nil
}

// GiveResponse implements AnswerRepository.
func (answerRepository) GiveFeedback(id string, response string) (*model.Answers, error) {
	answer := &model.Answers{}
	if err := dal.DB.First(&answer, "id = ?", id).Error; err != nil {
		return nil, err
	}

	answer.Feedback = response

	if err := dal.DB.Save(&answer).Error; err != nil {
		return nil, err
	}

	return answer, nil
}

// Create implements AnswerRepository.
func (answerRepository) Create(answer *model.Answers) (model.Answers, error) {
	db := dal.DB.Create(answer)
	return *answer, db.Error
}

// Delete implements AnswerRepository.
func (answerRepository) Delete(id string) error {
	db := dal.DB.Where("id = ?", id).Delete(&model.Answers{})

	return db.Error
}

// FindAll implements AnswerRepository.
func (answerRepository) FindAll() ([]model.Answers, error) {
	var answer []model.Answers
	if err := dal.DB.Find(&answer).Error; err != nil {
		return nil, err
	}
	return answer, nil
}

// FindByExamId implements AnswerRepository.
func (answerRepository) FindByExamId(id string) ([]model.Answers, error) {
	var answer []model.Answers
	if err := dal.DB.Find(&answer, "exam_id = ?", id).Error; err != nil {
		return nil, err
	}
	return answer, nil
}

func NewAnswerRepository() AnswerRepository {
	return answerRepository{}
}
