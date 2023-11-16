import 'dart:convert';

MealDetail mealDetailFromJson(String str) =>
    MealDetail.fromJson(json.decode(str));

String mealDetailToJson(MealDetail data) => json.encode(data.toJson());

class MealDetail {
  MealDetail({
    required this.meals,
  });

  List<MealDetailElement> meals;

  factory MealDetail.fromJson(Map<String, dynamic> json) => MealDetail(
        meals: List<MealDetailElement>.from(
            json["meals"].map((x) => MealDetailElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class MealDetailElement {
  MealDetailElement({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strTags,
    required this.strYoutube,
    required this.strSource,
  });

  String idMeal;
  String strMeal;
  String? strCategory;
  String? strArea;
  String? strInstructions;
  String strMealThumb;
  String? strTags;
  String? strYoutube;
  String? strSource;
  bool? toggle;

  factory MealDetailElement.fromJson(Map<String, dynamic> json) =>
      MealDetailElement(
        idMeal: json["idMeal"],
        strMeal: json["strMeal"],
        strCategory: json["strCategory"],
        strArea: json["strArea"],
        strInstructions: json["strInstructions"],
        strMealThumb: json["strMealThumb"],
        strTags: json["strTags"],
        strYoutube: json["strYoutube"],
        strSource: json["strSource"],
      );

  Map<String, dynamic> toJson() => {
        "idMeal": idMeal,
        "strMeal": strMeal,
        "strCategory": strCategory,
        "strArea": strArea,
        "strInstructions": strInstructions,
        "strMealThumb": strMealThumb,
        "strTags": strTags,
        "strYoutube": strYoutube,
        "strSource": strSource,
      };
}
