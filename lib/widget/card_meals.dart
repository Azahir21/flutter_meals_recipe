import 'package:flutter/material.dart';
import 'package:mini_project/data/model/meal.dart';
import 'package:mini_project/data/detail_arguments.dart';

import '../ui/meals_detail_page.dart';

class CardMeal extends StatelessWidget {
  final MealElement meal;
  final List<MealElement> myCollections;

  const CardMeal({required this.meal, required this.myCollections});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            MealsDetailPage.routeName,
            arguments: ArgumentsDetail(meal, myCollections),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.blueGrey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 124,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: Image(
                      height: 180,
                      width: 180,
                      image: NetworkImage(
                        meal.strMealThumb,
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    meal.strMeal,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
 * child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Image.network(
          meal.strMealThumb,
          width: 100,
        ),
        title: Text(
          meal.strMeal,
        ),
        onTap: () => Navigator.pushNamed(
          context,
          MealsDetailPage.routeName,
          arguments: meal,
        ),
      ),
 * */
