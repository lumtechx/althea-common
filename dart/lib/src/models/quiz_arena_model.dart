import 'package:equatable/equatable.dart';
import '../mappers/quiz_arena_mapper.dart';

class ArenaQuiz {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final int totalTimeSeconds;
  final num maxScore;
  final int questionCount;
  final List<ArenaQuestion> questions;

  ArenaQuiz({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.totalTimeSeconds,
    required this.maxScore,
    required this.questionCount,
    required this.questions,
  });
}

class ArenaQuestion {
  final String id;
  final String questionText;
  final String questionType;
  final List<String> options;
  final num points;
  final int timeLimitSeconds;

  ArenaQuestion({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.options,
    required this.points,
    required this.timeLimitSeconds,
  });
}

class LeaderboardEntry {
  final String userId;
  final num score;
  final DateTime lastUpdated;

  LeaderboardEntry({
    required this.userId,
    required this.score,
    required this.lastUpdated,
  });
}

class CurrentUserLeaderboard {
  final int rank;
  final num score;
  final DateTime lastUpdated;

  CurrentUserLeaderboard({
    required this.rank,
    required this.score,
    required this.lastUpdated,
  });
}

class LeaderboardResult {
  final List<LeaderboardEntry> leaderboard;
  final CurrentUserLeaderboard? currentUser;

  LeaderboardResult({
    required this.leaderboard,
    required this.currentUser,
  });
}

class ArenaSubmissionResult {
  final String message;
  final num score;

  ArenaSubmissionResult({
    required this.message,
    required this.score,
  });
}

class QuizAttempt extends Equatable {
  final String userId;
  final DateTime startedAt;
  final DateTime? completedAt;
  final num? scoreEarned;

  const QuizAttempt({
    required this.userId,
    required this.startedAt,
    this.completedAt,
    this.scoreEarned,
  });

  factory QuizAttempt.fromMap(Map<String, dynamic> map) {
    return QuizArenaMapper.quizAttemptFromMap(map);
  }

  Map<String, dynamic> toMap() => QuizArenaMapper.quizAttemptToMap(this);

  Map<String, dynamic> toFirestore() => QuizArenaMapper.quizAttemptToFirestore(this);

  QuizAttempt copyWith({
    String? userId,
    DateTime? startedAt,
    DateTime? completedAt,
    num? scoreEarned,
  }) {
    return QuizAttempt(
      userId: userId ?? this.userId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      scoreEarned: scoreEarned ?? this.scoreEarned,
    );
  }

  @override
  List<Object?> get props => [userId, startedAt, completedAt, scoreEarned];
}

typedef ArenaQuizAttempt = QuizAttempt;
