import 'package:cvmuproject/widgets/dotted_lines.dart';
import 'package:flutter/material.dart';

class ResultsCard extends StatelessWidget {
  const ResultsCard({
    super.key,
    required this.totalScores,
    required this.roundedPercentageScore,
    required this.bgColor3,
  });
  final int totalScores;
  final int roundedPercentageScore;
  final Color bgColor3;

  @override
  Widget build(BuildContext context) {
    const Color bgColor3 = Color(0xFF5170FD);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.888,
      height: MediaQuery.of(context).size.height * 0.568,
      child: Stack(
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                              TextSpan(
                                text: "Congratulations!",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 40),
                              ),
                            TextSpan(
                              text: " \n You Scored  \n",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: "$totalScores",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 30,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomPaint(
                    painter: DrawDottedhorizontalline(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: (roundedPercentageScore >= 75)
                            ? Column(
                          children: [
                            Text(
                              "You have Earned this Trophy",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Image.asset("assets/bouncy-cup.gif",
                                fit: BoxFit.fill,
                                height: MediaQuery.of(context).size.height *
                                    0.25),
                          ],
                        )
                            : (roundedPercentageScore > 40)
                            ? Column(
                          children: [
                            Text(
                              "I know You can do better!!",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Image.asset("assets/sad.png",
                                fit: BoxFit.fill,
                                height:
                                MediaQuery.of(context).size.height *
                                    0.25),
                          ],
                        )
                            : Column(
                          children: [
                            Text(
                              "Need to improve!!",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Image.asset("assets/sad.png",
                                fit: BoxFit.fill,
                                height:
                                MediaQuery.of(context).size.height *
                                    0.25),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: -10,
            top: MediaQuery.of(context).size.height * 0.178,
            child: Container(
              height: 25,
              width: 25,
              decoration:
                  const BoxDecoration(color: bgColor3, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            right: -10,
            top: MediaQuery.of(context).size.height * 0.178,
            child: Container(
              height: 25,
              width: 25,
              decoration:
                  const BoxDecoration(color: bgColor3, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}
