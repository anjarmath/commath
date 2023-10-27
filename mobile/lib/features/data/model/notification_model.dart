// ignore_for_file: non_constant_identifier_names

import 'package:commath/features/domain/entity/notification_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel extends NotificationEntity with _$NotificationModel {
  factory NotificationModel({
    required String id,
    required String class_id,
    required String company_id,
    required String date,
    required String created_at,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
