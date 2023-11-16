import 'package:flutter/material.dart';
import 'package:mini_project/data/api/api_service.dart';
import 'package:mini_project/data/model/meal.dart';
import 'package:mini_project/widget/card_meals.dart';

import 'collections_list_page.dart';

class MealsListPage extends StatefulWidget {
  @override
  State<MealsListPage> createState() => _MealsListPageState();
}

class _MealsListPageState extends State<MealsListPage> {
  late Future<Meal?> _meal;
  final List<MealElement> myCollections = [];

  @override
  void initState() {
    super.initState();
    _meal = ApiService().getMeals();
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: _meal,
      builder: (context, AsyncSnapshot<Meal?> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: snapshot.data?.meals.length,
                itemBuilder: (context, index) {
                  var meals = snapshot.data?.meals[index];
                  return CardMeal(
                    meal: meals!,
                    myCollections: myCollections,
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            return const Text('');
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.restaurant_menu),
          title: const Text('Recipe Meals',),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Save for later',
              ),
              Tab(
                text: 'My Collections',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(context),
            MyCollections(myCollections: myCollections),
          ],
        ),
        //body: _buildList(context),
      ),
    );
  }
}
