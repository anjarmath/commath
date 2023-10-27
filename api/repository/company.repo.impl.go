package repository

import (
	"github.com/anjarmath/jago/dal"
	"github.com/anjarmath/jago/model"
)

type companyRepositoryImpl struct{}

// Deactivate implements CompanyRepository.
func (*companyRepositoryImpl) Deactivate(id string) (*model.Companies, error) {
	company := &model.Companies{}
	if err := dal.DB.First(&company, "id = ?", id).Error; err != nil {
		return nil, err
	}
	*company.Verified = false
	if err := dal.DB.Save(&company).Error; err != nil {
		return nil, err
	}

	return company, nil
}

// FindByUsername implements CompanyRepository.
func (*companyRepositoryImpl) FindByUsername(username string) (*model.Companies, error) {
	company := &model.Companies{}
	if err := dal.DB.First(&company, "username = ?", username).Error; err != nil {
		return nil, err
	}
	return company, nil
}

// Activate implements CompanyRepository.
func (*companyRepositoryImpl) Activate(id string) (*model.Companies, error) {
	company := &model.Companies{}
	if err := dal.DB.First(&company, "id = ?", id).Error; err != nil {
		return nil, err
	}
	*company.Verified = true
	if err := dal.DB.Save(&company).Error; err != nil {
		return nil, err
	}

	return company, nil
}

// Create implements CompanyRepository.
func (*companyRepositoryImpl) Create(company *model.Companies) (model.Companies, error) {
	db := dal.DB.Create(company)
	return *company, db.Error
}

// Delete implements CompanyRepository.
func (*companyRepositoryImpl) Delete(id string) error {
	db := dal.DB.Where("id = ?", id).Delete(&model.Companies{})

	return db.Error
}

// FindAll implements CompanyRepository.
func (*companyRepositoryImpl) FindAll() ([]model.Companies, error) {
	var companies []model.Companies
	if err := dal.DB.Find(&companies).Error; err != nil {
		return nil, err
	}
	return companies, nil
}

// FindById implements CompanyRepository.
func (*companyRepositoryImpl) FindById(id string) (*model.Companies, error) {
	company := &model.Companies{}
	if err := dal.DB.First(&company, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return company, nil
}

// Update implements CompanyRepository.
func (*companyRepositoryImpl) Update(id string, updatedCompany *model.Companies) (*model.Companies, error) {
	company := &model.Companies{}
	if err := dal.DB.First(&company, "id = ?", id).Error; err != nil {
		return nil, err
	}
	company.Name = updatedCompany.Name
	company.Description = updatedCompany.Description
	company.Problem = updatedCompany.Problem

	if err := dal.DB.Save(&company).Error; err != nil {
		return nil, err
	}

	return company, nil
}

func NewCompanyRepository() CompanyRepository {
	return &companyRepositoryImpl{}
}
