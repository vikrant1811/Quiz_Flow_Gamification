import 'package:flutter/material.dart';
import 'package:quiz_flow_gamification/src/features/home/home_screen.dart';
import '../../res/assets.dart';
import '../../res/colors.dart';
import '../widgets/custom_title_with_icon.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingPages = [
    {
      'imagePath': ImageAssets.onboardingImg1,
      'title': 'Fun Quiz Time!',
      'subtitle': 'Challenge yourself and test your knowledge \nwith this exciting quiz!',
    },
    {
      'imagePath': ImageAssets.onboardingImg2,
      'title': 'Game Lives',
      'subtitle': 'You have 5 lives. Maximum 5 wrong answers \nresult in elimination. Max score achievable is 40',
    },
    {
      'imagePath': ImageAssets.onboardingImg3,
      'title': 'Score Feedback Design',
      'subtitle': 'For every correct answer "+4" and for every\n wrong answer "-1" ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: CustomTitleWithIcon(),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) {
                  final page = onboardingPages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(page['imagePath']!),
                      Text(
                        page['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        page['subtitle']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingPages.length,
                      (index) => buildDot(index),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: AppColors.theme,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    if (_currentPage < onboardingPages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen())
                      );                  }
                  },
                  child: const Icon(Icons.arrow_forward, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: _currentPage == index ? 16 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColors.theme: AppColors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
