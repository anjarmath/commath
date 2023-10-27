// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExamModel _$ExamModelFromJson(Map<String, dynamic> json) {
  return _ExamModel.fromJson(json);
}

/// @nodoc
mixin _$ExamModel {
  String get id => throw _privateConstructorUsedError;
  String get company_id => throw _privateConstructorUsedError;
  String get topic_id => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExamModelCopyWith<ExamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExamModelCopyWith<$Res> {
  factory $ExamModelCopyWith(ExamModel value, $Res Function(ExamModel) then) =
      _$ExamModelCopyWithImpl<$Res, ExamModel>;
  @useResult
  $Res call({String id, String company_id, String topic_id, String question});
}

/// @nodoc
class _$ExamModelCopyWithImpl<$Res, $Val extends ExamModel>
    implements $ExamModelCopyWith<$Res> {
  _$ExamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? company_id = null,
    Object? topic_id = null,
    Object? question = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      company_id: null == company_id
          ? _value.company_id
          : company_id // ignore: cast_nullable_to_non_nullable
              as String,
      topic_id: null == topic_id
          ? _value.topic_id
          : topic_id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExamModelImplCopyWith<$Res>
    implements $ExamModelCopyWith<$Res> {
  factory _$$ExamModelImplCopyWith(
          _$ExamModelImpl value, $Res Function(_$ExamModelImpl) then) =
      __$$ExamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String company_id, String topic_id, String question});
}

/// @nodoc
class __$$ExamModelImplCopyWithImpl<$Res>
    extends _$ExamModelCopyWithImpl<$Res, _$ExamModelImpl>
    implements _$$ExamModelImplCopyWith<$Res> {
  __$$ExamModelImplCopyWithImpl(
      _$ExamModelImpl _value, $Res Function(_$ExamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? company_id = null,
    Object? topic_id = null,
    Object? question = null,
  }) {
    return _then(_$ExamModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      company_id: null == company_id
          ? _value.company_id
          : company_id // ignore: cast_nullable_to_non_nullable
              as String,
      topic_id: null == topic_id
          ? _value.topic_id
          : topic_id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExamModelImpl implements _ExamModel {
  _$ExamModelImpl(
      {required this.id,
      required this.company_id,
      required this.topic_id,
      required this.question});

  factory _$ExamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExamModelImplFromJson(json);

  @override
  final String id;
  @override
  final String company_id;
  @override
  final String topic_id;
  @override
  final String question;

  @override
  String toString() {
    return 'ExamModel(id: $id, company_id: $company_id, topic_id: $topic_id, question: $question)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.company_id, company_id) ||
                other.company_id == company_id) &&
            (identical(other.topic_id, topic_id) ||
                other.topic_id == topic_id) &&
            (identical(other.question, question) ||
                other.question == question));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, company_id, topic_id, question);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExamModelImplCopyWith<_$ExamModelImpl> get copyWith =>
      __$$ExamModelImplCopyWithImpl<_$ExamModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExamModelImplToJson(
      this,
    );
  }
}

abstract class _ExamModel implements ExamModel {
  factory _ExamModel(
      {required final String id,
      required final String company_id,
      required final String topic_id,
      required final String question}) = _$ExamModelImpl;

  factory _ExamModel.fromJson(Map<String, dynamic> json) =
      _$ExamModelImpl.fromJson;

  @override
  String get id;
  @override
  String get company_id;
  @override
  String get topic_id;
  @override
  String get question;
  @override
  @JsonKey(ignore: true)
  _$$ExamModelImplCopyWith<_$ExamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
