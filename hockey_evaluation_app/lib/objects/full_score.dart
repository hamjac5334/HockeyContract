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

  List<ItemScore> itemScoreList = [
      ItemScore(name: "Acquisition"),
      ItemScore(name: "Tracking"),
      ItemScore(name: "Focus"),
      ItemScore(name: "Play Reading"),
      ItemScore(name: "Pattern Recognition"),
      ItemScore(name: "Awareness"),
      ItemScore(name: "Compete Level"),
      ItemScore(name: "Motivation"),
      ItemScore(name: "Confidence"),
      ItemScore(name: "Creativity"),
      ItemScore(name: "Save Selection"),
      ItemScore(name: "Playmaking"),
      ItemScore(name: "Energy"),
      ItemScore(name: "Skating"),
      ItemScore(name: "Range"),
      ItemScore(name: "Coordination"),
      ItemScore(name: "Positioning"),
      ItemScore(name: "Stance"),
      ItemScore(name: "Rebound Control"),
      ItemScore(name: "Team Orientation"),
      ItemScore(name: "Work Ethic"),
      ItemScore(name: "Maturity"),
      ItemScore(name: "Athletic Habits"),
      ItemScore(name: "Emotional Habits"),
      ItemScore(name: "Practice Habits"),
    ];

  /*void dataSaveScoring(goalieName, dateAndTime ) {
    var db = FirebaseFirestore.instance;

    db.collection("Goaltenders").doc(goalieName).collection("Evaluations").doc(dateAndTime.toString().substring(0,19)).collection("Scoring").doc("Score").set(
      {
        "Acquisition": ItemScore(name: "Acquisition").count,
        "Tracking": ItemScore(name: "Tracking").count,
        "Focus": ItemScore(name: "Focus").count,
        "See" : CategoryScore(name: "See", itemScores: [ ItemScore(name: "Acquisition"), ItemScore(name: "Tracking"), ItemScore(name: "Focus")]).getAverage(),
        "Play Reading": ItemScore(name: "Play Reading").count,
        "Pattern Recognition": ItemScore(name: "Pattern Recognition").count,
        "Awareness": ItemScore(name: "Awareness").count,
        "Understand": CategoryScore(name: "Understand", itemScores: [ItemScore(name: "Play Reading"), ItemScore(name: "Pattern Recognition"), ItemScore(name: "Awareness")]).getAverage(),
        "Compete Level": ItemScore(name: "Compete Level").count,
        "Motivation": ItemScore(name: "Motivation").count,
        "Confidence": ItemScore(name: "Confidence").count,
        "Drive": CategoryScore(name: "Drive", itemScores: [ItemScore(name: "Compete Level"), ItemScore(name: "Motivation"), ItemScore(name: "Confidence")]).getAverage(),
        "Creativity": ItemScore(name: "Creativity").count,
        "Save Selection": ItemScore(name: "Save Selection").count,
        "Playmaking": ItemScore(name: "Playmaking").count,
        "Adapt": CategoryScore(name: "Adapt", itemScores: [ItemScore(name: "Creativity"), ItemScore(name: "Save Selection"),  ItemScore(name: "Playmaking")]).getAverage(),
        "Energy": ItemScore(name: "Energy").count,
        "Skating": ItemScore(name: "Skating").count,
        "Range": ItemScore(name: "Range").count,
        "Coordination": ItemScore(name: "Coordination").count,
        "Move": CategoryScore(name: "Move", itemScores: [ItemScore(name: "Energy"), ItemScore(name: "Skating"), ItemScore(name: "Range"), ItemScore(name: "Coordination")]).getAverage(),
        "Positioning": ItemScore(name: "Positioning").count,
        "Stance": ItemScore(name: "Stance").count,
        "Rebound Control": ItemScore(name: "Rebound Control").count,
        "Save": CategoryScore(name: "Save", itemScores: [ItemScore(name: "Positioning"), ItemScore(name: "Stance"), ItemScore(name: "Rebound Control")]).getAverage(),
        "Team Orientation": ItemScore(name: "Team Orientation").count,
        "Work Ethic": ItemScore(name: "Work Ethic").count,
        "Maturity":ItemScore(name: "Maturity").count,
        "Learn": CategoryScore(name: "Learn", itemScores: [ItemScore(name: "Team Orientation"), ItemScore(name: "Work Ethic"), ItemScore(name: "Maturity")]).getAverage(),
        "Athletic Habits": ItemScore(name: "Athletic Habits").count,
        "Emotional Habits": ItemScore(name: "Emotional Habits").count,
        "Practice Habits": ItemScore(name: "Practice Habits").count,
        "Grow": CategoryScore(name: "Grow", itemScores: [ItemScore(name: "Athletic Habits"), ItemScore(name: "Emotional Habits"), ItemScore(name: "Practice Habits")]).getAverage(),
      }
    );
  }*/
}
