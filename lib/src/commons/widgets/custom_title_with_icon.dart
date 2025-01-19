import 'package:flutter/material.dart';
import '../../res/colors.dart';

class CustomTitleWithIcon extends StatelessWidget {
  final MainAxisAlignment alignment;

  const CustomTitleWithIcon({
    super.key,
    this.alignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: const [
        Text(
          "Quiz Time !!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 5),
        Icon(
          Icons.quiz,
          size: 24,
          color: AppColors.theme,
        ),
      ],
    );
  }
}
