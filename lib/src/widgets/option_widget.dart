import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../res/colors.dart';

class OptionWidget extends StatelessWidget {
  final OptionModel option;
  final void Function()? onSelect;
  final bool showCorrectAnswer;
  final bool isSelected;
  final bool userSelected;

  OptionWidget({
    required this.option,
    this.onSelect,
    required this.showCorrectAnswer,
    this.isSelected = false,
    this.userSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    Color optionColor;

    if (showCorrectAnswer) {
      // Show green for correct, red for wrong after quiz ends
      optionColor = option.isCorrect ? AppColors.green : AppColors.red;
    } else if (userSelected) {
      // Highlight the user's selection: green if correct, red if wrong
      optionColor = option.isCorrect ? AppColors.green : AppColors.red;
    } else {
      // Default color for unselected options
      optionColor = AppColors.grey;
    }

    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: optionColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              userSelected ? Icons.check_circle : Icons.circle_outlined,
              color: AppColors.white,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                option.description ?? '',
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
