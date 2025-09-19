// lib/screens/question_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/question_model.dart';
import '../providers/questionnaire_provider.dart';
import '../widgets/kim_logo.dart';
import '../widgets/frosted_glass_container.dart';

// This widget now creates its own provider for the questionnaire.
class QuestionnaireFlow extends StatelessWidget {
  const QuestionnaireFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuestionnaireProvider(),
      child: const QuestionScreen(),
    );
  }
}

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // This listener correctly handles the page-to-page animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionnaireProvider>().addListener(() {
        final provider = context.read<QuestionnaireProvider>();
        if (_pageController.hasClients && _pageController.page?.round() != provider.currentQuestionIndex) {
          _pageController.animateToPage(
            provider.currentQuestionIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionnaireProvider>();

    // REMOVED: The logic for checking `MapsToRoute` has been deleted from here.

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: PageView.builder(
              controller: _pageController,
              itemCount: provider.questions.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final question = provider.questions[index];
                return _SingleQuestionUI(question: question);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SingleQuestionUI extends StatefulWidget {
  final Question question;
  const _SingleQuestionUI({required this.question});

  @override
  State<_SingleQuestionUI> createState() => _SingleQuestionUIState();
}

class _SingleQuestionUIState extends State<_SingleQuestionUI> {
  String? _selectedSingleChoice;
  final List<String> _selectedMultiChoice = [];
  double? _sliderValue;
  late TextEditingController _textInputController;

  @override
  void initState() {
    super.initState();
    _textInputController = TextEditingController();
    if (widget.question.type == QuestionType.slider) {
      _sliderValue = widget.question.sliderMin ?? 1.0;
    }
  }

  @override
  void dispose() {
    _textInputController.dispose();
    super.dispose();
  }

  Widget _buildAnswerWidget() {
    final kimGreen = const Color(0xFF03513A);

    switch (widget.question.type) {
      case QuestionType.inputThenSingleChoice:
        final inputOptionHint = widget.question.options.first;
        final radioOptions = widget.question.options.sublist(1);

        return Column(
          children: [
            FrostedGlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _textInputController,
                onTap: () {
                  setState(() {
                    _selectedSingleChoice = inputOptionHint;
                  });
                },
                onChanged: (text) {
                  setState(() {
                    if (_selectedSingleChoice != inputOptionHint) {
                      _selectedSingleChoice = inputOptionHint;
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: inputOptionHint,
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: Colors.black54),
                ),
                style: const TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(height: 8),
            ...radioOptions.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSingleChoice = option;
                      _textInputController.clear();
                      FocusScope.of(context).unfocus();
                    });
                  },
                  child: FrostedGlassContainer(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(option,
                                style: const TextStyle(color: Colors.black87))),
                        Radio<String>(
                          value: option,
                          groupValue: _selectedSingleChoice,
                          activeColor: kimGreen,
                          onChanged: (value) {
                            setState(() {
                              _selectedSingleChoice = value;
                              _textInputController.clear();
                              FocusScope.of(context).unfocus();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      case QuestionType.textAndSingleChoice:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Alter",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 8),
            FrostedGlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _textInputController,
                keyboardType: TextInputType.datetime,
                onChanged: (text) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'XX.XX.XXXX',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black54),
                ),
                style: const TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(height: 24),
            const Text("Geschlecht",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87)),
            ...widget.question.options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedSingleChoice = option),
                  child: FrostedGlassContainer(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(option,
                                style: const TextStyle(color: Colors.black87))),
                        Radio<String>(
                          value: option,
                          groupValue: _selectedSingleChoice,
                          activeColor: kimGreen,
                          onChanged: (value) =>
                              setState(() => _selectedSingleChoice = value),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        );

      case QuestionType.singleChoice:
        return Column(
          children: widget.question.options.map((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: GestureDetector(
                onTap: () => setState(() => _selectedSingleChoice = option),
                child: FrostedGlassContainer(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: option,
                        groupValue: _selectedSingleChoice,
                        activeColor: kimGreen,
                        onChanged: (value) =>
                            setState(() => _selectedSingleChoice = value),
                      ),
                      Expanded(
                          child: Text(option,
                              style: const TextStyle(color: Colors.black87))),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );

      case QuestionType.multipleChoice:
        return Column(
          children: widget.question.options.map((option) {
            final isSelected = _selectedMultiChoice.contains(option);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedMultiChoice.remove(option);
                    } else {
                      _selectedMultiChoice.add(option);
                    }
                  });
                },
                child: FrostedGlassContainer(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isSelected,
                        activeColor: kimGreen,
                        checkColor: kimGreen,
                        shape: const CircleBorder(),
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              _selectedMultiChoice.add(option);
                            } else {
                              _selectedMultiChoice.remove(option);
                            }
                          });
                        },
                      ),
                      Expanded(
                          child: Text(option,
                              style: const TextStyle(color: Colors.black87))),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );

      case QuestionType.slider:
        return FrostedGlassContainer(
          child: Column(
            children: [
              Text('${_sliderValue!.round()}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
              Slider(
                value: _sliderValue!,
                min: widget.question.sliderMin!,
                max: widget.question.sliderMax!,
                divisions: widget.question.sliderDivisions,
                activeColor: kimGreen,
                onChanged: (value) => setState(() => _sliderValue = value),
              ),
            ],
          ),
        );

      case QuestionType.singleChoiceWithImages:
        return Column(
          children: widget.question.imageOptions!.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: GestureDetector(
                onTap: () => setState(() => _selectedSingleChoice = entry.key),
                child: FrostedGlassContainer(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Image.asset(
                        entry.value,
                        width: 80,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Radio<String>(
                        value: entry.key,
                        groupValue: _selectedSingleChoice,
                        activeColor: kimGreen,
                        onChanged: (value) {
                          setState(() {
                            _selectedSingleChoice = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );

      case QuestionType.singleChoicePlusInput:
        final otherOption = widget.question.options.last;
        return Column(
          children: [
            ...widget.question.options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedSingleChoice = option),
                  child: FrostedGlassContainer(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        Radio<String>(
                          value: option,
                          groupValue: _selectedSingleChoice,
                          activeColor: kimGreen,
                          onChanged: (value) =>
                              setState(() => _selectedSingleChoice = value),
                        ),
                        Expanded(
                            child: Text(option,
                                style:
                                    const TextStyle(color: Colors.black87))),
                      ],
                    ),
                  ),
                ),
              );
            }),
            if (_selectedSingleChoice == otherOption)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: FrostedGlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _textInputController,
                    onChanged: (text) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      hintText: 'Bitte angeben...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black54),
                    ),
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
              ),
          ],
        );

      default:
        return FrostedGlassContainer(
          child: Text('Answer UI for ${widget.question.type}'),
        );
    }
  }

  bool _isAnswered() {
    switch (widget.question.type) {
      case QuestionType.inputThenSingleChoice:
        if (_selectedSingleChoice == null) return false;
        if (_selectedSingleChoice == widget.question.options.first) {
          return _textInputController.text.isNotEmpty;
        }
        return true; 

      case QuestionType.textAndSingleChoice:
        return _textInputController.text.isNotEmpty &&
            _selectedSingleChoice != null;

      case QuestionType.singleChoice:
      case QuestionType.singleChoiceWithImages:
        return _selectedSingleChoice != null;
      case QuestionType.singleChoicePlusInput:
        if (_selectedSingleChoice == null) return false;
        if (_selectedSingleChoice == widget.question.options.last) {
          return _textInputController.text.isNotEmpty;
        }
        return true;
      case QuestionType.multipleChoice:
        return _selectedMultiChoice.isNotEmpty;
      case QuestionType.slider:
        return _sliderValue != null;
      default:
        return false;
    }
  }

  void _saveAndProceed() {
    final provider = context.read<QuestionnaireProvider>();
    dynamic answer;
    switch (widget.question.type) {
      case QuestionType.inputThenSingleChoice:
        if (_selectedSingleChoice == widget.question.options.first) {
          answer = _textInputController.text;
        } else {
          answer = _selectedSingleChoice;
        }
        break;

      case QuestionType.textAndSingleChoice:
        answer = {
          'age': _textInputController.text,
          'gender': _selectedSingleChoice,
        };
        break;

      case QuestionType.singleChoice:
      case QuestionType.singleChoiceWithImages:
        answer = _selectedSingleChoice;
        break;
      case QuestionType.singleChoicePlusInput:
        if (_selectedSingleChoice == widget.question.options.last) {
          answer = _textInputController.text;
        } else {
          answer = _selectedSingleChoice;
        }
        break;
      case QuestionType.multipleChoice:
        answer = List<String>.from(_selectedMultiChoice);
        break;
      case QuestionType.slider:
        answer = _sliderValue;
        break;
    }
    provider.answerQuestion(widget.question.id, answer);
    provider.nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    final kimGreen = const Color(0xFF03513A);
    final provider = context.watch<QuestionnaireProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              if (provider.currentQuestionIndex > 0)
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black54),
                  onPressed: () {
                    context.read<QuestionnaireProvider>().previousQuestion();
                  },
                )
              else
                const SizedBox(width: 48),
              Text('KIM4U',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: kimGreen)),
            ],
          ),
          const SizedBox(height: 20),
          Text(widget.question.header,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w200,
                  color: Colors.black)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: PulsingLogo()),
                const SizedBox(height: 30),
                Text(
                  widget.question.questionText,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildAnswerWidget(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isAnswered() ? _saveAndProceed : null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: kimGreen, shape: const StadiumBorder()),
              child: const Text('Antworten',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}