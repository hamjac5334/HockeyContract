import 'package:hockey_evaluation_app/objects/goaltender.dart';

class Evaluation {
  Goaltender goaltender;
  DateTime evaluationDate;
  String evaluationType;
  bool completed = false;
  bool highlighted = false;
  String comments = "";
  String evaluator = "";

  Evaluation({
    required this.goaltender,
    required this.evaluationDate,
    required this.evaluationType,
  });

  void set_completed() {
    completed = true;
  }

  void set_highlighted() {
    highlighted = !highlighted;
  }
}
