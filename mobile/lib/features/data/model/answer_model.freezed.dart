// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'answer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AnswerModel _$AnswerModelFromJson(Map<String, dynamic> json) {
  return _AnswerModel.fromJson(json);
}

/// @nodoc
mixin _$AnswerModel {
  String get id => throw _privateConstructorUsedError;
  String get user_id => throw _privateConstructorUsedError;
  String get exam_id => throw _privateConstructorUsedError;
  ExamModel get exam => throw _privateConstructorUsedError;
  String get diketahui => throw _privateConstructorUsedError;
  String get ditanya => throw _privateConstructorUsedError;
  String get jawab => throw _privateConstructorUsedError;
  String get kesimpulan => throw _privateConstructorUsedError;
  String? get feedback => throw _privateConstructorUsedError;
  String get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnswerModelCopyWith<AnswerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerModelCopyWith<$Res> {
  factory $AnswerModelCopyWith(
          AnswerModel value, $Res Function(AnswerModel) then) =
      _$AnswerModelCopyWithImpl<$Res, AnswerModel>;
  @useResult
  $Res call(
      {String id,
      String user_id,
      String exam_id,
      ExamModel exam,
      String diketahui,
      String ditanya,
      String jawab,
      String kesimpulan,
      String? feedback,
      String created_at});

  $ExamModelCopyWith<$Res> get exam;
}

/// @nodoc
class _$AnswerModelCopyWithImpl<$Res, $Val extends AnswerModel>
    implements $AnswerModelCopyWith<$Res> {
  _$AnswerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user_id = null,
    Object? exam_id = null,
    Object? exam = null,
    Object? diketahui = null,
    Object? ditanya = null,
    Object? jawab = null,
    Object? kesimpulan = null,
    Object? feedback = freezed,
    Object? created_at = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      exam_id: null == exam_id
          ? _value.exam_id
          : exam_id // ignore: cast_nullable_to_non_nullable
              as String,
      exam: null == exam
          ? _value.exam
          : exam // ignore: cast_nullable_to_non_nullable
              as ExamModel,
      diketahui: null == diketahui
          ? _value.diketahui
          : diketahui // ignore: cast_nullable_to_non_nullable
              as String,
      ditanya: null == ditanya
          ? _value.ditanya
          : ditanya // ignore: cast_nullable_to_non_nullable
              as String,
      jawab: null == jawab
          ? _value.jawab
          : jawab // ignore: cast_nullable_to_non_nullable
              as String,
      kesimpulan: null == kesimpulan
          ? _value.kesimpulan
          : kesimpulan // ignore: cast_nullable_to_non_nullable
              as String,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ExamModelCopyWith<$Res> get exam {
    return $ExamModelCopyWith<$Res>(_value.exam, (value) {
      return _then(_value.copyWith(exam: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AnswerModelImplCopyWith<$Res>
    implements $AnswerModelCopyWith<$Res> {
  factory _$$AnswerModelImplCopyWith(
          _$AnswerModelImpl value, $Res Function(_$AnswerModelImpl) then) =
      __$$AnswerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String user_id,
      String exam_id,
      ExamModel exam,
      String diketahui,
      String ditanya,
      String jawab,
      String kesimpulan,
      String? feedback,
      String created_at});

  @override
  $ExamModelCopyWith<$Res> get exam;
}

/// @nodoc
class __$$AnswerModelImplCopyWithImpl<$Res>
    extends _$AnswerModelCopyWithImpl<$Res, _$AnswerModelImpl>
    implements _$$AnswerModelImplCopyWith<$Res> {
  __$$AnswerModelImplCopyWithImpl(
      _$AnswerModelImpl _value, $Res Function(_$AnswerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user_id = null,
    Object? exam_id = null,
    Object? exam = null,
    Object? diketahui = null,
    Object? ditanya = null,
    Object? jawab = null,
    Object? kesimpulan = null,
    Object? feedback = freezed,
    Object? created_at = null,
  }) {
    return _then(_$AnswerModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      exam_id: null == exam_id
          ? _value.exam_id
          : exam_id // ignore: cast_nullable_to_non_nullable
              as String,
      exam: null == exam
          ? _value.exam
          : exam // ignore: cast_nullable_to_non_nullable
              as ExamModel,
      diketahui: null == diketahui
          ? _value.diketahui
          : diketahui // ignore: cast_nullable_to_non_nullable
              as String,
      ditanya: null == ditanya
          ? _value.ditanya
          : ditanya // ignore: cast_nullable_to_non_nullable
              as String,
      jawab: null == jawab
          ? _value.jawab
          : jawab // ignore: cast_nullable_to_non_nullable
              as String,
      kesimpulan: null == kesimpulan
          ? _value.kesimpulan
          : kesimpulan // ignore: cast_nullable_to_non_nullable
              as String,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnswerModelImpl implements _AnswerModel {
  _$AnswerModelImpl(
      {required this.id,
      required this.user_id,
      required this.exam_id,
      required this.exam,
      required this.diketahui,
      required this.ditanya,
      required this.jawab,
      required this.kesimpulan,
      this.feedback,
      required this.created_at});

  factory _$AnswerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnswerModelImplFromJson(json);

  @override
  final String id;
  @override
  final String user_id;
  @override
  final String exam_id;
  @override
  final ExamModel exam;
  @override
  final String diketahui;
  @override
  final String ditanya;
  @override
  final String jawab;
  @override
  final String kesimpulan;
  @override
  final String? feedback;
  @override
  final String created_at;

  @override
  String toString() {
    return 'AnswerModel(id: $id, user_id: $user_id, exam_id: $exam_id, exam: $exam, diketahui: $diketahui, ditanya: $ditanya, jawab: $jawab, kesimpulan: $kesimpulan, feedback: $feedback, created_at: $created_at)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.exam_id, exam_id) || other.exam_id == exam_id) &&
            (identical(other.exam, exam) || other.exam == exam) &&
            (identical(other.diketahui, diketahui) ||
                other.diketahui == diketahui) &&
            (identical(other.ditanya, ditanya) || other.ditanya == ditanya) &&
            (identical(other.jawab, jawab) || other.jawab == jawab) &&
            (identical(other.kesimpulan, kesimpulan) ||
                other.kesimpulan == kesimpulan) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, user_id, exam_id, exam,
      diketahui, ditanya, jawab, kesimpulan, feedback, created_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerModelImplCopyWith<_$AnswerModelImpl> get copyWith =>
      __$$AnswerModelImplCopyWithImpl<_$AnswerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnswerModelImplToJson(
      this,
    );
  }
}

abstract class _AnswerModel implements AnswerModel {
  factory _AnswerModel(
      {required final String id,
      required final String user_id,
      required final String exam_id,
      required final ExamModel exam,
      required final String diketahui,
      required final String ditanya,
      required final String jawab,
      required final String kesimpulan,
      final String? feedback,
      required final String created_at}) = _$AnswerModelImpl;

  factory _AnswerModel.fromJson(Map<String, dynamic> json) =
      _$AnswerModelImpl.fromJson;

  @override
  String get id;
  @override
  String get user_id;
  @override
  String get exam_id;
  @override
  ExamModel get exam;
  @override
  String get diketahui;
  @override
  String get ditanya;
  @override
  String get jawab;
  @override
  String get kesimpulan;
  @override
  String? get feedback;
  @override
  String get created_at;
  @override
  @JsonKey(ignore: true)
  _$$AnswerModelImplCopyWith<_$AnswerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
