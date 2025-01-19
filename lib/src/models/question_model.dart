class QuizModel {
  String? id;
  String? name;
  String? title;
  String? description;
  String? difficultyLevel;
  String? topic;
  int? time;
  int? endTime;
  int? duration;
  double? negativeMarks;
  double? correctAnswerMarks;
  bool shuffle;
  bool showAnswers;
  bool lockSolutions;
  bool showMasteryOption;
  List<String>? readingMaterials;
  List<QuestionModel> questions;
  String? dailyDate;
  int maxMistakeCount;
  String? lives;
  int? coinCount;
  int? questionsCount;

  QuizModel({
    this.id,
    this.name,
    this.title,
    this.description,
    this.difficultyLevel,
    this.topic,
    this.time,
    this.endTime,
    this.duration,
    this.negativeMarks,
    this.correctAnswerMarks,
    this.shuffle = false,
    this.showAnswers = false,
    this.lockSolutions = false,
    this.showMasteryOption = false,
    this.readingMaterials,
    required this.questions,
    this.dailyDate,
    this.maxMistakeCount = 0,
    this.lives = "Unlimited",
    this.coinCount,
    this.questionsCount,

  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id']?.toString(),
      name: json['name'] ?? 'Untitled Quiz',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      difficultyLevel: json['difficulty_level'],
      topic: json['topic'] ?? 'General',
      time: int.tryParse(json['time']?.toString() ?? '0'),
      endTime: int.tryParse(json['end_time']?.toString() ?? '0'),
      duration: int.tryParse(json['duration']?.toString() ?? '0'),
      negativeMarks: double.tryParse(json['negative_marks']?.toString() ?? '0.0'),
      correctAnswerMarks: double.tryParse(json['correct_answer_marks']?.toString() ?? '1.0'),
      shuffle: json['shuffle'] ?? false,
      showAnswers: json['show_answers'] ?? false,
      lockSolutions: json['lock_solutions'] ?? false,
      showMasteryOption: json['show_mastery_option'] ?? false,
      readingMaterials: List<String>.from(json['reading_materials'] ?? []),
      questions: (json['questions'] as List)
          .map((questionJson) => QuestionModel.fromJson(questionJson))
          .toList(),
      dailyDate: json['daily_date']?.toString(),
      maxMistakeCount: int.tryParse(json['max_mistake_count']?.toString() ?? '0') ?? 0,
      lives: json['lives']?.toString() ?? 'Unlimited',
      coinCount: int.tryParse(json['coin_count']?.toString() ?? '0'),
      questionsCount: int.tryParse(json['questions_count']?.toString() ?? '0') ?? 0,
    );
  }
}

class QuestionModel {
  String? id;
  String? description;
  String? difficultyLevel;
  List<OptionModel> options;
  String? correctAnswer;
  String? detailedSolution;
  bool isAnswered;


  QuestionModel({
    this.id,
    this.description,
    this.difficultyLevel,
    required this.options,
    this.correctAnswer,
    this.detailedSolution,
    this.isAnswered = false,

  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id']?.toString(),
      description: json['description'],
      difficultyLevel: json['difficulty_level'],
      options: (json['options'] as List)
          .map((optionJson) => OptionModel.fromJson(optionJson))
          .toList(),
      correctAnswer: json['correct_answer'],
      detailedSolution: json['detailed_solution'],
    );
  }
}

class OptionModel {
  String? id;
  String? description;
  bool isCorrect;

  OptionModel({
    this.id,
    this.description,
    this.isCorrect = false,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id']?.toString(),
      description: json['description'],
      isCorrect: json['is_correct'] ?? false,
    );
  }
}
