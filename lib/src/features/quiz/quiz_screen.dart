import 'package:flutter/material.dart';
import 'package:quiz_flow_gamification/src/commons/widgets/custom_title_with_icon.dart';
import 'package:quiz_flow_gamification/src/res/colors.dart';
import '../../models/question_model.dart';
import '../../widgets/question_widget.dart';
import '../../widgets/stat_card_widget.dart';
import '../services/api_service.dart';

class QuizPage extends StatefulWidget {
  final String apiUrl;

  const QuizPage({super.key, required this.apiUrl});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<QuizModel> quiz;
  int mistakes = 0;
  int correct = 0;
  int lives = 5;
  int score = 0;
  late List<QuestionModel> shuffledQuestions;
  bool showCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    quiz = fetchQuizData(widget.apiUrl);
  }

  void _answerQuestion(QuestionModel question, OptionModel selectedOption) {
    setState(() {
      if (!question.isAnswered) {
        question.isAnswered = true;
        question.correctAnswer = selectedOption.id;
        if (selectedOption.isCorrect) {
          score += 4;
          correct++;
        } else {
          score -= 1;
          mistakes++;
          lives--;
          if (lives <= 0) {
            _submitQuiz();
          }
        }
      }
    });
  }

  void _submitQuiz() {
    setState(() {
      showCorrectAnswer = true;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            '🎉 Quiz Completed',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Score: $score',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('Correct Answers: $correct'),
              Text('Wrong Answers: $mistakes'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        title: CustomTitleWithIcon(),
        elevation: 4,
      ),
      body: FutureBuilder<QuizModel>(
        future: quiz,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.teal),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: AppColors.red, fontSize: 16),
              ),
            );
          }

          final quizData = snapshot.data;

          if (quizData == null) {
            return const Center(
              child: Text(
                'No data found',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          if (quizData.shuffle) {
            shuffledQuestions = List.from(quizData.questions);
          } else {
            shuffledQuestions = quizData.questions;
          }

          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.teal, AppColors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quizData.title ?? 'Untitled Quiz',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          quizData.description ?? 'No description available',
                          style: const TextStyle(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatCardWidget(title: 'Lives', value: '$lives', color: AppColors.red),
                    StatCardWidget(title: 'Mistakes', value: '$mistakes', color: AppColors.orange),
                    StatCardWidget(title: 'Score', value: '$score', color: AppColors.green),
                  ],
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: ListView.builder(
                    itemCount: shuffledQuestions.length,
                    itemBuilder: (context, index) {
                      final question = shuffledQuestions[index];
                      return QuestionWidget(
                        question: question,
                        onAnswer: (OptionModel selectedOption) {
                          _answerQuestion(question, selectedOption);
                        },
                        showCorrectAnswer: showCorrectAnswer,
                      );
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: _submitQuiz,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: AppColors.teal,
                      ),
                      child: const Text(
                        'Submit Quiz',
                        style: TextStyle(color: AppColors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
