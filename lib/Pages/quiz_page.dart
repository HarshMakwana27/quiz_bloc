import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/bloc.dart';
import 'package:quiz_app/data/repo/repo.dart';
import 'package:quiz_app/data/model/question.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Map<int, int> userAnswers =
      {}; // Map to store selected answers: questionIndex -> optionId
  int score = 0;

  void submitQuiz(BuildContext context, List<Question> questions) {
    // Calculate the final score
    score = 0;
    for (int i = 0; i < questions.length; i++) {
      final selectedOptionId = userAnswers[i];
      final correctOption = questions[i].options.firstWhere((o) => o.isCorrect);
      if (selectedOptionId == correctOption.id) {
        score++;
      }
    }

    // Show the summary screen
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Completed'),
        content: Text('Your Score: $score/${questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Navigate back to the home screen
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          QuizBloc(repository: QuestionRepository())..add(FetchQuestions()),
      child: Scaffold(
        appBar: AppBar(title: Text('Quiz App')),
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is QuizLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is QuizLoaded) {
              final questions = state.questions;

              return ListView.builder(
                itemCount: questions.length + 1,
                itemBuilder: (context, index) {
                  if (index == questions.length) {
                    // Add a submit button at the end
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          submitQuiz(context, questions);
                        },
                        child: Text('Submit Quiz'),
                      ),
                    );
                  }

                  final question = questions[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '${index + 1}. ${question.description}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ...question.options.map((option) {
                          return ListTile(
                            title: Text(option.description),
                            leading: Radio<int>(
                              value: option.id,
                              groupValue: userAnswers[index],
                              onChanged: (value) {
                                setState(() {
                                  userAnswers[index] = value!;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  );
                },
              );
            } else if (state is QuizError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
