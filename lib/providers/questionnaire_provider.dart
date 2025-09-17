import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuestionnaireProvider extends ChangeNotifier {
  final List<Question> _questions = [
    // 1. Single Choice
    Question(
      id: 'diagnose_status',
      header: 'Deine Diagnose',
      questionText: 'Wurde bei dir bereits Endometriose diagnostiziert?',
      type: QuestionType.singleChoice,
      options: [
        'Ja, durch eine Operation bestätigt',
        'Ja, Verdachtsdiagnose (Bildgebung, Symptome)',
        'Nein, bisher nicht',
      ],
    ),

    // 2. Slider
    Question(
      id: 'pain_level',
      header: 'Schmerzlevel',
      questionText: 'Wie stark sind deine Schmerzen auf einer Skala von 1-10?',
      type: QuestionType.slider,
      sliderMin: 1.0,
      sliderMax: 10.0,
      sliderDivisions: 9,
    ),

    // 3. Multiple Choice
    Question(
      id: 'symptoms',
      header: 'Symptome',
      questionText: 'Welche der folgenden Symptome treffen auf dich zu?',
      type: QuestionType.multipleChoice,
      options: ['Krämpfe', 'Müdigkeit', 'Kopfschmerzen', 'Übelkeit'],
    ),

    // 4. Single Choice With Images
    Question(
      id: 'bleeding_strength',
      header: 'Blutungsstärke',
      questionText: 'Welches Bild beschreibt deine aktuelle Blutungsstärke am besten?',
      type: QuestionType.singleChoiceWithImages,
      imageOptions: {
        'Leicht': 'assets/images/Tampon_light.png',
        'Mittel': 'assets/images/Tampon_middle.png',
        'Stark': 'assets/images/Tampon_heavy.png',
      },
    ),

    // 5. Single Choice Plus Input
    Question(
      id: 'trigger_food',
      header: 'Ernährung',
      questionText: 'Gibt es bestimmte Lebensmittel, die deine Symptome verschlimmern?',
      type: QuestionType.singleChoicePlusInput,
      options: ['Ja', 'Nein', 'Ich bin mir nicht sicher', 'Sonstiges'],
    ),

    // 6. Body Map (as a placeholder)
    Question(
      id: 'pain_location',
      header: 'Schmerzlokalisation',
      questionText: 'Bitte markiere auf der Karte, wo du Schmerzen verspürst.',
      type: QuestionType.bodyMap,
    ),
  ];

  // These variables are the "Brain's Memory"
  int _currentQuestionIndex = 0;
  final Map<String, dynamic> _answers = {}; // Stores answers for each question ID

  // --- Public Getters ---
  // These allow the UI to safely read the brain's state.
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  Map<String, dynamic> get answers => _answers;

  // --- Actions ---
  // These are the actions the brain can perform.
  void answerQuestion(String questionId, dynamic answer) {
    _answers[questionId] = answer;
    // We don't call notifyListeners() here, because answering
    // doesn't immediately change the screen.
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners(); // This tells the UI to update to the new question.
    } else {
      // Questionnaire is finished!
      print('Questionnaire complete!');
      print(_answers);
      // Here you will later save the answers to a file
      // and navigate to the next part of the app.
    }
  }
  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners(); // This tells the UI to update to the previous question.
    }
  }
}