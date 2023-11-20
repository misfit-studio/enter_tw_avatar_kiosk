// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'questionnaire.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Questionnaire _$QuestionnaireFromJson(Map<String, dynamic> json) {
  return _Questionnaire.fromJson(json);
}

/// @nodoc
mixin _$Questionnaire {
  Generation? get generation => throw _privateConstructorUsedError;
  InterestType? get interestType => throw _privateConstructorUsedError;
  Proficiency? get proficiency => throw _privateConstructorUsedError;
  Assessment? get assessment => throw _privateConstructorUsedError;
  Broadness? get broadness => throw _privateConstructorUsedError;
  Reliance? get reliance => throw _privateConstructorUsedError;
  Presenation? get presentation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuestionnaireCopyWith<Questionnaire> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionnaireCopyWith<$Res> {
  factory $QuestionnaireCopyWith(
          Questionnaire value, $Res Function(Questionnaire) then) =
      _$QuestionnaireCopyWithImpl<$Res, Questionnaire>;
  @useResult
  $Res call(
      {Generation? generation,
      InterestType? interestType,
      Proficiency? proficiency,
      Assessment? assessment,
      Broadness? broadness,
      Reliance? reliance,
      Presenation? presentation});
}

/// @nodoc
class _$QuestionnaireCopyWithImpl<$Res, $Val extends Questionnaire>
    implements $QuestionnaireCopyWith<$Res> {
  _$QuestionnaireCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generation = freezed,
    Object? interestType = freezed,
    Object? proficiency = freezed,
    Object? assessment = freezed,
    Object? broadness = freezed,
    Object? reliance = freezed,
    Object? presentation = freezed,
  }) {
    return _then(_value.copyWith(
      generation: freezed == generation
          ? _value.generation
          : generation // ignore: cast_nullable_to_non_nullable
              as Generation?,
      interestType: freezed == interestType
          ? _value.interestType
          : interestType // ignore: cast_nullable_to_non_nullable
              as InterestType?,
      proficiency: freezed == proficiency
          ? _value.proficiency
          : proficiency // ignore: cast_nullable_to_non_nullable
              as Proficiency?,
      assessment: freezed == assessment
          ? _value.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as Assessment?,
      broadness: freezed == broadness
          ? _value.broadness
          : broadness // ignore: cast_nullable_to_non_nullable
              as Broadness?,
      reliance: freezed == reliance
          ? _value.reliance
          : reliance // ignore: cast_nullable_to_non_nullable
              as Reliance?,
      presentation: freezed == presentation
          ? _value.presentation
          : presentation // ignore: cast_nullable_to_non_nullable
              as Presenation?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestionnaireImplCopyWith<$Res>
    implements $QuestionnaireCopyWith<$Res> {
  factory _$$QuestionnaireImplCopyWith(
          _$QuestionnaireImpl value, $Res Function(_$QuestionnaireImpl) then) =
      __$$QuestionnaireImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Generation? generation,
      InterestType? interestType,
      Proficiency? proficiency,
      Assessment? assessment,
      Broadness? broadness,
      Reliance? reliance,
      Presenation? presentation});
}

/// @nodoc
class __$$QuestionnaireImplCopyWithImpl<$Res>
    extends _$QuestionnaireCopyWithImpl<$Res, _$QuestionnaireImpl>
    implements _$$QuestionnaireImplCopyWith<$Res> {
  __$$QuestionnaireImplCopyWithImpl(
      _$QuestionnaireImpl _value, $Res Function(_$QuestionnaireImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generation = freezed,
    Object? interestType = freezed,
    Object? proficiency = freezed,
    Object? assessment = freezed,
    Object? broadness = freezed,
    Object? reliance = freezed,
    Object? presentation = freezed,
  }) {
    return _then(_$QuestionnaireImpl(
      generation: freezed == generation
          ? _value.generation
          : generation // ignore: cast_nullable_to_non_nullable
              as Generation?,
      interestType: freezed == interestType
          ? _value.interestType
          : interestType // ignore: cast_nullable_to_non_nullable
              as InterestType?,
      proficiency: freezed == proficiency
          ? _value.proficiency
          : proficiency // ignore: cast_nullable_to_non_nullable
              as Proficiency?,
      assessment: freezed == assessment
          ? _value.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as Assessment?,
      broadness: freezed == broadness
          ? _value.broadness
          : broadness // ignore: cast_nullable_to_non_nullable
              as Broadness?,
      reliance: freezed == reliance
          ? _value.reliance
          : reliance // ignore: cast_nullable_to_non_nullable
              as Reliance?,
      presentation: freezed == presentation
          ? _value.presentation
          : presentation // ignore: cast_nullable_to_non_nullable
              as Presenation?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionnaireImpl extends _Questionnaire {
  const _$QuestionnaireImpl(
      {this.generation,
      this.interestType,
      this.proficiency,
      this.assessment,
      this.broadness,
      this.reliance,
      this.presentation})
      : super._();

  factory _$QuestionnaireImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionnaireImplFromJson(json);

  @override
  final Generation? generation;
  @override
  final InterestType? interestType;
  @override
  final Proficiency? proficiency;
  @override
  final Assessment? assessment;
  @override
  final Broadness? broadness;
  @override
  final Reliance? reliance;
  @override
  final Presenation? presentation;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionnaireImpl &&
            (identical(other.generation, generation) ||
                other.generation == generation) &&
            (identical(other.interestType, interestType) ||
                other.interestType == interestType) &&
            (identical(other.proficiency, proficiency) ||
                other.proficiency == proficiency) &&
            (identical(other.assessment, assessment) ||
                other.assessment == assessment) &&
            (identical(other.broadness, broadness) ||
                other.broadness == broadness) &&
            (identical(other.reliance, reliance) ||
                other.reliance == reliance) &&
            (identical(other.presentation, presentation) ||
                other.presentation == presentation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, generation, interestType,
      proficiency, assessment, broadness, reliance, presentation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionnaireImplCopyWith<_$QuestionnaireImpl> get copyWith =>
      __$$QuestionnaireImplCopyWithImpl<_$QuestionnaireImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionnaireImplToJson(
      this,
    );
  }
}

abstract class _Questionnaire extends Questionnaire {
  const factory _Questionnaire(
      {final Generation? generation,
      final InterestType? interestType,
      final Proficiency? proficiency,
      final Assessment? assessment,
      final Broadness? broadness,
      final Reliance? reliance,
      final Presenation? presentation}) = _$QuestionnaireImpl;
  const _Questionnaire._() : super._();

  factory _Questionnaire.fromJson(Map<String, dynamic> json) =
      _$QuestionnaireImpl.fromJson;

  @override
  Generation? get generation;
  @override
  InterestType? get interestType;
  @override
  Proficiency? get proficiency;
  @override
  Assessment? get assessment;
  @override
  Broadness? get broadness;
  @override
  Reliance? get reliance;
  @override
  Presenation? get presentation;
  @override
  @JsonKey(ignore: true)
  _$$QuestionnaireImplCopyWith<_$QuestionnaireImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
