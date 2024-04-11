import 'package:cvmuproject/models/layout_questions_model.dart';
import 'package:cvmuproject/models/naviagation_questions_model.dart';
import 'package:cvmuproject/models/state_questions_model.dart';
import 'package:cvmuproject/models/widget_questions_model.dart';
import 'package:flutter/cupertino.dart';

const Color cardColor = Color(0xFF4993FA);

class FlutterTopics {
  final int id;
  final Map<String, String> topicName;
  final String topicIcon;
  final Color topicColor;
  final List<dynamic> topicQuestions;


  FlutterTopics({
    required this.id,
    required this.topicColor,
    required this.topicIcon,
    required this.topicName,
    required this.topicQuestions,
  });

  String getLocalizedTopicName(Locale locale) {
    return topicName[locale.languageCode] ?? topicName['en'] ?? topicName['gu']!;
  }
}

final List<FlutterTopics> flutterTopicsList = [
  FlutterTopics(
    id: 0,
    topicColor: cardColor,
    topicIcon: "assets/maths.png",
    topicName: {
      'en': "Mathematics",
      'gu': "ગણિત",
    },
    topicQuestions: widgetQuestionsList,
  ),
  FlutterTopics(
    id: 1,
    topicColor: cardColor,
    topicIcon: "assets/physics.png",
    topicName: {
      'en': "Physics",
      'gu': "ભૌતિક વિજ્ઞાન",
    },
    topicQuestions: stateQuestionsList,
  ),
  FlutterTopics(
    id: 2,
    topicColor: cardColor,
    topicIcon: "assets/chemistry.png",
    topicName: {
      'en': "Chemistry",
      'gu': "રસાયણ શાસ્ત્ર",
    },
    topicQuestions: navigateQuestionsList,
  ),
  FlutterTopics(
    id: 3,
    topicColor: cardColor,
    topicIcon: "assets/softskills.png",
    topicName:  {
      'en': "Soft Skills",
      'gu': "અંગ્રેજી",
    },
    topicQuestions: layOutQuestionsList,
  ),
];
