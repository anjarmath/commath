import 'package:commath/features/domain/entity/school_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'school_model.freezed.dart';
part 'school_model.g.dart';

@freezed
class SchoolModel extends SchoolEntity with _$SchoolModel {
  factory SchoolModel({
    required String id,
    required String name,
  }) = _SchoolModel;

  factory SchoolModel.fromJson(Map<String, dynamic> json) =>
      _$SchoolModelFromJson(json);
}
