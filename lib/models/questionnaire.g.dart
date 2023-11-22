// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaire.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionnaireImpl _$$QuestionnaireImplFromJson(Map<String, dynamic> json) =>
    _$QuestionnaireImpl(
      generation: $enumDecodeNullable(_$GenerationEnumMap, json['generation']),
      interestType:
          $enumDecodeNullable(_$InterestTypeEnumMap, json['interestType']),
      proficiency:
          $enumDecodeNullable(_$ProficiencyEnumMap, json['proficiency']),
      assessment: $enumDecodeNullable(_$AssessmentEnumMap, json['assessment']),
      broadness: $enumDecodeNullable(_$BroadnessEnumMap, json['broadness']),
      reliance: $enumDecodeNullable(_$RelianceEnumMap, json['reliance']),
      presentation:
          $enumDecodeNullable(_$PresenationEnumMap, json['presentation']),
    );

Map<String, dynamic> _$$QuestionnaireImplToJson(_$QuestionnaireImpl instance) =>
    <String, dynamic>{
      'generation': _$GenerationEnumMap[instance.generation],
      'interestType': _$InterestTypeEnumMap[instance.interestType],
      'proficiency': _$ProficiencyEnumMap[instance.proficiency],
      'assessment': _$AssessmentEnumMap[instance.assessment],
      'broadness': _$BroadnessEnumMap[instance.broadness],
      'reliance': _$RelianceEnumMap[instance.reliance],
      'presentation': _$PresenationEnumMap[instance.presentation],
    };

const _$GenerationEnumMap = {
  Generation.babyboomer: 'babyboomer',
  Generation.genX: 'genX',
  Generation.genY: 'genY',
  Generation.genZ: 'genZ',
};

const _$InterestTypeEnumMap = {
  InterestType.play: 'play',
  InterestType.utility: 'utility',
  InterestType.creativity: 'creativity',
};

const _$ProficiencyEnumMap = {
  Proficiency.casual: 'casual',
  Proficiency.interested: 'interested',
  Proficiency.nerd: 'nerd',
};

const _$AssessmentEnumMap = {
  Assessment.averted: 'averted',
  Assessment.neutral: 'neutral',
  Assessment.interested: 'interested',
};

const _$BroadnessEnumMap = {
  Broadness.limited: 'limited',
  Broadness.diverse: 'diverse',
  Broadness.broad: 'broad',
};

const _$RelianceEnumMap = {
  Reliance.low: 'low',
  Reliance.moderate: 'moderate',
  Reliance.high: 'high',
};

const _$PresenationEnumMap = {
  Presenation.none: 'none',
  Presenation.low: 'low',
  Presenation.moderate: 'moderate',
  Presenation.high: 'high',
};
