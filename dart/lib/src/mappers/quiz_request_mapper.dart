import '../models/quiz_request.dart';
import '../models/quiz_question_model.dart';
import '../utils/date_time_utils.dart';

class QuizRequestMapper {
  static QuizGenerationRequest fromMap(Map<String, dynamic> map) {
    return QuizGenerationRequest(
      id: map['id'] as String,
      generationNickname: map['generationNickname'] as String?,
      sourceMaterials: Map<String, dynamic>.from(map['sourceMaterials'] ?? {}).map(
        (key, value) => MapEntry(key, SourceMaterial.fromMap(value)),
      ),
      customPrompt: map['customPrompt'] as String?,
      numQuestionsRequested: map['numQuestionsRequested'] as int? ?? 10,
      difficultyLevel: parseDifficultyLevel(map['difficultyLevel'] as String? ?? 'medium'),
      status: parseQuizGenerationStatus(map['status'] as String? ?? 'pending'),
      createdAt: DateTimeUtils.parse(map['createdAt']) ?? DateTime.now(),
      completedAt: DateTimeUtils.parse(map['completedAt']),
      errorMessage: map['errorMessage'] as String?,
      questionsCount: map['questionsCount'] as int?,
      targetQuestionTypes: (map['targetQuestionTypes'] as List<dynamic>?)
              ?.map((item) => QuestionTypeExtension.fromJson(item as String))
              .toList() ??
          [],
      grade: (map['grade'] as num?)?.toDouble(),
      summary: map['summary'] as String?,
      courseCode: map['courseCode'] as String? ?? '',
    );
  }

  static Map<String, dynamic> toFirestore(QuizGenerationRequest request) {
    return {
      'id': request.id,
      'generationNickname': request.generationNickname,
      'sourceMaterials': request.sourceMaterials.map(
        (key, value) => MapEntry(key, value.toMap()),
      ),
      'customPrompt': request.customPrompt,
      'numQuestionsRequested': request.numQuestionsRequested,
      'difficultyLevel': request.difficultyLevel.name,
      'status': request.status.name,
      'createdAt': request.createdAt, // DateTime
      if (request.completedAt != null) 'completedAt': request.completedAt, // DateTime
      'errorMessage': request.errorMessage,
      'questionsCount': request.questionsCount,
      'grade': request.grade,
      'summary': request.summary,
      'targetQuestionTypes':
          request.targetQuestionTypes.map((e) => e.toJson()).toList(),
      'courseCode': request.courseCode,
    };
  }

  static Map<String, dynamic> toMap(QuizGenerationRequest request) {
    return {
      'id': request.id,
      'generationNickname': request.generationNickname,
      'sourceMaterials': request.sourceMaterials.map(
        (key, value) => MapEntry(key, value.toMap()),
      ),
      'customPrompt': request.customPrompt,
      'numQuestionsRequested': request.numQuestionsRequested,
      'difficultyLevel': request.difficultyLevel.name,
      'status': request.status.name,
      'createdAt': request.createdAt.toIso8601String(), // String
      if (request.completedAt != null) 'completedAt': request.completedAt!.toIso8601String(), // String
      'errorMessage': request.errorMessage,
      'questionsCount': request.questionsCount,
      'grade': request.grade,
      'summary': request.summary,
      'targetQuestionTypes':
          request.targetQuestionTypes.map((e) => e.toJson()).toList(),
      'courseCode': request.courseCode,
    };
  }

  static DifficultyLevel parseDifficultyLevel(String value) {
    switch (value) {
      case 'easy':
        return DifficultyLevel.easy;
      case 'medium':
        return DifficultyLevel.medium;
      case 'hard':
        return DifficultyLevel.hard;
      default:
        throw ArgumentError('Invalid DifficultyLevel: $value');
    }
  }

  static QuizGenerationStatus parseQuizGenerationStatus(String value) {
    switch (value) {
      case 'pending':
        return QuizGenerationStatus.pending;
      case 'processing':
        return QuizGenerationStatus.processing;
      case 'processed':
        return QuizGenerationStatus.processed;
      case 'completed':
        return QuizGenerationStatus.completed;
      case 'grading_failed':
      case 'gradingFailed':
        return QuizGenerationStatus.gradingFailed;
      case 'generation_failed':
      case 'generationFailed':
        return QuizGenerationStatus.generationFailed;
      default:
        throw ArgumentError('Invalid QuizGenerationStatus: $value');
    }
  }
}
