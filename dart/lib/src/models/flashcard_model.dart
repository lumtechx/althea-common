import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'quiz_request.dart';
import '../mappers/flashcard_mapper.dart';

class FlashcardItem {
  final String id;
  final String question;
  final String answer;

  FlashcardItem({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FlashcardItem.fromMap(Map<String, dynamic> map) {
    return FlashcardItem(
      id: map['id'] as String,
      question: map['questionText'] as String,
      answer: map['answer'] as String,
    );
  }
}

class FlashcardGenerationRequest extends Equatable {
  final String id;
  final String? generationNickname;
  final Map<String, SourceMaterial> sourceMaterials;
  final String? customPrompt;
  final int numQuestionsRequested;
  final DifficultyLevel difficultyLevel;
  final QuizGenerationStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? errorMessage;
  final int? questionsCount;
  final String courseCode;
  final double? remembrancePercentage;

  const FlashcardGenerationRequest({
    required this.id,
    this.generationNickname,
    required this.sourceMaterials,
    this.customPrompt,
    required this.numQuestionsRequested,
    required this.difficultyLevel,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.errorMessage,
    this.questionsCount,
    required this.courseCode,
      this.remembrancePercentage,
  });

  // ---- Helper Getters ---
  String get formattedCreatedAt =>
      DateFormat('MMM d, yyyy \'at\' h:mm a').format(createdAt);

  factory FlashcardGenerationRequest.fromMap(Map<String, dynamic> map) {
    return FlashcardMapper.fromMap(map);
  }

  Map<String, dynamic> toMap() {
    return FlashcardMapper.toMap(this);
  }

  FlashcardGenerationRequest copyWith({
    String? id,
    String? generationNickname,
    Map<String, SourceMaterial>? sourceMaterials,
    String? customPrompt,
    int? numQuestionsRequested,
    DifficultyLevel? difficultyLevel,
    QuizGenerationStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
    String? errorMessage,
    int? questionsCount,
    String? courseCode,
    double? remembrancePercentage,
  }) {
    return FlashcardGenerationRequest(
      id: id ?? this.id,
      generationNickname: generationNickname ?? this.generationNickname,
      sourceMaterials: sourceMaterials ?? this.sourceMaterials,
      customPrompt: customPrompt ?? this.customPrompt,
      numQuestionsRequested:
      numQuestionsRequested ?? this.numQuestionsRequested,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      errorMessage: errorMessage ?? this.errorMessage,
      questionsCount: questionsCount ?? this.questionsCount,
      courseCode: courseCode ?? this.courseCode,
      remembrancePercentage: remembrancePercentage ?? this.remembrancePercentage,
    );
  }



  @override
  List<Object?> get props => [
    id,
    generationNickname,
    sourceMaterials,
    customPrompt,
    numQuestionsRequested,
    difficultyLevel,
    status,
    createdAt,
    completedAt,
    errorMessage,
    questionsCount,
    courseCode,
  ];
}
