import 'package:cvmuproject/widgets/results_card.dart';
import 'package:flutter/material.dart';
import 'package:cvmuproject/views/home_screen.dart';
import 'package:cvmuproject/login/login.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.whichTopic,
    required this.selectedLocale
  });
  final int score;
  final int totalQuestions;
  final String whichTopic;
  final Locale selectedLocale;

  @override

  Widget build(BuildContext context) {
    const Color bgColor3 = Color(0xff0065A7);
    final double percentageScore = (score / totalQuestions) * 100;
    final int roundedPercentageScore = percentageScore.round();
    final int totalScore = calculateTotalScore(score);


    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(context, (route) => route.isFirst);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: bgColor3,
          elevation: 0,
        ),
        backgroundColor: bgColor3,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your title and topic widgets here
              ResultsCard(

                totalScores: totalScore,
                bgColor3: bgColor3,
                roundedPercentageScore: roundedPercentageScore,
              ),
              // Text(
              //   "Total Score: $totalScore",
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffFFB200)),
                  fixedSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width * 0.80, 40),
                  ),
                  elevation: MaterialStateProperty.all(4),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(selectedLocale: selectedLocale),
                    ),
                  );
                },
                child: const Text(
                  "Go to HomePage",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int calculateTotalScore(int score) {
    int totalScore = score;
    return totalScore;
  }
}
