import 'package:cvmuproject/models/flutter_topics_model.dart';
import 'package:cvmuproject/models/widget_questions_model.dart';
import 'package:cvmuproject/network/api.dart';
import 'package:cvmuproject/prep_test_model/prep_test_screen.dart';
import 'package:cvmuproject/prep_test_model/selectionList.dart';
import 'package:cvmuproject/views/flashcard_screen.dart';
import 'package:cvmuproject/views/instruction_screen.dart';
import 'package:cvmuproject/mock_test_model//mock_quiz_screen.dart';
import 'package:cvmuproject/views/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_tex/flutter_tex.dart';
import 'dart:convert';
class HomePage extends StatefulWidget {
  final Locale selectedLocale;

  const HomePage({Key? key, required this.selectedLocale}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  late Locale _selectedLocale = Locale('en', 'US');
  late Map<String, String> _localizedStrings={};
  bool isLoading = false;
  int loadingCard = -1;
  late Api api;



  @override
  void initState() {
    super.initState();
    _selectedLocale = widget.selectedLocale;
    _loadLocalizedStrings(_selectedLocale);
    api = Api(_selectedLocale);
    api.getQuestion();
    fetchQuestions();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _showAdPopup();
    });

  }

  Future<void> _loadLocalizedStrings(Locale locale) async {
    String langCode = locale.languageCode;
    String countryCode = locale.countryCode ?? '';
    String localeName = langCode + (countryCode.isNotEmpty ? '_' + countryCode : '');

    String jsonContent = await DefaultAssetBundle.of(context).loadString('assets/lang/$localeName.json');
    Map<String, dynamic> decodedMap = jsonDecode(jsonContent);
    Map<String, String> localizedStrings = Map<String, String>.from(decodedMap);

    setState(() {
      _localizedStrings = localizedStrings;
    });
    print(localeName);
    print(widget.selectedLocale);
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

  void _showAdPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
            data: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
              ),
            ),
            child: AlertDialog(
              title: Center(child: const Text('Affiliated Colleges')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.asset(
                          'assets/gcetlogo.jpg',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'G H Patel College of Engineering & Technology',
                        style: TextStyle(fontSize: 12), // Adjust font size here
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.asset(
                          'assets/aditlogo.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'A D Patel Institute of Technology',
                        style: TextStyle(fontSize: 12), // Adjust font size here
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.asset(
                          'assets/mbitlogo.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Madhuben & Bhanubhai Institute of Technology',
                        style: TextStyle(fontSize: 12), // Adjust font size here
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.asset(
                          'assets/bvmlogo.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'BVM Engineering College',
                        style: TextStyle(fontSize: 12), // Adjust font size here
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ));
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF4993FA);
    const Color bgColor3 = Color(0xFF5170FD);
    if (_localizedStrings == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
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
                        text: _localizedStrings['ddcetPreparation'] ?? 'DDCET Preparation',
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
                                topicName: topicsData.getLocalizedTopicName(_selectedLocale),
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
                            // TeXView(
                            //   renderingEngine: TeXRenderingEngine.katex(),
                            //   child: TeXViewDocument(topicsData.topicName),
                            // ),
                            Text(
                              topicsData.getLocalizedTopicName(_selectedLocale),
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
                    print("modified : ");
                    print(response);
                    // Convert the response data into a list of WidgetQuestion objects
                    List<dynamic> widgetQuestionsList = api.converterToModel(response);

                    // Now you have access to widgetQuestionsList
                    // You can proceed to use this list in your QuizScreen or anywhere else

                    // Assuming randomOptions are available in the same order as questions
                    List<dynamic> randomOptions = widgetQuestionsList.map((question) => question.options).toList();

                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => InstructionScreen(
                          instructions: [
                            _localizedStrings['instruction1'] ?? 'The Duration for the Test will be 2.5 hours i.e. 150 mins.',
                            _localizedStrings['instruction2'] ?? 'The test contains 100 Questions which consists of questions of subjects Physics, Chemistry, Maths and English.',
                            _localizedStrings['instruction3'] ?? 'Two marks for each correct answer shall be awarded.',
                            _localizedStrings['instruction4'] ?? 'For each wrong answer and more than one attempted answer minus 0.5 (half) mark shall be added on obtained marks.',
                            _localizedStrings['instruction5'] ?? 'Unattempted answers will have zero marks.',
                          ],
                          onStartQuiz: () {
                            Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MockQuizScreen(
                                questionlenght: widgetQuestionsList,
                                optionsList: randomOptions,
                                topicType: "Mock Test",
                              ),
                            ),
                          );
                          },
                        ),
                      ),
                    );
                  },

                  child: Text(
                    _localizedStrings['mockTest'] ?? 'Mock Test',
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
                        builder: (context) => InstructionScreen(
                          instructions: [
                            _localizedStrings['instruction2'] ?? 'The test contains 100 Questions which consists of questions of subjects Physics, Chemistry, Maths and English.',
                            _localizedStrings['instruction3'] ?? 'Two marks for each correct answer shall be awarded.',
                            _localizedStrings['instruction4'] ?? 'For each wrong answer and more than one attempted answer minus 0.5 (half) mark shall be added on obtained marks.',
                            _localizedStrings['instruction5'] ?? 'Unattempted answers will have zero marks.',
                          ],
                          onStartQuiz: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => PrepQuizScreen(
                                  questionlenght: widgetQuestionsList,
                                  optionsList: randomOptions,
                                  topicType: "Prep Test",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },

                  child: Text(
                    _localizedStrings['prepTest'] ?? 'Prep Test',
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

