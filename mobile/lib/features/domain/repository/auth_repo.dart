import 'package:commath/features/core/state/data_state.dart';
import 'package:commath/features/domain/entity/class_entity.dart';
import 'package:commath/features/domain/entity/school_entity.dart';
import 'package:commath/features/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<bool> isLogedIn();
  DataState<UserEntity> login(String username, String password);
  DataState<UserEntity> getAndUpdateUser();
  DataState<UserEntity> getUser();
  DataState<List<SchoolEntity>> getAllSchool();
  DataState<List<ClassEntity>> getAllSchoolClass(String schoolId);
  DataState<bool> register({
    required String username,
    required String name,
    required String password,
    required String confPassword,
    required String classId,
  });
  Future<void> logout();
}
