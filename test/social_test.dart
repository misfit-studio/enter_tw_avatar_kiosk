import 'package:enter_bravo_kiosk/models/questionnaire.dart';
import 'package:test/test.dart';

List<Questionnaire> generateAll() {
  final questionnaires = <Questionnaire>[];
  for (InterestType i in InterestType.values) {
    for (Generation g in Generation.values) {
      for (Proficiency p in Proficiency.values) {
        for (Assessment a in Assessment.values) {
          for (Broadness b in Broadness.values) {
            for (Reliance r in Reliance.values) {
              for (Presenation pr in Presenation.values) {
                questionnaires.add(Questionnaire(
                  interestType: i,
                  generation: g,
                  proficiency: p,
                  assessment: a,
                  broadness: b,
                  reliance: r,
                  presentation: pr,
                ));
              }
            }
          }
        }
      }
    }
  }
  return questionnaires;
}

void main() {
  test('Questionnaire serialization', () {
    final all = generateAll();
    for (final q in all) {
      final str = q.encodeBinary();
      final decoded = Questionnaire.fromBinaryString(str);

      print("$q -> $str -> $decoded");
      expect(decoded, q);
    }

    expect(true, true);
  });
}
