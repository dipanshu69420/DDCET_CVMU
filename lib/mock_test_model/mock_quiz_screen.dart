import 'dart:async';
import 'package:cvmuproject/views/results_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cvmuproject/views/home_screen.dart';
import 'package:cvmuproject/login/login.dart';

class MockQuizScreen extends StatefulWidget {
  final String topicType;
  final List<dynamic> questionlenght;
  final dynamic optionsList;
  const MockQuizScreen(
      {Key? key,
        required this.questionlenght,
        required this.optionsList,
        required this.topicType});

  @override
  State<MockQuizScreen> createState() => _MockQuizScreenState();
}

class _MockQuizScreenState extends State<MockQuizScreen> {
  int _quizDurationSeconds = 9000; // 2 hours
  Timer? _timer;
  int _questionNumber = 1;
  PageController _controller = PageController();
  int score = 0;
  bool isLocked = false;
  List optionsLetters = ["A.", "B.", "C.", "D."];
  List<int?> _selectedOptions = List.filled(4, null);
  late Locale _selectedLocale;


  void startQuizTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_quizDurationSeconds > 0) {
            _quizDurationSeconds--;
          } else {
            _timer?.cancel();
            navigateToResultsScreen();
          }
        });
      }
    });
  }


  void stopTime() {
    _timer?.cancel();
  }

  void navigateToResultsScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          score: score,
          totalQuestions: widget.questionlenght.length,
          whichTopic: widget.topicType,
          selectedLocale: _selectedLocale,
        ),
      ),
    );
  }

  void navigateToNewScreen() {
    if (!isLocked) {
      if (_questionNumber < widget.questionlenght.length) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInOut,
        );
        setState(() {
          _questionNumber++;
        });
      } else {
        _timer?.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(
              score: score,
              totalQuestions: widget.questionlenght.length,
              whichTopic: widget.topicType,
              selectedLocale: _selectedLocale,
            ),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _resetQuestionLocks();
    startQuizTimer();
    print("Starting...");
    print(Login.getSelectedLocale());
    if (Login.getSelectedLocale() == Locale('gu', 'IN')) {
      _selectedLocale = Locale('gu', 'IN');
    } else {
      _selectedLocale = Locale('en', 'US');
    }


  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor3 = Color(0xff0065A7);
    const Color buttonColor = Color(0xffFFB200);
    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(context, (route) => route.isFirst);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: bgColor3,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.topicType}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Time Left: ${_quizDurationSeconds ~/ 3600}h ${( _quizDurationSeconds % 3600) ~/ 60}m ${_quizDurationSeconds % 60}s",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14, bottom: 10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirmation"),
                                content: const Text("Are you sure you want to exit?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the alert dialog
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(selectedLocale: _selectedLocale),
                                        ),
                                      );
                                    },
                                    child: const Text('Exit'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          CupertinoIcons.clear,
                          color: Colors.white,
                          weight: 10,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.24),
                        blurRadius: 20.0,
                        offset: const Offset(0.0, 10.0),
                        spreadRadius: 10,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Question $_questionNumber/${widget.questionlenght.length}",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey.shade500),
                          ),
                          Expanded(
                            child: PageView.builder(
                              controller: _controller,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.questionlenght.length,
                              onPageChanged: (value) {
                                setState(() {
                                  _questionNumber = value + 1;
                                  isLocked = false;
                                  _resetQuestionLocks();
                                });
                              },
                              itemBuilder: (context, index) {
                                final myquestions =
                                widget.questionlenght[index];
                                var optionsIndex = widget.optionsList[index];

                                return Column(
                                  children: [
                                    Text(
                                      myquestions.text,
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: myquestions.options.length,
                                        itemBuilder: (context, index) {
                                          var color = Colors.grey.shade200;
                                          var questionOption = myquestions.options[index];
                                          final letters = optionsLetters[index];
                                          // Check if the current question is the previously attempted question
                                          if (_selectedOptions[index] != null && index == myquestions.options.indexOf(myquestions.selectedWiidgetOption)) {
                                            color = Colors.blue; // Change color to indicate the selected option
                                          }

                                          return InkWell(
                                            onTap: () {
                                              if (!myquestions.isLocked && !isLocked) {
                                                setState(() {
                                                  myquestions.isLocked = true;
                                                  myquestions.selectedWiidgetOption = questionOption;
                                                  print(questionOption);
                                                  _selectedOptions[index] = index;
                                                  isLocked = myquestions.isLocked;

                                                  // Award marks based on the user's answer
                                                  if (questionOption.isCorrect) {
                                                    score += 2;
                                                    print(score);// Correct answer
                                                  } else {
                                                    score -= 1;
                                                    print(score);// Incorrect answer
                                                  }
                                                });
                                              } else if (!myquestions.isLocked && isLocked) {
                                                setState(() {
                                                  myquestions.isLocked = true;
                                                  myquestions.selectedWiidgetOption = questionOption;
                                                  _selectedOptions[index] = index;
                                                  isLocked = myquestions.isLocked;
                                                });
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              margin: const EdgeInsets.symmetric(vertical: 8),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: color),
                                                color: Colors.grey.shade100,
                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "$letters ${questionOption.text}",
                                                      maxLines: 5,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(fontSize: 16),
                                                    ),
                                                  ),
                                                  isLocked
                                                      ? questionOption.isCorrect
                                                      ? const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.transparent, // Hide the icon
                                                  )
                                                      : const Icon(
                                                    Icons.cancel,
                                                    color: Colors.transparent, // Hide the icon
                                                  )
                                                      : const SizedBox.shrink()
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ),
                                    // isLocked
                                    //     ? buildElevatedButton()
                                    //     : const SizedBox.shrink(),
                                    const SizedBox(
                                      height: 5,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),

                          Row(
                            mainAxisAlignment: _questionNumber == 1
                                ? MainAxisAlignment.end // Align to the end for the first question
                                : MainAxisAlignment.spaceBetween, // Align with space between for other questions
                            children: [
                              if (_questionNumber > 1) // Show button only if not on the first question
                                TextButton(
                                  onPressed: () {
                                    _controller.previousPage(
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                    setState(() {
                                      _questionNumber--;
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Color(0xff0065A7)), // Change button background color to blue
                                  ),
                                  child: Text(
                                    _selectedLocale==const Locale("gu", "IN") ? 'પાછલો પ્રશ્ન' : 'Prev Question',
                                    style: TextStyle(
                                      color: Colors.white, // Change text color to white
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold, // Make text bold
                                    ),
                                  ),
                                ),
                              if (_questionNumber < widget.questionlenght.length) // Show button only if not on the last question
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (widget.questionlenght[_questionNumber - 1].selectedWiidgetOption != null) {
                                        widget.questionlenght[_questionNumber - 1].isLocked = true;
                                        isLocked = true;
                                      }
                                      if (_questionNumber < widget.questionlenght.length) {
                                        _controller.nextPage(
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                        _questionNumber++;
                                      }
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Color(0xff0065A7)), // Change button background color
                                  ),
                                  child: Text(
                                    _selectedLocale==const Locale("gu", "IN") ? 'આગળનો પ્રશ્ન' : 'Next Question',
                                    style: TextStyle(
                                      color: Colors.white, // Change text color to white
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold, // Make text bold
                                    ),
                                  ),
                                ),
                              if (_questionNumber == widget.questionlenght.length) // Show button only on the last question
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:  Text(_selectedLocale==const Locale("gu", "IN") ? 'ક્વિઝ સમાપ્ત કરો' : 'End Quiz'),
                                          content:Text(_selectedLocale==const Locale("gu", "IN") ? 'શું તમે ખરેખર ક્વિઝ સમાપ્ત કરવા અને પરિણામ બતાવવા માંગો છો?' : 'Are you sure you want to end the quiz and show the result?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close the alert dialog
                                              },
                                              child: Text(_selectedLocale==const Locale("gu", "IN") ? 'રદ કરો' : 'Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close the alert dialog
                                                navigateToResultsScreen(); // Navigate to the results screen
                                              },
                                              child: Text(_selectedLocale==const Locale("gu", "IN") ? 'હા' : 'Yes'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.orange), // Change button background color to orange
                                  ),
                                  child: Text(
                                    _selectedLocale==const Locale("gu", "IN") ? 'પરિણામ બતાવો' : 'Show Result', // Change button text to "Button"
                                    style: TextStyle(
                                      color: Colors.white, // Change text color to white
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold, // Make text bold
                                    ),
                                  ),
                                ),
                            ],
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/gcetlogo.jpg',
                                width: 60,
                                height: 60,
                              ),
                              const Spacer(),
                              Image.asset(
                                'assets/aditlogo.png',
                                width: 60,
                                height: 60,
                              ),
                              const Spacer(),
                              Image.asset(
                                'assets/mbitlogo.png',
                                width: 50,
                                height: 50,
                              ),
                              const Spacer(),
                              Image.asset(
                                'assets/bvmlogo.png',
                                width: 50,
                                height: 50,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resetQuestionLocks() {
    for (var question in widget.questionlenght) {
      question.isLocked = false;
    }
  }

  // ElevatedButton buildElevatedButton() {
  //   //  const Color bgColor3 = Color(0xFF5170FD);
  //   const Color cardColor = Color(0xFF4993FA);
  //   const Color buttonColor = Color(0xffFFB200);
  //   return ElevatedButton(
  //     style: ButtonStyle(
  //       backgroundColor: MaterialStateProperty.all(buttonColor),
  //       fixedSize: MaterialStateProperty.all(
  //         Size(MediaQuery.sizeOf(context).width * 0.80, 40),
  //       ),
  //       elevation: MaterialStateProperty.all(4),
  //     ),
  //     onPressed: () {
  //       if (_questionNumber < widget.questionlenght.length) {
  //         _controller.nextPage(
  //           duration: const Duration(milliseconds: 800),
  //           curve: Curves.easeInOut,
  //         );
  //         setState(() {
  //           _questionNumber++;
  //           isLocked = false;
  //         });
  //       } else {
  //         _timer?.cancel();
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => ResultsScreen(
  //               score: score,
  //               totalQuestions: widget.questionlenght.length,
  //               whichTopic: widget.topicType,
  //             ),
  //           ),
  //         );
  //       }
  //     },
  //     child: Text(
  //       _questionNumber < widget.questionlenght.length
  //           ? 'Next Question'
  //           : 'Result',
  //       style: Theme.of(context).textTheme.bodySmall!.copyWith(
  //         color: Colors.white,
  //         fontSize: 16,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //   );

}
