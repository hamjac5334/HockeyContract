class Goaltender {
  String name;
  String levelAge;
  String organization;
  bool watchlist = false;

  Goaltender(
      {required this.name, required this.levelAge, required this.organization});

  void toggleWatchlist() {
    watchlist = !watchlist;
  }
}
