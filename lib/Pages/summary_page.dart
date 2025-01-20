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
        title: const Text('Quiz Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Score: $score/$totalQuestions',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Text(
              'Answers:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];

                  // Check if the user answered the question
                  final userAnswerIndex = userAnswers[index];
                  final isValidAnswer = userAnswerIndex != null &&
                      userAnswerIndex >= 0 &&
                      userAnswerIndex < question.options.length;

                  final userAnswer =
                      isValidAnswer ? question.options[userAnswerIndex] : null;

                  final isCorrect = userAnswer != null && userAnswer.isCorrect;

                  return ListTile(
                    title: Text(question.description),
                    subtitle: Text(
                      userAnswer != null
                          ? 'Your Answer: ${userAnswer.description}'
                          : 'No Answer',
                      style: TextStyle(
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                    ),
                    trailing: isCorrect
                        ? const Icon(Icons.check, color: Colors.green)
                        : const Icon(Icons.close, color: Colors.red),
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
