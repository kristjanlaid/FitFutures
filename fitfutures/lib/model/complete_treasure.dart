class CompleteTreasure {
  int userId;
  int treasureId;

  CompleteTreasure({required this.userId, required this.treasureId});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'treasureId': treasureId,
    };
  }
}
