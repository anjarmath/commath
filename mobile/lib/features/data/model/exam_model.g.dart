// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExamModelImpl _$$ExamModelImplFromJson(Map<String, dynamic> json) =>
    _$ExamModelImpl(
      id: json['id'] as String,
      company_id: json['company_id'] as String,
      topic_id: json['topic_id'] as String,
      question: json['question'] as String,
    );

Map<String, dynamic> _$$ExamModelImplToJson(_$ExamModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.company_id,
      'topic_id': instance.topic_id,
      'question': instance.question,
    };
