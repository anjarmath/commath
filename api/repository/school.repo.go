package repository

import "github.com/anjarmath/jago/model"

type SchoolRepository interface {
	Add(school *model.Schools) (*model.Schools, error)
	Delete(schoolId string) error
	AddClass(class *model.Classes) (*model.Classes, error)
	DeleteClass(classId string) error
	AddTopic(topic *model.Topics) (*model.Topics, error)
	DeleteTopic(topicId string) error
	FindAll(output interface{}) (interface{}, error)
	FindById(id string, output *interface{}) (*interface{}, error)
	FindClassBySchoolId(id string) ([]model.Classes, error)
}
