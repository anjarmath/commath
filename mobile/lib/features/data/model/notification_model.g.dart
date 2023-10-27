// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: json['id'] as String,
      class_id: json['class_id'] as String,
      company_id: json['company_id'] as String,
      date: json['date'] as String,
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'class_id': instance.class_id,
      'company_id': instance.company_id,
      'date': instance.date,
      'created_at': instance.created_at,
    };
