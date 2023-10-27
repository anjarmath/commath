// ignore_for_file: non_constant_identifier_names

import 'package:commath/features/domain/entity/class_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_model.freezed.dart';
part 'class_model.g.dart';

@freezed
class ClassModel extends ClassEntity with _$ClassModel {
  factory ClassModel({
    required String id,
    required String name,
    required String school_id,
  }) = _ClassModel;

  factory ClassModel.fromJson(Map<String, dynamic> json) =>
      _$ClassModelFromJson(json);
}
