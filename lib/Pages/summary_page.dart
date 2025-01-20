import 'package:flutter/material.dart';
import '../data/model/question.dart';

class SummaryScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final Map<int, int> userAnswers;
  final List<Question> questions;

  const SummaryScreen({
    required this.score,
    required this.totalQuestions,
    required this.userAnswers,
    required this.questions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Score: $score/$totalQuestions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Text(
              'Answers:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final userAnswerIndex = userAnswers[index];
                  final isCorrect = userAnswerIndex != null &&
                      question.options[userAnswerIndex].isCorrect;

                  return ListTile(
                    title: Text(question.description),
                    subtitle: Text(
                      'Your Answer: ${userAnswerIndex != null ? question.options[userAnswerIndex].description : "No Answer"}',
                      style: TextStyle(
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                    ),
                    trailing: isCorrect
                        ? Icon(Icons.check, color: Colors.green)
                        : Icon(Icons.close, color: Colors.red),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
