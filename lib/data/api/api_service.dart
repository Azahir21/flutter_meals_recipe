import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_project/data/model/meal.dart';
import 'package:mini_project/data/model/meal_detail.dart';

import 'package:mini_project/data/constants.dart';

class ApiService {
  Future<Meal> getMeals() async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.mealEndpoint));
    if (response.statusCode == 200) {
      return Meal.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Meals List');
    }
  }

  Future<MealDetail> getMealsDetail(String id) async {
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.mealDetailEndpoint + id));
    if (response.statusCode == 200) {
      return MealDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Meals Detail');
    }
  }
}
