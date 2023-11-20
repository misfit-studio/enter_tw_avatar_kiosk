import 'package:freezed_annotation/freezed_annotation.dart';

part 'questionnaire.freezed.dart';
part 'questionnaire.g.dart';

enum InterestType {
  play,
  utility,
  creativity,
}

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

enum Assessment {
  interested,
  neutral,
  averted,
}

enum Broadness {
  limited,
  diverse,
  broad,
}

enum Reliance {
  low,
  moderate,
  high,
}

enum Presenation {
  none,
  low,
  moderate,
  high,
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

  @override
  String toString() {
    return "Questionnaire([$interestType/$generation] - $proficiency | $assessment | $broadness | $reliance | $presentation)";
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
}
