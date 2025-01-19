import 'package:flutter/material.dart';
import 'package:quiz_flow_gamification/src/commons/views/onboarding_screen.dart';
import '../../res/colors.dart';
import '../widgets/custom_title_with_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (c)=>OnboardingScreen())
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: CustomTitleWithIcon(),
      ),
    );
  }
}
