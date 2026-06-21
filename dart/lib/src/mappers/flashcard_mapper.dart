import '../models/flashcard_model.dart';
import '../models/quiz_request.dart';
import '../utils/date_time_utils.dart';

class FlashcardMapper {
  static FlashcardGenerationRequest fromMap(Map<String, dynamic> map) {
    return FlashcardGenerationRequest(
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
      courseCode: map['courseCode'] as String? ?? '',
      remembrancePercentage: map['remembrancePercentage'] != null
          ? (map['remembrancePercentage'] as num).toDouble()
          : null,
    );
  }

  static Map<String, dynamic> toFirestore(FlashcardGenerationRequest request) {
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
      'courseCode': request.courseCode,
      'remembrancePercentage': request.remembrancePercentage,
    };
  }

  static Map<String, dynamic> toMap(FlashcardGenerationRequest request) {
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
      'courseCode': request.courseCode,
      'remembrancePercentage': request.remembrancePercentage,
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
