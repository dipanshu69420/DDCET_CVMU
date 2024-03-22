import 'package:flutter/material.dart';
import 'package:cvmuproject/prep_test_model/prep_test_screen.dart';

class TopicSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Subject'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTopicCard(context, 'Physics', 1),
          buildTopicCard(context, 'Chemistry', 2),
          buildTopicCard(context, 'Mathematics', 3),
          buildTopicCard(context, 'Soft Skills', 4),
        ],
      ),
    );
  }

  Widget buildTopicCard(BuildContext context, String topic, int id) {
    return GestureDetector(
      onTap: () {
        // Navigate to the quiz screen for the selected topic
        // You can pass the selected topic and category to the quiz screen
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PrepQuizScreen(topicType: topic, category: category),
        //   ),
        // );
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        color: Color(0xff0065A7),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              topic,
              style: TextStyle(
                color: Colors.white, // Set text color to white
                fontWeight: FontWeight.bold, // Make text bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}
