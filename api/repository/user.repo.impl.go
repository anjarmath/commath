package repository

import (
	"github.com/anjarmath/jago/dal"
	"github.com/anjarmath/jago/model"
)

type userRepositoryImpl struct{}

// FindAdminById implements UserRepository.
func (userRepositoryImpl) FindAdminById(id string) (*model.Admins, error) {
	admin := &model.Admins{}
	if err := dal.DB.First(&admin, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return admin, nil
}

// FindAdminByUsername implements UserRepository.
func (userRepositoryImpl) FindAdminByUsername(username string) (*model.Admins, error) {
	admin := &model.Admins{}
	if err := dal.DB.First(&admin, "username = ?", username).Error; err != nil {
		return nil, err
	}
	return admin, nil
}

// FindUserByUsername implements UserRepository.
func (userRepositoryImpl) FindUserByUsername(username string) (*model.Users, error) {
	user := &model.Users{}
	if err := dal.DB.First(&user, "username = ?", username).Error; err != nil {
		return nil, err
	}
	return user, nil
}

// CreateAdmin implements AuthRepository.
func (userRepositoryImpl) CreateAdmin(admin *model.Admins) (model.Admins, error) {
	db := dal.DB.Create(admin)
	return *admin, db.Error
}

// CreateUser implements AuthRepository.
func (userRepositoryImpl) CreateUser(user *model.Users) (model.Users, error) {
	db := dal.DB.Create(user)
	return *user, db.Error
}

// DeleteUser implements AuthRepository.
func (userRepositoryImpl) DeleteUser(id string) error {
	db := dal.DB.Where("id = ?", id).Delete(&model.Users{})

	return db.Error
}

// FindAllUser implements AuthRepository.
func (userRepositoryImpl) FindAllUser() ([]model.Users, error) {
	var users []model.Users
	if err := dal.DB.Find(&users).Error; err != nil {
		return nil, err
	}
	return users, nil
}

// FindUserById implements AuthRepository.
func (userRepositoryImpl) FindUserById(id string) (*model.Users, error) {
	user := &model.Users{}
	if err := dal.DB.First(&user, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return user, nil
}

// UpdateUser implements AuthRepository.
func (userRepositoryImpl) UpdateUser(id string, updatedUser *model.Users) (*model.Users, error) {
	user := &model.Users{}
	if err := dal.DB.First(&user, "id = ?", id).Error; err != nil {
		return nil, err
	}
	user.Name = updatedUser.Name
	user.Class = updatedUser.Class

	if err := dal.DB.Save(&user).Error; err != nil {
		return nil, err
	}

	return user, nil
}

func (userRepositoryImpl) AddUserStar(id string) (*model.Users, error) {
	user := &model.Users{}
	if err := dal.DB.First(&user, "id = ?", id).Error; err != nil {
		return nil, err
	}
	user.Stars++
	if err := dal.DB.Save(&user).Error; err != nil {
		return nil, err
	}

	return user, nil
}

func NewUserRepositoryImpl() UserRepository {
	return userRepositoryImpl{}
}
