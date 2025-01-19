import 'package:flutter/material.dart';
import 'package:quiz_flow_gamification/src/commons/widgets/custom_title_with_icon.dart';
import 'package:quiz_flow_gamification/src/features/quiz/quiz_screen.dart';
import 'package:quiz_flow_gamification/src/res/assets.dart';
import 'package:quiz_flow_gamification/src/res/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: CustomTitleWithIcon(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          // Rounded Image
          ClipOval(
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black, width: 5),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                ImageAssets.homeImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 100),
          Center(
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.teal, AppColors.theme],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizPage(apiUrl: 'https://api.jsonserve.com/Uw5CrX'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.transparent,
                  shadowColor: AppColors.theme,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow, size: 24, color: AppColors.white),
                    const SizedBox(width: 10),
                    const Text(
                      'Start Quiz',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
