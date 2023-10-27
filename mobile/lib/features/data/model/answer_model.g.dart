// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnswerModelImpl _$$AnswerModelImplFromJson(Map<String, dynamic> json) =>
    _$AnswerModelImpl(
      id: json['id'] as String,
      user_id: json['user_id'] as String,
      exam_id: json['exam_id'] as String,
      diketahui: json['diketahui'] as String,
      ditanya: json['ditanya'] as String,
      jawab: json['jawab'] as String,
      kesimpulan: json['kesimpulan'] as String,
      feedback: json['feedback'] as String?,
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$$AnswerModelImplToJson(_$AnswerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'exam_id': instance.exam_id,
      'diketahui': instance.diketahui,
      'ditanya': instance.ditanya,
      'jawab': instance.jawab,
      'kesimpulan': instance.kesimpulan,
      'feedback': instance.feedback,
      'created_at': instance.created_at,
    };
