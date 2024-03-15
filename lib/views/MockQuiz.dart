import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cvmuproject/views/quiz_screen.dart';
import 'package:cvmuproject/widgets/flash_card_widget.dart';
import 'package:cvmuproject/widgets/linear_progress_indicator_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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

  @override
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
