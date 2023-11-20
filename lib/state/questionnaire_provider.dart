import 'package:enter_bravo_kiosk/models/questionnaire.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'questionnaire_provider.g.dart';

@Riverpod(
  keepAlive: true,
)
class QuestionnaireState extends _$QuestionnaireState {
  @override
  Questionnaire build() {
    return const Questionnaire();
  }

  void reset() {
    state = const Questionnaire();
  }

  void submitAnswer({
    InterestType? interestType,
    Generation? generation,
    Proficiency? proficiency,
    Assessment? assessment,
    Broadness? broadness,
    Reliance? reliance,
    Presenation? presentation,
  }) {
    state = state.copyWith(
      interestType: interestType ?? state.interestType,
      generation: generation ?? state.generation,
      proficiency: proficiency ?? state.proficiency,
      assessment: assessment ?? state.assessment,
      broadness: broadness ?? state.broadness,
      reliance: reliance ?? state.reliance,
      presentation: presentation ?? state.presentation,
    );
  }
}
