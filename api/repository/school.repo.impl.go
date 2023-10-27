package repository

import (
	"github.com/anjarmath/jago/dal"
	"github.com/anjarmath/jago/model"
)

type schoolRepositoryImpl struct{}

// FindClassBySchoolId implements SchoolRepository.
func (schoolRepositoryImpl) FindClassBySchoolId(id string) ([]model.Classes, error) {
	classes := []model.Classes{}
	if err := dal.DB.Find(&classes, "school_id = ?", id).Error; err != nil {
		return nil, err
	}
	return classes, nil
}

// FindAll implements SchoolRepository.
func (schoolRepositoryImpl) FindAll(output interface{}) (interface{}, error) {
	if err := dal.DB.Find(output).Error; err != nil {
		return nil, err
	}
	return output, nil
}

// FindById implements SchoolRepository.
func (schoolRepositoryImpl) FindById(id string, output *interface{}) (*interface{}, error) {
	if err := dal.DB.First(output, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return output, nil
}

// AddTopic implements SchoolRepository.
func (schoolRepositoryImpl) AddTopic(topic *model.Topics) (*model.Topics, error) {
	if err := dal.DB.Create(topic).Error; err != nil {
		return nil, err
	}

	return topic, nil
}

// DeleteTopic implements SchoolRepository.
func (schoolRepositoryImpl) DeleteTopic(topicId string) error {
	db := dal.DB.Where("id = ?", topicId).Delete(&model.Schools{})

	return db.Error
}

// Add implements SchoolRepository.
func (schoolRepositoryImpl) Add(school *model.Schools) (*model.Schools, error) {
	if err := dal.DB.Create(school).Error; err != nil {
		return nil, err
	}

	return school, nil
}

// AddClass implements SchoolRepository.
func (schoolRepositoryImpl) AddClass(class *model.Classes) (*model.Classes, error) {
	if err := dal.DB.Create(class).Error; err != nil {
		return nil, err
	}

	return class, nil
}

// Delete implements SchoolRepository.
func (schoolRepositoryImpl) Delete(schoolId string) error {
	db := dal.DB.Where("id = ?", schoolId).Delete(&model.Schools{})

	return db.Error
}

// DeleteClass implements SchoolRepository.
func (schoolRepositoryImpl) DeleteClass(classId string) error {
	db := dal.DB.Where("id = ?", classId).Delete(&model.Classes{})

	return db.Error
}

func NewSchoolRepository() SchoolRepository {
	return schoolRepositoryImpl{}
}
