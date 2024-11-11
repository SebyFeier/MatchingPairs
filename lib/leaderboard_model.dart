class LeaderboardModel {
  final int level;
  final String theme;
  final int score;
  final String username;

  LeaderboardModel({required this.level, required this.theme, required this.score, required this.username});

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      level: json["level"],
      theme: json["theme"],
      score: json["score"],
      username: json["username"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'theme': theme,
      'score': score,
      'username': username,
    };
  }
}