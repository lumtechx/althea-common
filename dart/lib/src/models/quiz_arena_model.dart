class ArenaQuiz {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final int totalTimeSeconds;
  final num maxScore;
  final int questionCount;

  ArenaQuiz({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.totalTimeSeconds,
    required this.maxScore,
    required this.questionCount,
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
