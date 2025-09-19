// lib/providers/questionnaire_provider.dart

import 'package:flutter/material.dart';
import '../models/question_model.dart'; // Assuming your Question model is here

class QuestionnaireProvider extends ChangeNotifier {
  // --- STATE VARIABLES ---

  int _currentQuestionIndex = 0;
  final Map<String, dynamic> _answers = {};
  final List<int> _followUpQueue = [];

  // REMOVED: The `_navigateToRoute` variable has been deleted.

  final List<Question> _questions = [
    Question(
      id: 'age_gender',
      header: 'Hallo Anna!',
      questionText:
          'Damit ich dich besser begleiten kann, brauche ich ein paar Basisangaben von dir. Magst du mir bitte dein Alter und Geschlecht angeben?',
      type: QuestionType.textAndSingleChoice,
      options: ['weiblich', 'divers', 'keine Angabe'],
    ),
    Question(
      id: 'diagnose_status',
      header: 'Deine Diagnose',
      questionText: 'Wurde bei dir bereits Endometriose diagnostiziert?',
      type: QuestionType.singleChoice,
      options: [
        'Ja, durch eine Operation bestätigt',
        'Ja, Verdachtsdiagnose (Bildgebung, Symptome)',
        'Nein, bisher nicht'
      ],
    ),
    Question(
      id: 'pain_level',
      header: 'Deine Schmerzintensität',
      questionText: 'Wie stark sind deine Schmerzen typischerweise?',
      type: QuestionType.slider,
      sliderMin: 1.0,
      sliderMax: 10.0,
      sliderDivisions: 9,
    ),
    Question(
      id: 'symptom_duration',
      header: 'Dein Symptomverlauf',
      questionText: 'Wie lange begleiten dich die Symptome schon?',
      type: QuestionType.singleChoice,
      options: [
        'Weniger als 6 Monate',
        '6 - 12 Monate',
        '1 - 3 Jahre',
        'Länger als 3 Jahre'
      ],
    ),
    Question(
      id: 'symptom_frequency',
      header: 'Deine Symptome genauer erfassen',
      questionText: 'Wie häufig treten deine Schmerzen auf?',
      type: QuestionType.singleChoice,
      options: ['Täglich', 'Mehrmals pro Woche', 'Zyklusabhängig', 'Selten'],
    ),
    Question(
      id: 'symptoms',
      header: 'Deine Symptome genauer erfassen',
      questionText: 'Welche Beschwerden treten auf?',
      type: QuestionType.multipleChoice,
      options: [
        'Schmerzhafte Regelblutung',
        'Unterbauchschmerzen',
        'Probleme beim Wasserlassen',
        'Schmerzen beim Stuhlgang',
        'Verstopfung und Durchfall',
        'Schmerzen beim Geschlechtsverkehr',
        'Erschöpfung',
        'Erhöhter Stress',
        'Schlafprobleme',
        'belastende Ängste',
        'depressive Symptome',
        'eingeschränkte körperliche Aktivität',
        'Unerfüllter Kinderwunsch',
      ],
      branchingRules: {
        'Schmerzhafte Regelblutung': 'regelblutung_follow_up',
        'Unterbauchschmerzen': 'unterbauchschmerzen_follow_up',
        'Probleme beim Wasserlassen': 'wasserlassen_follow_up',
        'Verstopfung und Durchfall': 'digestion_follow_up',
        'Schmerzen beim Stuhlgang': 'digestion_follow_up',
        'Schmerzen beim Geschlechtsverkehr': 'verkehr_follow_up',
        'Erschöpfung': 'erschöpfung_follow_up',
        'Erhöhter Stress': 'stress_follow_up',
        'Schlafprobleme': 'schlaf_follow_up_1',
        'eingeschränkte körperliche Aktivität': 'aktivitaet_follow_up_1',
        'Unerfüllter Kinderwunsch': 'kinderwunsch_follow_up_1',
      },
    ),
    Question(
      id: 'wohlbefinden_1',
      header: 'Dein Wohlbefinden im Alltag',
      questionText:
          'Bitte denke an die letzten 4 Wochen zurück. Hat die Endometriose dich im Alltag eingeschränkt?',
      type: QuestionType.singleChoice,
      options: ['Nie', 'Selten', 'Manchmal', 'Oft', 'Immer'],
    ),
    Question(
      id: 'wohlbefinden_2',
      header: 'Dein Wohlbefinden im Alltag',
      questionText:
          'Bitte denke an die letzten 4 Wochen zurück. Hat die Endometriose dich vor sozialen Aktivitäten abgehalten?',
      type: QuestionType.singleChoice,
      options: ['Nie', 'Selten', 'Manchmal', 'Oft', 'Immer'],
    ),
    Question(
      id: 'wohlbefinden_3',
      header: 'Dein Wohlbefinden im Alltag',
      questionText:
          'Bitte denke an die letzten 4 Wochen zurück. Hat die Endometriose deine Arbeit oder Ausbildung beeinflusst?',
      type: QuestionType.singleChoice,
      options: ['Nie', 'Selten', 'Manchmal', 'Oft', 'Immer'],
    ),
    Question(
      id: 'wohlbefinden_4',
      header: 'Dein Wohlbefinden im Alltag',
      questionText:
          'Bitte denke an die letzten 4 Wochen zurück. Hast du dich durch deine Endometriose kraftlos oder erschöpft gefühlt?',
      type: QuestionType.singleChoice,
      options: ['Gar nicht', 'Ein wenig', 'Mäßig', 'Sehr', 'Extrem'],
    ),
    Question(
      id: 'zyklus_1',
      header: 'Dein Zyklus',
      questionText:
          'Damit ich deine Angaben richtig einordnen kann: Wie würdest du deinen Zyklus aktuell beschreiben?',
      type: QuestionType.singleChoice,
      options: [
        'Menstruation aktiv',
        'Perimenopause / frühe Menopause',
        'Postpartum / Stillzeit',
        'Hormonell bedingt ausgesetzt (z.B. Pille, Spirale)',
        'Hysterektomie / keine Menstruation'
      ],
    ),
    Question(
      id: 'zyklus_2',
      header: 'Dein Zyklus',
      questionText: 'Wie lang ist dein durchschnittlicher Zyklus in Tagen?',
      type: QuestionType.inputThenSingleChoice,
      options: ['Bitte Dauer angeben', 'Ich weiß es nicht'],
    ),
    Question(
      id: 'zyklus_3',
      header: 'Dein Zyklus',
      questionText: 'Wie würdest du deinen Zyklus aktuell beschreiben?',
      type: QuestionType.singleChoice,
      options: [
        'Sehr regelmäßig',
        'Eher regelmäßig',
        'Mäßig unregelmäßig',
        'Stark unregelmäßig',
        'Sehr stark unregelmäßig'
      ],
    ),
    Question(
      id: 'zyklus_4',
      header: 'Dein Zyklus',
      questionText: 'Wie lang dauert deine Blutung in Tagen?',
      type: QuestionType.inputThenSingleChoice,
      options: ['Bitte Dauer angeben', 'Ich weiß es nicht'],
    ),
    Question(
      id: 'bleeding_strength',
      header: 'Blutungsstärke',
      questionText:
          'Welches Bild beschreibt deine aktuelle Blutungsstärke am besten?',
      type: QuestionType.singleChoiceWithImages,
      imageOptions: {
        'Leicht': 'assets/images/Tampon_light.png',
        'Mittel': 'assets/images/Tampon_middle.png',
        'Stark': 'assets/images/Tampon_heavy.png',
      },
    ),
    Question(
      id: 'zyklus_5',
      header: 'Dein Zyklus',
      questionText: 'Weißt Du, ob Du einen Eisprung hast?',
      type: QuestionType.singleChoice,
      options: [
        'Ja, ich tracke ihn (z.B. Temperatur, LH-Test)',
        'Nein, ich weiß es nicht',
        'Unsicher / Schwanger?'
      ],
    ),
    Question(
      id: 'zyklus_6',
      header: 'Dein Zyklus',
      questionText:
          'Nimmst du aktuell hormonelle Verhütung oder andere relevante Medikamente?',
      type: QuestionType.inputThenSingleChoice,
      options: ['Ja, bitte Art angeben', 'Nein'],
    ),
    Question(
      id: 'zyklus_7',
      header: 'Dein Zyklus',
      questionText: 'Möchtest du in nächster Zeit schwanger werden?',
      type: QuestionType.singleChoice,
      options: ['Ja', 'Nein', 'Unsicher'],
    ),
    Question(
      id: 'aktuelle_Behandlung',
      header: 'Deine aktuelle Behandlung',
      questionText: 'Nimmst du aktuell Medikamente gegen Endometriose?',
      type: QuestionType.inputThenSingleChoice,
      options: ['eigene Angabe', 'Hormonelle Therapie', 'Schmerzmittel'],
    ),
    Question(
      id: 'aktuelle_Behandlung2',
      header: 'Deine aktuelle Behandlung',
      questionText:
          'Wurde deine Endometriose in den letzten 12 Monaten operativ behandelt? ',
      type: QuestionType.singleChoice,
      options: ['Ja', 'Nein'],
    ),
    Question(
      id: 'umgang_mit_schemrzen',
      header: 'Umgang mit Schmerzen',
      questionText: 'Wie gehst du aktuell mit Schmerzen um ?',
      type: QuestionType.multipleChoice,
      options: [
        'Schmerzmedikamente',
        'Wärme / Kälte',
        'Entspannungstechniken',
        'Bewegung',
        'Ernährung',
      ],
    ),
    Question(
      id: 'ziele',
      header: 'Deine Ziele & Präferenzen ',
      questionText: 'Was sind deine Ziele für die Nutzung von KIM4U ?',
      type: QuestionType.multipleChoice,
      options: [
        'Weniger Schmerzen',
        'Besser schlafen',
        'Energie steigern',
        'Zyklus regulieren',
        'Emotionale Balance',
      ],
    ),
    Question(
      id: 'wearables',
      header: 'Daten aus deinen Geräten',
      questionText: 'Möchtest du Daten aus Wearables einbinden ?',
      type: QuestionType.singleChoiceWithImages,
      imageOptions: {
        'Apple Health': 'assets/images/apple.png',
        'Fitbit': 'assets/images/fitbit.png',
        'Oura': 'assets/images/oura.png',
      },
    ),

    // --- FOLLOW-UP QUESTIONS (BRANCHES) ---
    Question(
      id: 'kinderwunsch_follow_up_1',
      header: 'Unerfüllter Kinderwunsch',
      questionText:
          'Bitte denke an die letzten 4 Wochen zurück. Hast du aktiv versucht schwanger zu werden?',
      type: QuestionType.singleChoice,
      options: ['ja', 'nein'],
      nextQuestionId: 'kinderwunsch_follow_up_2',
    ),
    Question(
      id: 'kinderwunsch_follow_up_2',
      header: 'Unerfüllter Kinderwunsch',
      questionText:
          'Bitte denke an die letzten 4 Wochen zurück. Belastet dich der unerfüllte Kinderwunsch emotional?',
      type: QuestionType.singleChoice,
      options: ['gar nicht', 'leicht', 'mäßig', 'stark', 'sehr stark'],
      nextQuestionId: 'wohlbefinden_1',
    ),
    Question(
      id: 'aktivitaet_follow_up_1',
      header: 'Reduzierte körperliche Aktivität',
      questionText:
          'Bitte denke an die letzten 7 Tage zurück. Wie oft hast du körperliche Aktivitäten durchgeführt?',
      type: QuestionType.singleChoice,
      options: ['Nie', '1 - 2x', '3 - 4x', 'Mehr als 4x'],
      nextQuestionId: 'aktivitaet_follow_up_2',
    ),
    Question(
      id: 'aktivitaet_follow_up_2',
      header: 'Reduzierte körperliche Aktivität',
      questionText:
          'Bitte denke an die letzten 7 Tage zurück. Fühlst du, dass du weniger aktiv bist, als du eigentlich sein möchtest?',
      type: QuestionType.singleChoice,
      options: ['gar nicht', 'leicht', 'mäßig', 'stark', 'sehr stark'],
      nextQuestionId: 'wohlbefinden_1',
    ),
    Question(
      id: 'schlaf_follow_up_1',
      header: 'Schlafprobleme',
      questionText:
          'Bitte denke an die letzten 2 Wochen zurück. Wie oft hattest du Schwierigkeiten beim Einschlafen?',
      type: QuestionType.singleChoice,
      options: ['Nie', 'Selten', 'Manchmal', 'Oft', 'Immer'],
      nextQuestionId: 'wohlbefinden_1',
    ),
    Question(
      id: 'stress_follow_up',
      header: 'Deine Stimmung',
      questionText:
          'Bitte denke an die letzten 2 Wochen zurück. Wie oft hattest Du wenig Interesse oder Freude an Dingen, die Du normalerweise gerne machst?',
      type: QuestionType.singleChoice,
      options: [
        'Nie',
        'An einzelnen Tagen',
        'An mehr als der Hälfte der Tage',
        'Fast jeden Tag'
      ],
      nextQuestionId: 'wohlbefinden_1',
    ),
    Question(
      id: 'verkehr_follow_up',
      header: 'Schmerzen beim Geschlechtsverkehr',
      questionText:
          'Bitte denke an die letzten 7 Tage zurück. Wie stark waren deine Schmerzen beim Geschlechtsverkehr?',
      type: QuestionType.slider,
      sliderMin: 1.0,
      sliderMax: 10.0,
      sliderDivisions: 9,
      nextQuestionId: 'wohlbefinden_1',
    ),
    Question(
      id: 'erschöpfung_follow_up',
      header: 'Erschöpfung / Fatigue',
      questionText:
          'Bitte denke an die letzten 7 Tage zurück. Wie stark war deine Erschöpfung?',
      type: QuestionType.slider,
      sliderMin: 1.0,
      sliderMax: 10.0,
      sliderDivisions: 9,
      nextQuestionId: 'wohlbefinden_1',
    ),
    Question(
      id: 'regelblutung_follow_up',
      header: 'Schmerzhafte Regelblutung',
      questionText:
          'Bitte denke an deine letzte Menstruation zurück. Wie stark sind deine Schmerzen typischerweise?',
      type: QuestionType.slider,
      sliderMin: 1.0,
      sliderMax: 10.0,
      sliderDivisions: 9,
      nextQuestionId: 'wohlbefinden_1',
    ),
    Question(
      id: 'unterbauchschmerzen_follow_up',
      header: 'Chronische Unterbauchschmerzen',
      questionText:
          'Bitte denke an die letzten 7 Tage zurück. Wie stark waren deine Unterbauchschmerzen?',
      type: QuestionType.slider,
      sliderMin: 1.0,
      sliderMax: 10.0,
      sliderDivisions: 9,
      nextQuestionId: 'wohlbefinden_1',
    ),
    Question(
      id: 'wasserlassen_follow_up',
      header: 'Probleme beim Wasserlassen',
      questionText:
          'Bitte denke an die letzten 7 Tage zurück. Wie stark waren deine Schmerzen oder Beschwerden beim Wasserlassen?',
      type: QuestionType.slider,
      sliderMin: 1.0,
      sliderMax: 10.0,
      sliderDivisions: 9,
      nextQuestionId: 'wohlbefinden_1',
    ),
    Question(
      id: 'digestion_follow_up',
      header: 'Verstopfung und Durchfall',
      questionText:
          'Bitte denke an die letzten 7 Tage zurück. Wähle die Stuhlarten aus, die am besten zu Dir passen',
      type: QuestionType.singleChoiceWithImages,
      imageOptions: {
        'Hart, Klumpen wie Nüsse': 'assets/images/stool_hard.png',
        'Hart, länglich': 'assets/images/stool_long.png',
        'Wurstförmig, mit Rissen': 'assets/images/stool_longer.png',
        'Wurstförmig, glatt und weich (normal)':
            'assets/images/stool_sausage.png',
        'Weiche Klumpen': 'assets/images/stool_soft.png',
        'Breiig, keine klare Form': 'assets/images/stool_brei.png',
        'Flüssig, keine festen Stücke': 'assets/images/stool_liquid.png',
      },
      nextQuestionId: 'wohlbefinden_1',
    ),
  ];

