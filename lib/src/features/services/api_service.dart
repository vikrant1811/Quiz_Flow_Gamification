import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/question_model.dart';

Future<QuizModel> fetchQuizData(String apiUrl) async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    return QuizModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load quiz. Status code: ${response.statusCode}');
  }
}
