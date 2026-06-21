import 'quiz_question_model.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import '../mappers/quiz_request_mapper.dart';

enum DifficultyLevel { easy, medium, hard }

enum QuizGenerationStatus {
  pending,
  processing,
  processed,
  completed,
  generationFailed,
  gradingFailed,
}

class SourceMaterial extends Equatable {
  final String url;
  final String name;
  final String id;
  final String? fileId;
  final String type;

  const SourceMaterial({
    required this.url,
    required this.id,
    required this.name,
    required this.fileId,
    required this.type,
  });

  factory SourceMaterial.fromMap(Map<String, dynamic> map) {
    return SourceMaterial(
      url: map['url'] as String,
      name: map['name'] as String,
      id: map['id'] as String,
      fileId: map['fileId'] as String?,
      type: map['type'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'url': url, 'name': name, 'id': id, 'fileId': fileId, 'type': type};
  }

  @override
  List<Object?> get props => [url, name, id, fileId];
}

class QuizGenerationRequest extends Equatable {
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
  final List<QuestionType> targetQuestionTypes;
  final double? grade;
  final String? summary;
  final String courseCode;

  const QuizGenerationRequest({
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
    this.grade,
    this.summary,
    required this.targetQuestionTypes,
    required this.courseCode,
  });

  // ---- Helper Getters ---
  String get formattedCreatedAt =>
      DateFormat('MMM d, yyyy \'at\' h:mm a').format(createdAt);

  factory QuizGenerationRequest.fromMap(
      Map<String, dynamic> map, DateTime? Function(dynamic value) dateParser) {
    return QuizRequestMapper.fromMap(map);
  }

  Map<String, dynamic> toMap() {
    return QuizRequestMapper.toMap(this);
  }

  QuizGenerationRequest copyWith({
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
    List<QuestionType>? targetQuestionTypes,
    double? grade,
    String? summary,
    String? courseCode,
  }) {
    return QuizGenerationRequest(
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
      targetQuestionTypes: targetQuestionTypes ?? this.targetQuestionTypes,
      grade: grade ?? this.grade,
      summary: summary ?? this.summary,
      courseCode: courseCode ?? this.courseCode,
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
        grade,
        summary,
        targetQuestionTypes,
        courseCode,
      ];
}

class QuizRequestBuilder {
  String? generationNickname;
  Map<String, SourceMaterial> sourceMaterials = {};
  String? customPrompt;
  int numQuestionsRequested = 10;
  DifficultyLevel difficultyLevel = DifficultyLevel.medium;
  List<QuestionType> targetQuestionTypes = [];
  final String courseCode;

  QuizRequestBuilder({required this.courseCode});

  QuizGenerationRequest build(String newId) {
    return QuizGenerationRequest(
      id: newId,
      generationNickname: generationNickname,
      sourceMaterials: sourceMaterials,
      customPrompt: customPrompt,
      numQuestionsRequested: numQuestionsRequested,
      difficultyLevel: difficultyLevel,
      targetQuestionTypes: targetQuestionTypes.isEmpty
          ? QuestionType.values
          : targetQuestionTypes,
      status: QuizGenerationStatus.pending,
      createdAt: DateTime.now(),
      courseCode: courseCode,
    );
  }
}
