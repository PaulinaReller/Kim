// lib/models/question_model.dart

enum QuestionType {
  singleChoice,
  multipleChoice,
  slider,
  singleChoiceWithImages,
  singleChoicePlusInput,
  bodyMap,
}

class Question {
  final String id;
  final String header; // Dein "kleiner Header unter dem Text"
  final String questionText;
  final QuestionType type;

  // Für Auswahlfragen
  final List<String> options;

  // ++ NEU: Für Auswahlfragen mit Bildern ++
  // Map<Optionstext, Bild-Asset-Pfad>
  final Map<String, String>? imageOptions;

  // Für Slider
  final double? sliderMin;
  final double? sliderMax;
  final int? sliderDivisions;

  const Question({
    required this.id,
    required this.header,
    required this.questionText,
    required this.type,
    this.options = const [],
    this.imageOptions,
    this.sliderMin,
    this.sliderMax,
    this.sliderDivisions,
  });
}