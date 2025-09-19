// lib/models/question_model.dart

enum QuestionType {
  singleChoice,
  multipleChoice,
  slider,
  singleChoiceWithImages,
  singleChoicePlusInput,
  textAndSingleChoice,
  inputThenSingleChoice, // This was added based on its usage in your other files
}

class Question {
  final String id;
  final String header;
  final String questionText;
  final QuestionType type;

  // For choice-based questions
  final List<String> options;

  // For choice-based questions with images
  final Map<String, String>? imageOptions;

  // For sliders
  final double? sliderMin;
  final double? sliderMax;
  final int? sliderDivisions;
  
  // For branching logic
  final String? nextQuestionId;
  final Map<String, String>? branchingRules;

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
    this.branchingRules,
    this.nextQuestionId,
  });
}