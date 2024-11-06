class Goaltender {
  String name;
  bool watchlist = false;

  Goaltender({required this.name});

  void toggleWatchlist() {
    watchlist = !watchlist;
  }
}
