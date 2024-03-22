import 'dart:convert';

import 'package:cvmuproject/models/widget_questions_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as htmlDom;
import 'package:flutter_html/flutter_html.dart';
class Api {


  // Future<List<dynamic>> getRandomQuestions() async {
  //   final res = await http.get(
  //     Uri.parse('https://www.gcet.ac.in/ddcet/items/read'),
  //   );
  //   print(res.statusCode);
  //   print(res);
  //   if (res.statusCode == 200) {
  //     print("Success");
  //     print(res.request?.url.toString());
  //     // List<dynamic> resposne = jsonDecode(res.body);
  //     print("data :: ${jsonDecode(res.body)}");
  //     List<dynamic> response = converterToModelMock(jsonDecode(res.body));
  //     return response;
  //   } else {
  //     print("Fail");
  //     return [];
  //   }
  // }
  void getQuestion() async {
    final res = await http.get(
      Uri.parse('https://www.gcet.ac.in/ddcet/items/read'),
      headers: {"Content-Type": "application/json"},
    );
    print(res.statusCode);
    print(res);
    if (res.statusCode == 200) {
      print("Success");
      print(res.request?.url.toString());
      // List<dynamic> resposne = jsonDecode(res.body);
      print("data :: ${jsonDecode(res.body)}");
      List<dynamic> response = jsonDecode(res.body);
    } else {
      print("Fail");
    }
  }

  // Future getRandomQuestions() async {
  //   final res = await http.get(
  //     Uri.parse('https://www.gcet.ac.in/ddcet/items/read'),
  //     // Uri.parse('localhost/api.php'),
  //   );
  //   print(res.statusCode);
  //   print(res);
  //   if (res.statusCode == 200) {
  //     print("Success");
  //     print(res.request?.url.toString());
  //     List<dynamic> response = jsonDecode(res.body);
  //
  //     print("data :: ${jsonDecode(res.body)}");
  //     return response;
  //   } else {
  //     print("Fail");
  //     return [];
  //   }
  // }

  Future<List<Map<String, dynamic>>> getRandomQuestions() async {
    final res = await http.get(Uri.parse('http://localhost/api.php'));
    if (res.statusCode == 200) {
      final document = htmlParser.parse(res.body);
      final List<Map<String, dynamic>> questions = [];

      final questionsList = document.querySelectorAll('ul li');
      for (var i = 0; i < questionsList.length; i++) {
        final questionElement = questionsList[i];
        final questionText = parseHtmlText(questionElement.text);

        final optionsListElement = questionElement.nextElementSibling;
        if (optionsListElement != null) {
          final optionsList = optionsListElement.querySelectorAll('li');
          if (optionsList.length >= 5) {
            final optionA = parseHtmlText(optionsList[0].text.substring(3).trim());
            final optionB = parseHtmlText(optionsList[1].text.substring(3).trim());
            final optionC = parseHtmlText(optionsList[2].text.substring(3).trim());
            final optionD = parseHtmlText(optionsList[3].text.substring(3).trim());
            final answer = parseHtmlText(optionsList[4].text.substring(5).trim());

            questions.add({
              'question': questionText,
              'A': optionA,
              'B': optionB,
              'C': optionC,
              'D': optionD,
              'ANS': answer,
              'justification': '', // Justification and category are not included in the HTML
              'category': '',
            });
          }
        }
      }

      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }

  String parseHtmlText(String text) {
    return text.replaceAllMapped(RegExp(r'(\w+)\^(\w+)'), (match) {
      return '${match.group(1)}${match.group(2)}'; // Handle superscript (^)
    }).replaceAllMapped(RegExp(r'(\w+)!(\w+)'), (match) {
      return '${match.group(1)}${match.group(2)}'; // Handle subscript (!)
    });
  }



  Future<List<dynamic>> getQuestionCaategoryVise(int categoryid) async {
    print("Category value :: ${categoryid}");
    final res = await http.get(
      Uri.parse(
          'https://www.gcet.ac.in/ddcet/items/read?category=${categoryid}'),
      headers: {"Content-Type": "application/json"},
    );
    print(res.statusCode);
    print(res);
    if (res.statusCode == 200) {
      print("Success");
      print(res.request?.url.toString());
      // List<dynamic> resposne = jsonDecode(res.body);
      print("data :: ${jsonDecode(res.body)}");
      List<dynamic> response = converterToModel(jsonDecode(res.body));
      return response;
    } else {
      print("Fail");
      return [];
    }
  }

  // Future<List> getRandomQuestion() async {
  //   final res = await http.get(
  //     Uri.parse('https://www.gcet.ac.in/ddcet/items/read'),
  //     headers: {"Content-Type": "application/json"},
  //   );
  //   print(res);
  //   if (res.statusCode == 200) {
  //     List<dynamic>response = converterToModel(jsonDecode(res.body));
  //     return response;
  //   } else {
  //     return [];
  //   }
  // }


  // List<dynamic> converterToModel(List<dynamic> response) {
  //   var widgetQuestionsList = [];
  //   for (var element in response) {
  //     Map<String, dynamic> ele = element as Map<String, dynamic>;
  //     widgetQuestionsList.add(WidgetQuestion(
  //         text: ele["question"],
  //         options: [
  //           WiidgetOption(text: ele["A"], isCorrect: ele["ANS"] == "A"),
  //           WiidgetOption(text: ele["B"], isCorrect: ele["ANS"] == "B"),
  //           WiidgetOption(text: ele["C"], isCorrect: ele["ANS"] == "C"),
  //           WiidgetOption(text: ele["D"], isCorrect: ele["ANS"] == "D")
  //         ],
  //         id: ele["id"],
  //         correctAnswer:
  //         WiidgetOption(text: ele[ele["ANS"]], isCorrect: true)));
  //   }
  //   return widgetQuestionsList;
  // }


  List<WidgetQuestion> converterToModel(List<dynamic> response) {
    List<WidgetQuestion> widgetQuestionsList = [];
    for (var element in response) {
      if (element is Map<String, dynamic>) {
        String id = element["id"]?.toString() ?? '';
        String question = element["question"]?.toString() ?? '';
        String answer = element["ANS"]?.toString() ?? '';

        // Check for null values before accessing
        List<WiidgetOption> options = [];
        if (element["A"] != null) {
          options.add(WiidgetOption(
            text: element["A"].toString(),
            isCorrect: answer == "A",
          ));
        }
        if (element["B"] != null) {
          options.add(WiidgetOption(
            text: element["B"].toString(),
            isCorrect: answer == "B",
          ));
        }
        if (element["C"] != null) {
          options.add(WiidgetOption(
            text: element["C"].toString(),
            isCorrect: answer == "C",
          ));
        }
        if (element["D"] != null) {
          options.add(WiidgetOption(
            text: element["D"].toString(),
            isCorrect: answer == "D",
          ));
        }

        // Find correctAnswer based on the answer key
        WiidgetOption? correctAnswer;
        if (answer.isNotEmpty) {
          correctAnswer = options.firstWhere(
                (option) => option.text == element[answer].toString(),
            orElse: () => WiidgetOption(text: '', isCorrect: false),
          );
        }

        // Convert id to int
        int parsedId = int.tryParse(id) ?? 0;

        // Create WidgetQuestion object
        WidgetQuestion widgetQuestion = WidgetQuestion(
          id: parsedId,
          text: question,
          options: options,
          correctAnswer: correctAnswer ??
              WiidgetOption(text: '', isCorrect: false),
        );

        // Add to widgetQuestionsList
        widgetQuestionsList.add(widgetQuestion);
      }
    }
    return widgetQuestionsList;
  }
}