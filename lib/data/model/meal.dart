import 'dart:convert';

Meal mealFromJson(String str) => Meal.fromJson(json.decode(str));

String mealToJson(Meal data) => json.encode(data.toJson());

class Meal {
  Meal({
    required this.meals,
  });

  List<MealElement> meals;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        meals: List<MealElement>.from(
            json["meals"].map((x) => MealElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class MealElement {
  MealElement({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  String strMeal;
  String strMealThumb;
  String idMeal;
  bool? toggle = false;

  factory MealElement.fromJson(Map<String, dynamic> json) => MealElement(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
