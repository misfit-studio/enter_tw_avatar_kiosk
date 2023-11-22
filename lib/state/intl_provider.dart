import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intl_provider.g.dart';

enum Language {
  de,
  en,
  fr,
}

const Map<String, String> _stringsDe = {
  'question_assessment_title': 'Welche Gefühle wecken wir in dir?',
  'question_assessment_img_message':
      'assets/images/assessment/assessment_message_de.png',
  'question_assessment_img_noti':
      'assets/images/assessment/assessment_noti_de.png',
  'question_assessment_img_paper':
      'assets/images/assessment/assessment_paper_de.png',
  'question_assessment_img_sticky':
      'assets/images/assessment/assessment_sticky_de.png',
  'question_assessment_img_tweet':
      'assets/images/assessment/assessment_tweet_de.png',
  'question_broadness_title': 'Was kommt in unser Fotoalbum?',
  'question_generation_title': 'An wen von uns erinnerst du dich?',
  'question_interest_type_title': 'Mit wem verbringst du am liebsten Zeit?',
  'question_presentation_title': 'Wo bin ich, wenn du Gäste hast?',
  'question_presentation_label_off': 'AUSGESCHALTET',
  'question_presentation_label_otherroom': 'NEBENZIMMER',
  'question_presentation_label_sameroom': 'GLEICHER RAUM',
  'question_presentation_label_withme': 'BEI MIR',
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
  'result_title': 'Dein Technik-Typ',
  'play_skeptic': 'play_skeptic',
  'play_collector': 'play_collector',
  'play_influencer': 'play_influencer',
  'play_practical': 'play_practical',
  'play_enthusiast': 'play_enthusiast',
  'utility_skeptic': 'utility_skeptic',
  'utility_collector': 'utility_collector',
  'utility_influencer': 'utility_influencer',
  'utility_practical': 'utility_practical',
  'utility_enthusiast': 'utility_enthusiast',
  'creativity_skeptic': 'creativity_skeptic',
  'creativity_collector': 'creativity_collector',
  'creativity_influencer': 'creativity_influencer',
  'creativity_practical': 'creativity_practical',
  'creativity_enthusiast': 'creativity_enthusiast',
};

const Map<String, String> _stringsEn = {
  'question_assessment_title': 'What feelings do we evoke in you?',
  'question_assessment_img_message':
      'assets/images/assessment/assessment_message_en.png',
  'question_assessment_img_noti':
      'assets/images/assessment/assessment_noti_en.png',
  'question_assessment_img_paper':
      'assets/images/assessment/assessment_paper_en.png',
  'question_assessment_img_sticky':
      'assets/images/assessment/assessment_sticky_en.png',
  'question_assessment_img_tweet':
      'assets/images/assessment/assessment_tweet_en.png',
  'question_broadness_title': 'What goes into our photo album?',
  'question_generation_title': 'Who of us do you remember?',
  'question_interest_type_title': 'Who do you prefer to spend time with?',
  'question_presentation_title': 'Where am I when you have guests?',
  'question_presentation_label_off': 'TURNED OFF',
  'question_presentation_label_otherroom': 'OTHER ROOM',
  'question_presentation_label_sameroom': 'SAME ROOM',
  'question_presentation_label_withme': 'WITH ME',
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
  'result_title': 'Your tech type',
  'play_skeptic': 'play_skeptic',
  'play_collector': 'play_collector',
  'play_influencer': 'play_influencer',
  'play_practical': 'play_practical',
  'play_enthusiast': 'play_enthusiast',
  'utility_skeptic': 'utility_skeptic',
  'utility_collector': 'utility_collector',
  'utility_influencer': 'utility_influencer',
  'utility_practical': 'utility_practical',
  'utility_enthusiast': 'utility_enthusiast',
  'creativity_skeptic': 'creativity_skeptic',
  'creativity_collector': 'creativity_collector',
  'creativity_influencer': 'creativity_influencer',
  'creativity_practical': 'creativity_practical',
  'creativity_enthusiast': 'creativity_enthusiast',
};

const Map<String, String> _stringsFr = {
  'question_assessment_title': 'Quels sentiments on te fait ressentir?',
  'question_assessment_img_message':
      'assets/images/assessment/assessment_message_fr.png',
  'question_assessment_img_noti':
      'assets/images/assessment/assessment_noti_fr.png',
  'question_assessment_img_paper':
      'assets/images/assessment/assessment_paper_fr.png',
  'question_assessment_img_sticky':
      'assets/images/assessment/assessment_sticky_fr.png',
  'question_assessment_img_tweet':
      'assets/images/assessment/assessment_tweet_fr.png',
  'question_broadness_title': "Qu'on met dans notre album photo?",
  'question_generation_title': 'Tu te souviens de qui parmi nous?',
  'question_interest_type_title': 'Avec qui tu préfères passer du temps?',
  'question_presentation_title': 'Je suis où quand tu as des invités?',
  'question_presentation_label_off': 'ÉTEINT',
  'question_presentation_label_otherroom': 'AUTRE PIÈCE',
  'question_presentation_label_sameroom': 'MÊME PIÈCE',
  'question_presentation_label_withme': 'AVEC MOI',
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
  'result_title': 'Ton type de technologie',
  'play_skeptic': 'play_skeptic',
  'play_collector': 'play_collector',
  'play_influencer': 'play_influencer',
  'play_practical': 'play_practical',
  'play_enthusiast': 'play_enthusiast',
  'utility_skeptic': 'utility_skeptic',
  'utility_collector': 'utility_collector',
  'utility_influencer': 'utility_influencer',
  'utility_practical': 'utility_practical',
  'utility_enthusiast': 'utility_enthusiast',
  'creativity_skeptic': 'creativity_skeptic',
  'creativity_collector': 'creativity_collector',
  'creativity_influencer': 'creativity_influencer',
  'creativity_practical': 'creativity_practical',
  'creativity_enthusiast': 'creativity_enthusiast',
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
