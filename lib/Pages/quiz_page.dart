// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/Pages/summary_page.dart';
import 'package:quiz_app/bloc/bloc.dart';
import 'package:quiz_app/data/repo/repo.dart';
import 'package:quiz_app/data/model/question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Map<int, int> userAnswers = {};
  int currentQuestionIndex = 0;

  void submitQuiz(BuildContext context, List<Question> questions) {
    int score = 0;

    // Calculate the score
    for (int i = 0; i < questions.length; i++) {
      final selectedOptionId = userAnswers[i];
      final correctOption = questions[i].options.firstWhere((o) => o.isCorrect);
      if (selectedOptionId == correctOption.id) {
        score++;
      }
    }

    // Navigate to SummaryScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
          score: score,
          totalQuestions: questions.length,
          userAnswers: userAnswers,
          questions: questions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (context) =>
          QuizBloc(repository: QuestionRepository())..add(FetchQuestions()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Quiz is on')),
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is QuizLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuizLoaded) {
              final questions = state.questions;
              int currentQuestionIndex = 0;

              return StatefulBuilder(
                builder: (context, setState) {
                  final question = questions[currentQuestionIndex];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '${currentQuestionIndex + 1}. ${question.description}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...question.options.asMap().entries.map((entry) {
                        final optionIndex = entry.key;
                        final option = entry.value;
                        return ListTile(
                          title: GestureDetector(
                            onTap: () {
                              setState(() {
                                userAnswers[currentQuestionIndex] =
                                    optionIndex; // Select the option when text is tapped
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 15),
                              color: userAnswers[currentQuestionIndex] ==
                                      optionIndex
                                  ? const Color.fromARGB(255, 0, 140, 255)
                                      .withOpacity(
                                          0.1) // Highlight selected option
                                  : Colors.transparent,
                              child: Text(
                                option.description,
                                style: const TextStyle(fontSize: 16),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      }),
                      const Spacer(),
                      Row(
                        children: [
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              color: const Color.fromARGB(255, 0, 140, 255)
                                  .withOpacity(0.5),
                              width: width * 0.9,
                              child: TextButton(
                                onPressed: () {
                                  if (currentQuestionIndex <
                                      questions.length - 1) {
                                    setState(() {
                                      currentQuestionIndex++;
                                    });
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SummaryScreen(
                                          score: userAnswers.entries
                                              .where((entry) =>
                                                  questions[entry.key]
                                                      .options[entry.value]
                                                      .isCorrect)
                                              .length,
                                          totalQuestions: questions.length,
                                          userAnswers: userAnswers,
                                          questions: questions,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                    style: const TextStyle(color: Colors.black),
                                    currentQuestionIndex < questions.length - 1
                                        ? 'Next Question'
                                        : 'Finish Quiz'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            } else if (state is QuizError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
