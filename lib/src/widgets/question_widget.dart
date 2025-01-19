import 'package:flutter/material.dart';
import 'package:quiz_flow_gamification/src/res/colors.dart';
import '../models/question_model.dart';
import 'option_widget.dart';

class QuestionWidget extends StatelessWidget {
  final QuestionModel question;
  final void Function(OptionModel) onAnswer;
  final bool showCorrectAnswer;

  const QuestionWidget({
    Key? key,
    required this.question,
    required this.onAnswer,
    required this.showCorrectAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Question:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text(
               question.description ?? '',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            ...question.options.map(
                  (option) => OptionWidget(
                option: option,
                onSelect: question.isAnswered ? null : () => onAnswer(option),
                showCorrectAnswer: showCorrectAnswer,
                userSelected: question.isAnswered && option.id == question.correctAnswer,
              ),
            ),
            if (question.detailedSolution != null && showCorrectAnswer) ...[
              const SizedBox(height: 8),
              Text('Solution: ${question.detailedSolution}'),
            ],
          ],
        ),
      ),
    );
  }
}

