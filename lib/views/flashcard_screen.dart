import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cvmuproject/views/quiz_screen.dart';
import 'package:cvmuproject/widgets/flash_card_widget.dart';
import 'package:cvmuproject/widgets/linear_progress_indicator_widget.dart';
import 'package:cvmuproject/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cvmuproject/login/login.dart';

class NewCard extends StatefulWidget {
  final String topicName;
  final List<dynamic> typeOfTopic;
  const NewCard(
      {super.key, required this.topicName, required this.typeOfTopic});

  @override
  State<NewCard> createState() => _NewCardState();
}

class _NewCardState extends State<NewCard> {
  final AppinioSwiperController controller = AppinioSwiperController();
  late Locale _selectedLocale;

  @override
  void initState() {
    print("Starting...");
    print(Login.getSelectedLocale());
    if (Login.getSelectedLocale() == Locale('gu', 'IN')) {
      _selectedLocale = Locale('gu', 'IN');
    } else {
      _selectedLocale = Locale('en', 'US');
    }


  }

  Widget build(BuildContext context) {
    //const Color bgColor = Color(0xFF4993FA);
    const Color bgColor3 = Color(0xFF5170FD);
    const Color cardColor = Color(0xff0065A7);
    const Color buttonColor = Color(0xffFFB200);

    // Get a list of 4 randomly selected Questions objects
    Map<dynamic, dynamic> randomQuestionsMap = getRandomQuestionsAndOptions(
        widget.typeOfTopic, widget.typeOfTopic.length);

    List<dynamic> randomQuestions = randomQuestionsMap.keys.toList();
    dynamic randomOptions = randomQuestionsMap.values.toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(right: 18.0),
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(selectedLocale: _selectedLocale),
                          ),
                        );
                      },
                      icon: const Icon(
                        CupertinoIcons.clear,
                        color: Color(0xff234277),
                        weight: 20,
                      ),
                    ),
                    // MyProgressIndicator(
                    //   questionlenght: randomQuestions,
                    //   optionsList: randomOptions,
                    //   topicType: widget.topicName,
                    // ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                height: MediaQuery.of(context).size.height * 0.60,
                child: AppinioSwiper(
                  cardBuilder: (BuildContext context, int index) {
                    var cardIndex = randomQuestions[index];
                    return FlipCardsWidget(
                      bgColor: cardColor,
                      cardsLenght: randomQuestions.length,
                      currentIndex: index + 1,
                      answer: cardIndex.correctAnswer.text,
                      question: cardIndex.text,
                      currentTopic: widget.topicName,
                    );
                  },

                  // padding: const EdgeInsets.all(10),
                  loop: true,
                  backgroundCardCount: 2,
                  swipeOptions: const SwipeOptions.all(),
                  allowUnlimitedUnSwipe: true,
                  // unlimitedUnswipe: true,
                  controller: controller,
                  // onUnSwipe:_unswipe ,
                  // unswipe: _unswipe,
                  // onSwipe: _swipe,
                  // onEnd: _onEnd,
                  cardCount: randomQuestions.length,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(buttonColor),
                      fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width * 0.85, 30),
                      ),
                      elevation: MaterialStateProperty.all(4),
                    ),
                    onPressed: () => controller.unswipe(),
                    child: Text(
                      _selectedLocale==const Locale("gu", "IN") ? 'કાર્ડ્સ ફરીથી ગોઠવો' : 'Rearrange Cards',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(buttonColor),
                      fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.sizeOf(context).width * 0.85, 30),
                      ),
                      elevation: MaterialStateProperty.all(4),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(
                            questionlenght: randomQuestions,
                            optionsList: randomOptions,
                            topicType: widget.topicName,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      _selectedLocale==const Locale("gu", "IN") ? 'વિષય ક્વિઝ તૈયાર કરો' : 'Prepare Subject Quiz',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<dynamic, dynamic> getRandomQuestionsAndOptions(
  List<dynamic> allQuestions,
  int count,
) {
  final randomQuestions = <dynamic>[];
  final randomOptions = <dynamic>[];
  final random = Random();

  if (count >= allQuestions.length) {
    count = allQuestions.length;
  }

  while (randomQuestions.length < count) {
    final randomIndex = random.nextInt(allQuestions.length);
    final selectedQuestion = allQuestions[randomIndex];

    if (!randomQuestions.contains(selectedQuestion)) {
      randomQuestions.add(selectedQuestion);
      randomOptions.add(selectedQuestion.options);
    }
  }

  return Map.fromIterables(randomQuestions, randomOptions);
}

// List<dynamic> getRandomQuestions(List<dynamic> allQuestions, int count) {
//   if (count >= allQuestions.length) {
//     return List.from(allQuestions);
//   }
//   List<dynamic> randomQuestions = [];

//   List<int> indexes = List.generate(allQuestions.length, (index) => index);
//   final random = Random();

//   while (randomQuestions.length < count) {
//     final randomIndex = random.nextInt(indexes.length);
//     final selectedQuestionIndex = indexes[randomIndex];
//     final selectedQuestion = allQuestions[selectedQuestionIndex];
//     randomQuestions.add(selectedQuestion);

//     indexes.removeAt(randomIndex);
//   }
//   return randomQuestions;
// }

// void _swipe(int index, SwiperDirection direction) {
//   print("the card was swiped to the: ${direction.name}");
//   print(index);
// }

// void _unswipe(bool unswiped) {
//   if (unswiped) {
//     print("SUCCESS: card was unswiped");
//   } else {
//     print("FAIL: no card left to unswipe");
//   }
// }

// void _onEnd() {
//   print("end reached!");
// }
