import 'package:cvmuproject/views/results_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cvmuproject/views/home_screen.dart';
import 'package:cvmuproject/login/login.dart';

class QuizScreen extends StatefulWidget {
  final String topicType;
  final List<dynamic> questionlenght;
  final dynamic optionsList;
  const QuizScreen(
      {super.key,
        required this.questionlenght,
        required this.optionsList,
        required this.topicType});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionNumber = 1;
  PageController _controller = PageController();
  int score = 0;
  bool isLocked = false;
  List optionsLetters = ["A.", "B.", "C.", "D."];
  late Locale _selectedLocale;

  void navigateToNewScreen() {
    if (_questionNumber < widget.questionlenght.length) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeInOut,
      );
      setState(() {
        _questionNumber++;
        isLocked = false;
      });
      _resetQuestionLocks();
    } else {
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

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _resetQuestionLocks();
    if (Login.getSelectedLocale() == Locale('gu', 'IN')) {
      _selectedLocale = Locale('gu', 'IN');
    } else {
      _selectedLocale = Locale('en', 'US');
    }
  }

  @override
  void dispose() {
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
                      "${widget.topicType} Quiz",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
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
                          Navigator.pushReplacement(
                              context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(selectedLocale: _selectedLocale),
                            ),);
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
                                  _questionNumber = value + 2;
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
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

                                          var questionOption =
                                          myquestions.options[index];
                                          final letters = optionsLetters[index];

                                          if (myquestions.isLocked) {
                                            if (questionOption ==
                                                myquestions
                                                    .selectedWiidgetOption) {
                                              color = questionOption.isCorrect
                                                  ? Colors.green
                                                  : Colors.red;
                                            } else if (questionOption
                                                .isCorrect) {
                                              color = Colors.green;
                                            }
                                          }
                                          return InkWell(
                                            onTap: () {
                                              if (!myquestions.isLocked) {
                                                setState(() {
                                                  myquestions.isLocked = true;
                                                  myquestions
                                                      .selectedWiidgetOption =
                                                      questionOption;
                                                });

                                                isLocked = myquestions.isLocked;
                                                if (myquestions
                                                    .selectedWiidgetOption
                                                    .isCorrect) {
                                                  score++;
                                                }
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              margin: const EdgeInsets.symmetric(
                                                  vertical: 8),
                                              decoration: BoxDecoration(
                                                border:
                                                Border.all(color: color),
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "$letters ${questionOption.text}",
                                                      maxLines: 5,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  isLocked == true
                                                      ? questionOption.isCorrect
                                                      ? const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                  )
                                                      : const Icon(
                                                    Icons.cancel,
                                                    color: Colors.red,
                                                  )
                                                      : const SizedBox.shrink()
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    isLocked
                                        ? buildElevatedButton()
                                        : const SizedBox.shrink(),
                                    const SizedBox(
                                      height: 5,
                                    )
                                  ],
                                );
                              },
                            ),
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

  ElevatedButton buildElevatedButton() {
    //  const Color bgColor3 = Color(0xFF5170FD);
    const Color cardColor = Color(0xFF4993FA);
    const Color buttonColor = Color(0xffFFB200);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        fixedSize: MaterialStateProperty.all(
          Size(MediaQuery.sizeOf(context).width * 0.80, 40),
        ),
        elevation: MaterialStateProperty.all(4),
      ),
      onPressed: () {
        if (_questionNumber < widget.questionlenght.length) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
          setState(() {
            _questionNumber++;
            isLocked = false;
          });
          _resetQuestionLocks();
        } else {
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
      },
      child: Text(
        _questionNumber < widget.questionlenght.length
            ?  _selectedLocale==const Locale("gu", "IN") ? 'આગળનો પ્રશ્ન' : 'Next Question'
            :  _selectedLocale==const Locale("gu", "IN") ? 'પરિણામ' : 'Result',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
