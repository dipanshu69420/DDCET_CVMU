import 'package:flutter/material.dart';

class InstructionScreen extends StatelessWidget {
  final List<String> instructions;
  final VoidCallback onStartQuiz;

  const InstructionScreen({
    Key? key,
    required this.instructions,
    required this.onStartQuiz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0065A7), // Set the app bar color to 0xff0065A7
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white, // Set the icon color to white
        ),
      ),
      backgroundColor: Color(0xff0065A7), // Set the background color to 0xff0065A7
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Instructions:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white, // Set the instruction card's background color to white
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: instructions.map((instruction) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.circle, size: 10),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              instruction.trim(),
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onStartQuiz,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Color(0xff0065A7)),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                child: Text('Start Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