  // --- GETTERS ---

  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  Map<String, dynamic> get answers => _answers;

  // REMOVED: The getter for navigateToRoute has been deleted.

  // --- METHODS ---

  void answerQuestion(String questionId, dynamic answer) {
    _answers[questionId] = answer;
    // We call notifyListeners() in nextQuestion() to update the UI
  }

  void nextQuestion() {
    final currentQ = currentQuestion;

    // REMOVED: The milestone check for 'umgang_mit_schemrzen' has been deleted.

    final currentAnswer = _answers[currentQ.id];
    final sequentialIndex = _questions.indexOf(currentQ);

    // Handle branching logic from multiple choice questions
    if (currentQ.branchingRules != null &&
        currentAnswer != null &&
        currentAnswer is List<String>) {
      _followUpQueue.clear();
      for (String answer in currentAnswer) {
        if (currentQ.branchingRules!.containsKey(answer)) {
          final nextQuestionId = currentQ.branchingRules![answer]!;
          final jumpIndex =
              _questions.indexWhere((q) => q.id == nextQuestionId);
          if (jumpIndex != -1 && !_followUpQueue.contains(jumpIndex)) {
            _followUpQueue.add(jumpIndex);
          }
        }
      }
    }

    // Process the queue of follow-up questions first
    if (_followUpQueue.isNotEmpty) {
      _currentQuestionIndex = _followUpQueue.removeAt(0);
      notifyListeners();
      return;
    }

    // Handle explicit jumps to the next question
    if (currentQ.nextQuestionId != null) {
      final jumpIndex =
          _questions.indexWhere((q) => q.id == currentQ.nextQuestionId);
      if (jumpIndex != -1) {
        _currentQuestionIndex = jumpIndex;
        notifyListeners();
        return;
      }
    }

    // Default: move to the next question in the list
    if (sequentialIndex < _questions.length - 1) {
      _currentQuestionIndex = sequentialIndex + 1;
      notifyListeners();
    } else {
      // This is the true end of the entire questionnaire
      print('Questionnaire complete!');
      print(_answers);
      // Here you could set a final completion flag or navigate to a summary page
    }
  }

  // REMOVED: The `continueQuestionnaire` method has been deleted.

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }
}