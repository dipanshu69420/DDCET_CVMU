class WidgetQuestion {
  final int id;
  final String text;
  final List<WiidgetOption> options;
  bool isLocked;
  WiidgetOption? selectedWiidgetOption;
  WiidgetOption correctAnswer;

  WidgetQuestion({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedWiidgetOption,
    required this.id,
    required this.correctAnswer,
  });

  WidgetQuestion copyWith() {
    return WidgetQuestion(
      id: id,
      text: text,
      options: options
          .map((option) =>
          WiidgetOption(text: option.text, isCorrect: option.isCorrect))
          .toList(),
      isLocked: isLocked,
      selectedWiidgetOption: selectedWiidgetOption,
      correctAnswer: correctAnswer,
    );
  }
}

class WiidgetOption {
  final String? text;
  final bool? isCorrect;

  const WiidgetOption({
    this.text,
    this.isCorrect,
  });
}

final widgetQuestionsList = [
  WidgetQuestion(
    text:
    "ABC?",
    options: [
      const WiidgetOption(text: "Hydrogen gas and iron chloride are produced", isCorrect: true),
      const WiidgetOption(text: "Chlorine gas and iron hydroxide are produced", isCorrect: false),
      const WiidgetOption(text: "No reaction takes place", isCorrect: false),
      const WiidgetOption(text: "Iron salt and water are produced", isCorrect: false),
    ],
    id: 0,
    correctAnswer: const WiidgetOption(text: "ListView", isCorrect: true),
  ),
  WidgetQuestion(
      text:
      "Unit of Force is ____",
      options: [
        const WiidgetOption(text: "Newton", isCorrect: true),
        const WiidgetOption(text: "Kg/sec", isCorrect: false),
        const WiidgetOption(text: "Joule", isCorrect: false),
        const WiidgetOption(text: "Watt", isCorrect: false),
      ],
      id: 1,
      correctAnswer: const WiidgetOption(text: "Expanded", isCorrect: true)),
  WidgetQuestion(
      text:
      "Solution of 3x-y=0 and x+y=4 in the form (x,y) is ",
      options: [
        const WiidgetOption(text: "(2,0)", isCorrect: false),
        const WiidgetOption(text: "(2,1)", isCorrect: false),
        const WiidgetOption(text: "(1,2)", isCorrect: false),
        const WiidgetOption(text: "(1,3)", isCorrect: true),
      ],
      id: 2,
      correctAnswer:
      const WiidgetOption(text: "CircleAvatar", isCorrect: true)),
  WidgetQuestion(
      text:
      "Lactic Acid is present in",
      options: [
        const WiidgetOption(text: "Orange", isCorrect: false),
        const WiidgetOption(text: "Tea", isCorrect: false),
        const WiidgetOption(text: "Curd", isCorrect: true),
        const WiidgetOption(text: "Vinegar", isCorrect: false),
      ],
      id: 3,
      correctAnswer: const WiidgetOption(text: "IconButton", isCorrect: true)),
  WidgetQuestion(
      text:
      " The absolute thermodynamic temperature scale is also referred as________",
      options: [
        const WiidgetOption(text: "Celcius Scale", isCorrect: false),
        const WiidgetOption(text: "Kelvin Scale", isCorrect: true),
        const WiidgetOption(text: "Both", isCorrect: false),
        const WiidgetOption(text: "None of the above", isCorrect: false),
      ],
      id: 4,
      correctAnswer: const WiidgetOption(text: "GridView", isCorrect: true)),
  WidgetQuestion(
      text:
      "I ___________ to the gym every day.",
      options: [
        const WiidgetOption(text: "Go", isCorrect: true),
        const WiidgetOption(text: "Goes", isCorrect: false),
        const WiidgetOption(text: "Went", isCorrect: false),
        const WiidgetOption(text: "Will go", isCorrect: false),
      ],
      id: 5,
      correctAnswer:
      const WiidgetOption(text: "ExpansionTile", isCorrect: true)),
  WidgetQuestion(
      text:
      " Equation of a line which passes through (1,-2) and cuts off equal intercepts on the axes is ___",
      options: [
        const WiidgetOption(text: "x+y=1", isCorrect: false),
        const WiidgetOption(text: "x-y=1", isCorrect: false),
        const WiidgetOption(text: "x+y=-1", isCorrect: true),
        const WiidgetOption(text: "x-y=-1", isCorrect: false),
      ],
      id: 6,
      correctAnswer: const WiidgetOption(text: "Container", isCorrect: true)),
  WidgetQuestion(
      text:
      "Light waves are",
      options: [
        const WiidgetOption(text: "Mechanical Waves", isCorrect: false),
        const WiidgetOption(text: "Non Mechanical Waves", isCorrect: true),
        const WiidgetOption(text: "Both A and B", isCorrect: false),
        const WiidgetOption(text: "None of the above", isCorrect: false),
      ],
      id: 7,
      correctAnswer:
      const WiidgetOption(text: "Image.network", isCorrect: true)),
  WidgetQuestion(
      text:
      "If the frequency of a wave is 60 Hz, what is its periodic time?",
      options: [
        const WiidgetOption(text: "0.02s", isCorrect: false),
        const WiidgetOption(text: "0.016s", isCorrect: true),
        const WiidgetOption(text: "0.5s", isCorrect: false),
        const WiidgetOption(text: "2s", isCorrect: false),
      ],
      id: 8,
      correctAnswer: const WiidgetOption(text: "InkWell", isCorrect: true)),
  WidgetQuestion(
      text:
      "The concert ___________ at 7 PM yesterday.",
      options: [
        const WiidgetOption(text: "Started", isCorrect: true),
        const WiidgetOption(text: "Starts", isCorrect: false),
        const WiidgetOption(text: "Will Start", isCorrect: false),
        const WiidgetOption(text: "Is Starting", isCorrect: false),
      ],
      id: 9,
      correctAnswer: const WiidgetOption(text: "Divider", isCorrect: true)),
  WidgetQuestion(
      text:
      "Which of the following reaction can also be termed a thermal decomposition reaction?",
      options: [
        const WiidgetOption(text: "Combination Reaction", isCorrect: false),
        const WiidgetOption(text: "Decomposition Reaction", isCorrect: true),
        const WiidgetOption(text: "Displacement Reaction", isCorrect: false),
        const WiidgetOption(text: "Double Displacement Reaction", isCorrect: false),
      ],
      id: 10,
      correctAnswer: const WiidgetOption(
          text: "CircularProgressIndicator", isCorrect: true)),
  WidgetQuestion(
      text:
      "The maximum distance from the equilibrium is known as ____",
      options: [
        const WiidgetOption(text: "Wavelength", isCorrect: false),
        const WiidgetOption(text: "Frequency", isCorrect: true),
        const WiidgetOption(text: "Amplitude", isCorrect: false),
        const WiidgetOption(text: "Periodic Time", isCorrect: false),
      ],
      id: 11,
      correctAnswer: const WiidgetOption(text: "Tooltip", isCorrect: true)),
  WidgetQuestion(
      text:
      "The slope of a line which makes an angle -π/4 with the positive direction of X-axis is ",
      options: [
        const WiidgetOption(text: "-1", isCorrect: true),
        const WiidgetOption(text: "1", isCorrect: false),
        const WiidgetOption(text: "1/2", isCorrect: false),
        const WiidgetOption(text: "0", isCorrect: false),
      ],
      id: 12,
      correctAnswer: const WiidgetOption(text: "assets", isCorrect: true)),
  WidgetQuestion(
      text:
      "If y=xsinx + cosx, then dy/dx=________.",
      options: [
        const WiidgetOption(text: "xcosx- sinx", isCorrect: false),
        const WiidgetOption(text: "xsinx", isCorrect: false),
        const WiidgetOption(text: "xcosx", isCorrect: true),
        const WiidgetOption(text: "xcos + 2sinx", isCorrect: false),
      ],
      id: 13,
      correctAnswer: const WiidgetOption(text: "Dart", isCorrect: true)),
  WidgetQuestion(
    text:
    "She ___________ for the company for five years before she got promoted.",
    options: [
      const WiidgetOption(text: "Works", isCorrect: false),
      const WiidgetOption(text: "Is Working", isCorrect: false),
      const WiidgetOption(text: "will Work", isCorrect: false),
      const WiidgetOption(text: "Worked", isCorrect: true),
    ],
    id: 14,
    correctAnswer:
    const WiidgetOption(text: "Platform channels", isCorrect: true),
  ),
  // WidgetQuestion(
  //   text:
  //   "I am a property that uniquely identifies a widget and allows it to be updated efficiently. What am I?",
  //   options: [
  //     const WiidgetOption(text: "key", isCorrect: true),
  //     const WiidgetOption(text: "id", isCorrect: false),
  //     const WiidgetOption(text: "name", isCorrect: false),
  //     const WiidgetOption(text: "tag", isCorrect: false),
  //   ],
  //   id: 15,
  //   correctAnswer: const WiidgetOption(text: "key", isCorrect: true),
  // ),
];
