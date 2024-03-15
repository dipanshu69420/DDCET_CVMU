import 'package:cvmuproject/models/flutter_topics_model.dart';
import 'package:cvmuproject/models/widget_questions_model.dart';
import 'package:cvmuproject/network/api.dart';
import 'package:cvmuproject/views/flashcard_screen.dart';
import 'package:cvmuproject/mock_test_model/mock_quiz_screen.dart';
import 'package:cvmuproject/views/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  int loadingCard = -1;
  Api api = new Api();
  @override
  void initState() {
    super.initState();
    // api.getQuestion();
    fetchQuestions();
  }
  void fetchQuestions() {
    try {
      setState(() {
        isLoading = true;
      });
      api.getQuestion(); // Assuming getQuestion method fetches questions from the API
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching questions: $e");
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF4993FA);
    const Color bgColor3 = Color(0xFF5170FD);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.24),
                      blurRadius: 20.0,
                      offset: const Offset(0.0, 10.0),
                      spreadRadius: -10,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                ),
                child: Image.asset(
                  "assets/cvmu-logo.png",
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "DDCET Preparation",
                        style:
                        Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: 24,
                          color: Color(0xff0065A7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.85,
                ),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: flutterTopicsList.length,
                itemBuilder: (context, index) {
                  final topicsData = flutterTopicsList[index];
                  return InkWell(
                    onTap: () {
                      try {
                        setState(() {
                          isLoading = true;
                          loadingCard = topicsData.id;
                        });
                        print(topicsData.topicName);
                        api.getQuestionCaategoryVise(index + 1).then((value) {
                          print('Value :: ${value}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewCard(
                                typeOfTopic: value,
                                topicName: topicsData.topicName,
                              ),
                            ),
                          ).then((value) {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        });
                      } catch (e) {
                        print("error :: " + e.toString());
                      }
                    },
                    child: Card(
                      color: Color(0xff0084CA),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: (isLoading && loadingCard == index)
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: bgColor,
                        ),
                      )
                          : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              topicsData.topicIcon,
                              height: 60,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              topicsData.topicName,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          // ignore: sort_child_properties_last
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    // Call your API to fetch questions data
                    List<dynamic> response = await api.getRandomQuestions();
                    print(response);
                    // Convert the response data into a list of WidgetQuestion objects
                    List<dynamic> widgetQuestionsList = api.converterToModel(response);

                    // Now you have access to widgetQuestionsList
                    // You can proceed to use this list in your QuizScreen or anywhere else

                    // Assuming randomOptions are available in the same order as questions
                    List<dynamic> randomOptions = widgetQuestionsList.map((question) => question.options).toList();

                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(
                          questionlenght: widgetQuestionsList,
                          optionsList: randomOptions,
                          topicType: "Mock Test",
                        ),
                      ),
                    );
                    },

                  child: Text(
                    "Mock Test",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const VerticalDivider(),
                InkWell(
                  // onTap: () async {
                  //   try {
                  //     setState(() {
                  //       isLoading = true;
                  //     });
                  //     List<WidgetQuestion> getQuestions = await api.getRandomQuestion();
                  //     if (getQuestions.isNotEmpty) {
                  //       await Navigator.of(context).push(
                  //         MaterialPageRoute(
                  //           builder: (context) => MockQuizScreen(
                  //             questionlenght: getQuestions,
                  //             optionsList: getQuestions.map((question) => question.options).toList(), // Pass the optionsList here
                  //
                  //             topicType: "Mock Test",
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //   } catch (e) {
                  //     print("Error: $e");
                  //   } finally {
                  //     setState(() {
                  //       isLoading = false;
                  //     });
                  //   }
                  // },

                  child: Text(
                    "Prep. Test",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.070,
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff0084CA),
            // ignore: prefer_const_constructors
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   // ignore: prefer_const_literals_to_create_immutables
            //   colors: [const Color(0xff234277), const Color(0xff0084ca)],
            // ),
          ),
        ),
      ),
    );
    Navigator.maybePop(context);
  }
}
