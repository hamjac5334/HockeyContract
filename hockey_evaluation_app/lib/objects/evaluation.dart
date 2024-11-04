class Evaluation {
  String name;
  DateTime evaluationDate;
  String evaluationType;
  bool completed = false;

  Evaluation({
    required this.name,
    required this.evaluationDate,
    required this.evaluationType,
  });

  void set_completed() {
    completed = true;
  }
}
