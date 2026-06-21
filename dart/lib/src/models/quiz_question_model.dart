enum QuestionType { multipleChoice, trueFalse, shortAnswer, fillInTheBlank }

extension QuestionTypeExtension on QuestionType {
  String toJson() {
    switch (this) {
      case QuestionType.multipleChoice:
        return 'multiple-choice';
      case QuestionType.trueFalse:
        return 'true-false';
      case QuestionType.shortAnswer:
        return 'short-answer';
      case QuestionType.fillInTheBlank:
        return 'fill-in-the-blank';
    }
  }

  String formattedName() {
    String value = toJson();
    //Capitalize the firs

    value = value
        .replaceAll('-', ' ')
        .split(' ')
        .map((e) => e[0].toUpperCase() + e.substring(1))
        .join(' ');

    return value;
  }

  static QuestionType fromJson(String value) {
    switch (value) {
      case 'multiple-choice':
        return QuestionType.multipleChoice;
      case 'true-false':
        return QuestionType.trueFalse;
      case 'short-answer':
        return QuestionType.shortAnswer;
      case 'fill-in-the-blank':
        return QuestionType.fillInTheBlank;
      default:
        throw ArgumentError('Unknown QuestionType: $value');
    }
  }
}

class OpenEndedAnswer {
  final String? singleAnswer;
  final List<String>? answerVariants;

  OpenEndedAnswer._({this.singleAnswer, this.answerVariants});

  factory OpenEndedAnswer.fromJson(dynamic json) {
    if (json is String) {
      return OpenEndedAnswer._(singleAnswer: json);
    } else if (json is List) {
      return OpenEndedAnswer._(answerVariants: List<String>.from(json));
    }
    throw ArgumentError(
      'Invalid type for OpenEndedAnswer: ${json.runtimeType}',
    );
  }

  dynamic toJson() {
    if (singleAnswer != null) {
      return singleAnswer;
    } else if (answerVariants != null) {
      return answerVariants;
    }
    return null;
  }
}

sealed class Question {
  final String id;
  final QuestionType questionType;
  final String questionText;
  final String? explanation;
  dynamic userAnswer;

  Question({
    required this.id,
    required this.questionType,
    required this.questionText,
    required this.explanation,
    this.userAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final type = QuestionTypeExtension.fromJson(json['questionType']);
    switch (type) {
      case QuestionType.multipleChoice:
        return MultipleChoiceQuestion.fromJson(json);
      case QuestionType.trueFalse:
        return TrueFalseQuestion.fromJson(json);
      case QuestionType.shortAnswer:
        return ShortAnswerQuestion.fromJson(json);
      case QuestionType.fillInTheBlank:
        return FillInTheBlankQuestion.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();
}

class MultipleChoiceQuestion extends Question {
  final List<String> options;
  final int correctAnswer;

  MultipleChoiceQuestion({
    required super.questionText,
    required super.explanation,
    required this.options,
    required this.correctAnswer,
    required super.id,
    super.userAnswer,
  }) : super(questionType: QuestionType.multipleChoice);

  factory MultipleChoiceQuestion.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceQuestion(
      id: json['id'],
      questionText: json['questionText'],
      explanation: json['explanation'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
      userAnswer: json['userAnswer'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'questionType': questionType.toJson(),
      'questionText': questionText,
      'explanation': explanation,
      'options': options,
      'correctAnswer': correctAnswer,
      'userAnswer': userAnswer,
    };
  }
}

class TrueFalseQuestion extends Question {
  final bool correctAnswer;

  TrueFalseQuestion({
    required super.questionText,
    required super.explanation,
    required this.correctAnswer,
    required super.id,
    super.userAnswer,
  }) : super(questionType: QuestionType.trueFalse);

  factory TrueFalseQuestion.fromJson(Map<String, dynamic> json) {
    return TrueFalseQuestion(
      id: json['id'],
      questionText: json['questionText'],
      explanation: json['explanation'],
      correctAnswer: json['correctAnswer'],
      userAnswer: json['userAnswer'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'questionType': questionType.toJson(),
      'questionText': questionText,
      'explanation': explanation,
      'correctAnswer': correctAnswer,
      'userAnswer': userAnswer,
    };
  }
}

class ShortAnswerQuestion extends Question {
  final OpenEndedAnswer correctAnswer;

  ShortAnswerQuestion({
    required super.questionText,
    required super.explanation,
    required this.correctAnswer,
    required super.id,
    super.userAnswer,
  }) : super(questionType: QuestionType.shortAnswer);

  factory ShortAnswerQuestion.fromJson(Map<String, dynamic> json) {
    return ShortAnswerQuestion(
      id: json['id'],
      questionText: json['questionText'],
      explanation: json['explanation'],
      correctAnswer: OpenEndedAnswer.fromJson(json['correctAnswer']),
      userAnswer: json['userAnswer'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'questionType': questionType.toJson(),
      'questionText': questionText,
      'explanation': explanation,
      'correctAnswer': correctAnswer.toJson(),
      'userAnswer': userAnswer,
    };
  }
}

class FillInTheBlankQuestion extends Question {
  final OpenEndedAnswer correctAnswer;

  FillInTheBlankQuestion({
    required super.questionText,
    required super.explanation,
    required this.correctAnswer,
    required super.id,
    super.userAnswer,
  }) : super(questionType: QuestionType.fillInTheBlank);

  factory FillInTheBlankQuestion.fromJson(Map<String, dynamic> json) {
    return FillInTheBlankQuestion(
      id: json['id'],
      questionText: json['questionText'],
      explanation: json['explanation'],
      correctAnswer: OpenEndedAnswer.fromJson(json['correctAnswer']),
      userAnswer: json['userAnswer'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'questionType': questionType.toJson(),
      'questionText': questionText,
      'explanation': explanation,
      'correctAnswer': correctAnswer.toJson(),
      'userAnswer': userAnswer,
    };
  }
}

// class QuestionsOutput {
//   final String generationNickname;
//   final List<Question> questions;

//   QuestionsOutput({required this.generationNickname, required this.questions});

//   factory QuestionsOutput.fromJson(Map<String, dynamic> json) {
//     // This mapping uses the powerful `Question.fromJson` discriminator.
//     final questionsList = (json['questions'] as List)
//         .map((q) => Question.fromJson(q as Map<String, dynamic>))
//         .toList();

//     return QuestionsOutput(
//       generationNickname: json['generationNickname'],
//       questions: questionsList,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'generationNickname': generationNickname,
//       'questions': questions.map((q) => q.toJson()).toList(),
//     };
//   }
// }
