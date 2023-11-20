import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intl_provider.g.dart';

enum Language {
  de,
  en,
  fr,
}

const Map<String, String> _stringsDe = {
  'question_assessment_title': 'Welche Gefühle wecken wir in dir?',
  'question_broadness_title': 'Was kommt in unser Fotoalbum?',
  'question_generation_title': 'An wen von uns erinnerst du dich?',
  'question_interest_type_title': 'Mit wem verbringst du am liebsten Zeit?',
  'question_presentation_title': 'Wo bin ich, wenn du Gäste hast?',
  'question_proficiency_title': 'Durch wen kennst du uns?',
  'question_proficiency_label_me': 'ICH',
  'question_proficiency_label_family': 'FAMILIE',
  'question_proficiency_label_friends': 'FREUNDE',
  'question_proficiency_label_life': 'LEBEN',
  'question_reliance_title': 'Wann sind wir dir zu viel?',
  'dialog_restart_title': 'Möchtest du wirklich neu starten?',
  'dialog_restart_description':
      'Dadurch werden alle bisherigen Antworten gelöscht und du musst von vorne beginnen.',
  'button_restart_yes': 'Neustart',
  'button_restart_cancel': 'Weitermachen',
  'button_next': 'Weiter',
};

const Map<String, String> _stringsEn = {
  'question_assessment_title': 'What feelings do we evoke in you?',
  'question_broadness_title': 'What goes into our photo album?',
  'question_generation_title': 'Who of us do you remember?',
  'question_interest_type_title': 'Who do you prefer to spend time with?',
  'question_presentation_title': 'Where am I when you have guests?',
  'question_proficiency_title': 'Who do you know us through?',
  'question_proficiency_label_me': 'ME',
  'question_proficiency_label_family': 'FAMILY',
  'question_proficiency_label_friends': 'FRIENDS',
  'question_proficiency_label_life': 'LIFE',
  'question_reliance_title': 'When are we too much for you?',
  'dialog_restart_title': 'Do you really want to restart?',
  'dialog_restart_description':
      'This will delete all previous answers and you will have to start over.',
  'button_restart_yes': 'Restart',
  'button_restart_cancel': 'Continue',
  'button_next': 'Next',
};

const Map<String, String> _stringsFr = {
  'question_assessment_title': 'Quels sentiments on te fait ressentir?',
  'question_broadness_title': "Qu'on met dans notre album photo?",
  'question_generation_title': 'Tu te souviens de qui parmi nous?',
  'question_interest_type_title': 'Avec qui tu préfères passer du temps?',
  'question_presentation_title': 'Je suis où quand tu as des invités?',
  'question_proficiency_title': 'Tu nous connais par qui?',
  'question_proficiency_label_me': 'MOI',
  'question_proficiency_label_family': 'FAMILLE',
  'question_proficiency_label_friends': 'POTES',
  'question_proficiency_label_life': 'VIE',
  'question_reliance_title': 'On est trop pour toi quand?',
  'dialog_restart_title': 'Tu veux vraiment tout recommencer?',
  'dialog_restart_description':
      'Ça va supprimer toutes tes réponses précédentes et tu devras tout recommencer.',
  'button_restart_yes': 'Recommencer',
  'button_restart_cancel': 'Continuer',
  'button_next': 'Suivant',
};

@Riverpod(keepAlive: true)
class SelectedLanguage extends _$SelectedLanguage {
  @override
  Language build() {
    return Language.de;
  }

  void setLanguage(Language language) {
    state = language;
  }
}

@riverpod
Map<String, String> intlStrings(IntlStringsRef ref) {
  final language = ref.watch(selectedLanguageProvider);
  return switch (language) {
    Language.de => _stringsDe,
    Language.en => _stringsEn,
    Language.fr => _stringsFr,
  };
}

@Riverpod(
  keepAlive: true,
)
class IntlNotifier extends _$IntlNotifier {
  Language _language = Language.de;

  Map<String, String> _getStrings(Language language) {
    switch (language) {
      case Language.de:
        return _stringsDe;
      case Language.en:
        return _stringsEn;
      case Language.fr:
        return _stringsFr;
      default:
        return _stringsDe;
    }
  }

  @override
  Map<String, String> build() {
    return _getStrings(_language);
  }

  Language get language => _language;

  void setLanguage(Language language) {
    _language = language;
    state = _getStrings(language);
  }
}
