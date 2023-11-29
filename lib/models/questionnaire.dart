import 'package:freezed_annotation/freezed_annotation.dart';

part 'questionnaire.freezed.dart';
part 'questionnaire.g.dart';

enum InterestType {
  play,
  utility,
  creativity,
}

extension InterestTypeExtension on InterestType {}

enum Generation {
  babyboomer,
  genX,
  genY,
  genZ,
}

extension GenerationExtension on Generation {
  int get cutoffYear => switch (this) {
        Generation.babyboomer => 1900,
        Generation.genX => 1964,
        Generation.genY => 1985,
        Generation.genZ => 1997,
      };
}

enum Proficiency {
  casual,
  interested,
  nerd,
}

extension ProficiencyExtension on Proficiency {
  int get points => switch (this) {
        Proficiency.casual => 1,
        Proficiency.interested => 2,
        Proficiency.nerd => 3,
      };
}

enum Assessment {
  averted,
  neutral,
  interested,
}

extension AssessmentExtension on Assessment {
  int get points => switch (this) {
        Assessment.averted => 1,
        Assessment.neutral => 2,
        Assessment.interested => 3,
      };
}

enum Broadness {
  limited,
  diverse,
  broad,
}

extension BroadnessExtension on Broadness {
  int get points => switch (this) {
        Broadness.limited => 1,
        Broadness.diverse => 2,
        Broadness.broad => 3,
      };
}

enum Reliance {
  low,
  moderate,
  high,
}

extension RelianceExtension on Reliance {
  int get points => switch (this) {
        Reliance.low => 1,
        Reliance.moderate => 2,
        Reliance.high => 3,
      };
}

enum Presenation {
  none,
  low,
  moderate,
  high,
}

extension PresenationExtension on Presenation {
  int get points => switch (this) {
        Presenation.none => 0,
        Presenation.low => 1,
        Presenation.moderate => 2,
        Presenation.high => 3,
      };
}

enum TechType {
  skeptic,
  collector,
  influencer,
  practical,
  enthusiast,
}

@freezed
class Questionnaire with _$Questionnaire {
  const factory Questionnaire({
    Generation? generation,
    InterestType? interestType,
    Proficiency? proficiency,
    Assessment? assessment,
    Broadness? broadness,
    Reliance? reliance,
    Presenation? presentation,
  }) = _Questionnaire;

  const Questionnaire._();

  factory Questionnaire.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireFromJson(json);

  factory Questionnaire.fromBinaryString(String str) {
    final binary = int.parse(str, radix: 16);
    final generation = Generation.values[(binary >> 12) & 0x3];
    final interestType = InterestType.values[(binary >> 10) & 0x3];
    final proficiency = Proficiency.values[(binary >> 8) & 0x3];
    final assessment = Assessment.values[(binary >> 6) & 0x3];
    final broadness = Broadness.values[(binary >> 4) & 0x3];
    final reliance = Reliance.values[(binary >> 2) & 0x3];
    final presentation = Presenation.values[(binary >> 0) & 0x3];

    return Questionnaire(
      generation: generation,
      interestType: interestType,
      proficiency: proficiency,
      assessment: assessment,
      broadness: broadness,
      reliance: reliance,
      presentation: presentation,
    );
  }

  @override
  String toString() {
    return "Questionnaire([$interestType/$generation] - $proficiency | $assessment | $broadness | $reliance | $presentation)";
  }

  String encodeBinary() {
    if (!isCompleted) {
      throw Exception('Questionnaire is not completed');
    }

    final binary = (generation!.index << 12) |
        (interestType!.index << 10) |
        (proficiency!.index << 8) |
        (assessment!.index << 6) |
        (broadness!.index << 4) |
        (reliance!.index << 2) |
        (presentation!.index << 0);

    return binary.toRadixString(16).toUpperCase();
  }

  int get questionIndex {
    if (generation == null) return 0;
    if (interestType == null) return 1;
    if (proficiency == null) return 2;
    if (assessment == null) return 3;
    if (broadness == null) return 4;
    if (reliance == null) return 5;
    if (presentation == null) return 6;
    return -1;
  }

  bool get isCompleted {
    return interestType != null &&
        generation != null &&
        proficiency != null &&
        assessment != null &&
        broadness != null &&
        reliance != null &&
        presentation != null;
  }

  int get totalPoints {
    return proficiency!.points +
        assessment!.points +
        broadness!.points +
        reliance!.points +
        presentation!.points;
  }

  TechType get techType {
    if (totalPoints <= 3) return TechType.skeptic;
    if (totalPoints <= 6) return TechType.collector;
    if (totalPoints <= 9) return TechType.influencer;
    if (totalPoints <= 12) return TechType.practical;
    return TechType.enthusiast;
  }
}
