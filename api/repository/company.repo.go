package repository

import "github.com/anjarmath/jago/model"

type CompanyRepository interface {
	Create(company *model.Companies) (model.Companies, error)
	FindAll() ([]model.Companies, error)
	FindById(id string) (*model.Companies, error)
	FindByUsername(username string) (*model.Companies, error)
	Update(id string, company *model.Companies) (*model.Companies, error)
	Activate(id string) (*model.Companies, error)
	Deactivate(id string) (*model.Companies, error)
	Delete(id string) error
}
