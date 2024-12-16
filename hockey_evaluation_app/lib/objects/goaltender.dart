class Goaltender {
  String name;
  String levelAge;
  String organization;
  bool watchlist = false;

  //store totals
  double adapt = 0;
  double drive = 0;
  double grow = 0;
  double learn = 0;
  double move = 0;
  double save = 0;
  double see = 0;
  double understand = 0;

  int totalEvaluations = 0;

  Goaltender(
      {required this.name, required this.levelAge, required this.organization});

  void toggleWatchlist() {
    watchlist = !watchlist;
  }

  void incrementTotalEvaluations() {
    totalEvaluations += 1;
  }

  void updateCategory(String category, double score) {
    switch (category) {
      case "Adapt":
        adapt += score;
      case "Drive":
        drive += score;
      case "Grow":
        grow += score;
      case "Learn":
        learn += score;
      case "Move":
        move += score;
      case "Save":
        save += score;
      case "See":
        see += score;
      case "Understand":
        understand += score;
      default:
        print("error, line 49 Goaltender");
    }
  }

  double getAverageScore(String category) {
    if (totalEvaluations == 0) {
      return 0.0;
    }
    switch (category) {
      case "Adapt":
        return adapt / totalEvaluations;
      case "Drive":
        return drive / totalEvaluations;
      case "Grow":
        return grow / totalEvaluations;
      case "Learn":
        return learn / totalEvaluations;
      case "Move":
        return move / totalEvaluations;
      case "Save":
        return save / totalEvaluations;
      case "See":
        return see / totalEvaluations;
      case "Understand":
        return understand / totalEvaluations;
      default:
        print("error: goaltender line 72");
        return 0.0;
    }
  }
}
