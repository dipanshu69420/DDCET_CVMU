import 'package:cvmuproject/models/layout_questions_model.dart';
import 'package:cvmuproject/models/naviagation_questions_model.dart';
import 'package:cvmuproject/models/state_questions_model.dart';
import 'package:cvmuproject/models/widget_questions_model.dart';
import 'package:flutter/cupertino.dart';

const Color cardColor = Color(0xFF4993FA);

class FlutterTopics {
  final int id;
  final String topicName;
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
}

final List<FlutterTopics> flutterTopicsList = [
  FlutterTopics(
    id: 0,
    topicColor: cardColor,
    topicIcon: "assets/maths.png",
    topicName: "Mathematics",
    topicQuestions: widgetQuestionsList,
  ),
  FlutterTopics(
    id: 1,
    topicColor: cardColor,
    topicIcon: "assets/physics.png",
    topicName: "Physics",
    topicQuestions: stateQuestionsList,
  ),
  FlutterTopics(
    id: 2,
    topicColor: cardColor,
    topicIcon: "assets/chemistry.png",
    topicName: "Chemistry",
    topicQuestions: navigateQuestionsList,
  ),
  FlutterTopics(
    id: 3,
    topicColor: cardColor,
    topicIcon: "assets/softskills.png",
    topicName: "Soft skills",
    topicQuestions: layOutQuestionsList,
  ),
];
