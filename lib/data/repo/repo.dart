import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/question.dart';

class QuestionRepository {
  Future<List<Question>> fetchQuestions() async {
    final response =
        await http.get(Uri.parse('https://api.jsonserve.com/Uw5CrX'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Access the `questions` field in the JSON response
      final List<dynamic> questionsJson = data['questions'];

      // Convert the JSON list to a list of `Question` objects
      return questionsJson
          .map((questionJson) => Question.fromJson(questionJson))
          .toList();
    } else {
      throw Exception('Failed to fetch questions');
    }
  }
}
