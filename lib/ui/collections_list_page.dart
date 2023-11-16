import 'package:flutter/material.dart';
import 'package:mini_project/data/model/meal.dart';
import 'package:mini_project/widget/card_meals.dart';

class MyCollections extends StatelessWidget {
  final List<MealElement> myCollections;
  const MyCollections({
    Key? key,
    required this.myCollections,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemCount: myCollections.length,
      itemBuilder: (context, index) {
        var meals = myCollections[index];
        return CardMeal(
          meal: meals,
          myCollections: myCollections,
        );
      },
    );
  }
}
