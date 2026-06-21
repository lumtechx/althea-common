import '../models/quiz_arena_model.dart';
import '../utils/date_time_utils.dart';

class QuizArenaMapper {
  static ArenaQuiz arenaQuizFromMap(Map<String, dynamic> map) {
    return ArenaQuiz(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      startTime: DateTimeUtils.parse(map['startTime']) ?? DateTime.now(),
      endTime: DateTimeUtils.parse(map['endTime']) ?? DateTime.now(),
      totalTimeSeconds: map['totalTimeSeconds'] ?? 0,
      maxScore: map['maxScore'] ?? 0,
      questionCount: map['questionCount'] ?? 0,
    );
  }

  static Map<String, dynamic> arenaQuizToFirestore(ArenaQuiz quiz) {
    return {
      'id': quiz.id,
      'title': quiz.title,
      'startTime': quiz.startTime, // DateTime
      'endTime': quiz.endTime, // DateTime
      'totalTimeSeconds': quiz.totalTimeSeconds,
      'maxScore': quiz.maxScore,
      'questionCount': quiz.questionCount,
    };
  }

  static Map<String, dynamic> arenaQuizToMap(ArenaQuiz quiz) {
    return {
      'id': quiz.id,
      'title': quiz.title,
      'startTime': quiz.startTime.toIso8601String(), // String
      'endTime': quiz.endTime.toIso8601String(), // String
      'totalTimeSeconds': quiz.totalTimeSeconds,
      'maxScore': quiz.maxScore,
      'questionCount': quiz.questionCount,
    };
  }

  static ArenaQuestion arenaQuestionFromMap(Map<String, dynamic> map) {
    return ArenaQuestion(
      id: map['id'] ?? '',
      questionText: map['questionText'] ?? '',
      questionType: map['questionType'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      points: map['points'] ?? 0,
      timeLimitSeconds: map['timeLimitSeconds'] ?? 0,
    );
  }

  static Map<String, dynamic> arenaQuestionToMap(ArenaQuestion question) {
    return {
      'id': question.id,
      'questionText': question.questionText,
      'questionType': question.questionType,
      'options': question.options,
      'points': question.points,
      'timeLimitSeconds': question.timeLimitSeconds,
    };
  }

  static LeaderboardEntry leaderboardEntryFromMap(Map<String, dynamic> map) {
    return LeaderboardEntry(
      userId: map['userId'] ?? '',
      score: map['score'] ?? 0,
      lastUpdated: DateTimeUtils.parse(map['lastUpdated']) ?? DateTime.now(),
    );
  }

  static Map<String, dynamic> leaderboardEntryToFirestore(LeaderboardEntry entry) {
    return {
      'userId': entry.userId,
      'score': entry.score,
      'lastUpdated': entry.lastUpdated, // DateTime
    };
  }

  static Map<String, dynamic> leaderboardEntryToMap(LeaderboardEntry entry) {
    return {
      'userId': entry.userId,
      'score': entry.score,
      'lastUpdated': entry.lastUpdated.toIso8601String(), // String
    };
  }

  static CurrentUserLeaderboard? currentUserLeaderboardFromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return CurrentUserLeaderboard(
      rank: map['rank'] ?? 0,
      score: map['score'] ?? 0,
      lastUpdated: DateTimeUtils.parse(map['lastUpdated']) ?? DateTime.now(),
    );
  }

  static Map<String, dynamic>? currentUserLeaderboardToFirestore(CurrentUserLeaderboard? current) {
    if (current == null) return null;
    return {
      'rank': current.rank,
      'score': current.score,
      'lastUpdated': current.lastUpdated, // DateTime
    };
  }

  static Map<String, dynamic>? currentUserLeaderboardToMap(CurrentUserLeaderboard? current) {
    if (current == null) return null;
    return {
      'rank': current.rank,
      'score': current.score,
      'lastUpdated': current.lastUpdated.toIso8601String(), // String
    };
  }

  static ArenaSubmissionResult arenaSubmissionResultFromMap(Map<String, dynamic> map) {
    return ArenaSubmissionResult(
      message: map['message'] ?? '',
      score: map['score'] ?? 0,
    );
  }
}
