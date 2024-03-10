import 'dart:convert';

import 'package:cvmuproject/models/widget_questions_model.dart';
import 'package:http/http.dart' as http;

class Api {
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

  List<dynamic> converterToModel(List<dynamic> response) {
    var widgetQuestionsList = [];
    for (var element in response) {
      Map<String, dynamic> ele = element as Map<String, dynamic>;
      widgetQuestionsList.add(WidgetQuestion(
          text: ele["question"],
          options: [
            WiidgetOption(text: ele["A"], isCorrect: ele["ANS"] == "A"),
            WiidgetOption(text: ele["B"], isCorrect: ele["ANS"] == "B"),
            WiidgetOption(text: ele["C"], isCorrect: ele["ANS"] == "C"),
            WiidgetOption(text: ele["D"], isCorrect: ele["ANS"] == "D")
          ],
          id: ele["id"],
          correctAnswer:
              WiidgetOption(text: ele[ele["ANS"]], isCorrect: true)));
    }
    return widgetQuestionsList;
  }
}
