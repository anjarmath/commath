// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyModelImpl _$$CompanyModelImplFromJson(Map<String, dynamic> json) =>
    _$CompanyModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      profile: json['profile'] as String,
      cover: json['cover'] as String,
      description: json['description'] as String,
      problem: json['problem'] as String,
      verified: json['verified'] as bool,
    );

Map<String, dynamic> _$$CompanyModelImplToJson(_$CompanyModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile': instance.profile,
      'cover': instance.cover,
      'description': instance.description,
      'problem': instance.problem,
      'verified': instance.verified,
    };
