package repository

import "github.com/anjarmath/jago/model"

type UserRepository interface {
	CreateUser(user *model.Users) (model.Users, error)
	FindAllUser() ([]model.Users, error)
	FindUserById(id string) (*model.Users, error)
	FindUserByUsername(username string) (*model.Users, error)
	UpdateUser(id string, updatedUser *model.Users) (*model.Users, error)
	AddUserStar(id string) (*model.Users, error)
	DeleteUser(id string) error

	CreateAdmin(admin *model.Admins) (model.Admins, error)
	FindAdminById(id string) (*model.Admins, error)
	FindAdminByUsername(username string) (*model.Admins, error)
}
