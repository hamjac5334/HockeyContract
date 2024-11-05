class ScoreList {
  ScoreList({required this.name});
  final String name;
  int count = 0;

  void increase(){
    if ( count < 2) {
      count++;
    }
  }

  void decrease() {
    if (count > -2 ) {
      count--;
    }
  }
}