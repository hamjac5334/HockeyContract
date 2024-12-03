import 'package:hockey_evaluation_app/objects/category_score.dart';
import 'package:hockey_evaluation_app/objects/item_score.dart';
import 'package:hockey_evaluation_app/pages/new_eval.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hockey_evaluation_app/pages/open_evaluation_info_page.dart';

class FullScore {
//I think that this class can be used for goaltender and evaluations
  List<CategoryScore> categoryScoreList = [
    CategoryScore(name: "See", itemScores: [
      ItemScore(name: "Acquisition"),
      ItemScore(name: "Tracking"),
      ItemScore(name: "Focus"),
    ]),
    CategoryScore(name: "Understand", itemScores: [
      ItemScore(name: "Play Reading"),
      ItemScore(name: "Pattern Recognition"),
      ItemScore(name: "Awareness"),
    ]),
    CategoryScore(name: "Drive", itemScores: [
      ItemScore(name: "Compete Level"),
      ItemScore(name: "Motivation"),
      ItemScore(name: "Confidence"),
    ]),
    CategoryScore(name: "Adapt", itemScores: [
      ItemScore(name: "Creativity"),
      ItemScore(name: "Save Selection"),
      ItemScore(name: "Playmaking"),
    ]),
    CategoryScore(name: "Move", itemScores: [
      ItemScore(name: "Energy"),
      ItemScore(name: "Skating"),
      ItemScore(name: "Range"),
      ItemScore(name: "Coordination"),
    ]),
    CategoryScore(name: "Save", itemScores: [
      ItemScore(name: "Positioning"),
      ItemScore(name: "Stance"),
      ItemScore(name: "Rebound Control"),
    ]),
    CategoryScore(name: "Learn", itemScores: [
      ItemScore(name: "Team Orientation"),
      ItemScore(name: "Work Ethic"),
      ItemScore(name: "Maturity"),
    ]),
    CategoryScore(name: "Grow", itemScores: [
      ItemScore(name: "Athletic Habits"),
      ItemScore(name: "Emotional Habits"),
      ItemScore(name: "Practice Habits"),
    ]),
  ];
  CategoryScore getCategoryScore(String desiredName) {
    for (CategoryScore categoryScore in categoryScoreList) {
      if (categoryScore.name == desiredName) {
        return categoryScore;
      }
    }
    print("ERROR: Category not found");
    return CategoryScore(
        name: "Error Category", itemScores: [ItemScore(name: "Error Item")]);
  }

  void dataSaveScoring(goalieName, dateAndTime ) {
    var db = FirebaseFirestore.instance;

    db.collection("Goaltenders").doc(goalieName).collection("Evaluations").doc(dateAndTime).collection("Scoring").doc("Score").set(
      {
        "Acquisition": ItemScore(name: "Acquisition"),
        "Tracking": ItemScore(name: "Tracking"),
        "Focus": ItemScore(name: "Focus"),
        "See" : CategoryScore(name: "See", itemScores: [ ItemScore(name: "Acquisition"), ItemScore(name: "Tracking"), ItemScore(name: "Focus")]),
        "Play Reading": ItemScore(name: "Play Reading"),
        "Pattern Recognition": ItemScore(name: "Pattern Recognition"),
        "Awareness": ItemScore(name: "Awareness"),
        "Understand": CategoryScore(name: "Understand", itemScores: [ItemScore(name: "Play Reading"), ItemScore(name: "Pattern Recognition"), ItemScore(name: "Awareness")]),
        "Compete Level": ItemScore(name: "Compete Level"),
        "Motivation": ItemScore(name: "Motivation"),
        "Confidence": ItemScore(name: "Confidence"),
        "Drive": CategoryScore(name: "Drive", itemScores: [ItemScore(name: "Compete Level"), ItemScore(name: "Motivation"), ItemScore(name: "Confidence")]),
        "Creativity": ItemScore(name: "Creativity"),
        "Save Selection": ItemScore(name: "Save Selection"),
        "Playmaking": ItemScore(name: "Playmaking"),
        "Adapt": CategoryScore(name: "Adapt", itemScores: [ItemScore(name: "Creativity"), ItemScore(name: "Save Selection"),  ItemScore(name: "Playmaking")]),
        "Energy": ItemScore(name: "Energy"),
        "Skating": ItemScore(name: "Skating"),
        "Range": ItemScore(name: "Range"),
        "Coordination": ItemScore(name: "Coordination"),
        "Move": CategoryScore(name: "Move", itemScores: [ItemScore(name: "Energy"), ItemScore(name: "Skating"), ItemScore(name: "Range"), ItemScore(name: "Coordination")]),
        "Positioning": ItemScore(name: "Positioning"),
        "Stance": ItemScore(name: "Stance"),
        "Rebound Control": ItemScore(name: "Rebound Control"),
        "Save": CategoryScore(name: "Save", itemScores: [ItemScore(name: "Positioning"), ItemScore(name: "Stance"), ItemScore(name: "Rebound Control")]),
        "Team Orientation": ItemScore(name: "Team Orientation"),
        "Work Ethic": ItemScore(name: "Work Ethic"),
        "Maturity":ItemScore(name: "Maturity"),
        "Learn": CategoryScore(name: "Learn", itemScores: [ItemScore(name: "Team Orientation"), ItemScore(name: "Work Ethic"), ItemScore(name: "Maturity")]),
        "Athletic Habits": ItemScore(name: "Athletic Habits"),
        "Emotional Habits": ItemScore(name: "Emotional Habits"),
        "Practice Habits": ItemScore(name: "Practice Habits"),
        "Grow": CategoryScore(name: "Grow", itemScores: [ItemScore(name: "Athletic Habits"), ItemScore(name: "Emotional Habits"), ItemScore(name: "Practice Habits")]),
      }
    );
  }
}
