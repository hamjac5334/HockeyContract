import 'package:hockey_evaluation_app/objects/category_score.dart';
import 'package:hockey_evaluation_app/objects/item_score.dart';

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
}
