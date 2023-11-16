import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_project/data/model/meal.dart';
import 'package:mini_project/data/model/meal_detail.dart';
import 'package:mini_project/data/api/api_service.dart';
import 'package:mini_project/data/webview_arguments.dart';
import 'package:mini_project/ui/web_view.dart';
import 'package:mini_project/data/detail_arguments.dart';

class MealsDetailPage extends StatefulWidget {
  static const routeName = '/meal_detail';

  final ArgumentsDetail components;
  const MealsDetailPage(this.components);

  @override
  State<MealsDetailPage> createState() => _MealsDetailPageState();
}

class _MealsDetailPageState extends State<MealsDetailPage> {
  late Future<MealDetail?> _mealDetail;

  late final MealElement meal = widget.components.meals;
  late final List<MealElement> myCollections = widget.components.myCollections;

  @override
  void initState() {
    super.initState();
    _mealDetail = ApiService().getMealsDetail(meal.idMeal);
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: _mealDetail,
      builder: (context, AsyncSnapshot<MealDetail?> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            return view(context, snapshot.data!.meals[0]);
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

  Widget view(BuildContext context, MealDetailElement meals) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(meals.strMealThumb),
            ),
            buttonArrow(context),
            content(meals),
          ],
        ),
      ),
    );
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  content(MealDetailElement meals) {
    return DraggableScrollableSheet(
      initialChildSize: 0.58,
      maxChildSize: 1.0,
      minChildSize: 0.58,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 6,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meals.strMeal,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.teal.shade400,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                meals.strArea!,
                                style: TextStyle(
                                  color: Colors.teal.shade400,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (meal.toggle == false) {
                            myCollections.add(meal);
                            meal.toggle = true;
                            Fluttertoast.showToast(
                              msg: 'Success Add to My Collections',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.green.shade300,
                              textColor: Colors.white70,
                              fontSize: 15,
                            );
                          } else {
                            myCollections.remove(meal);
                            meal.toggle = false;
                            Fluttertoast.showToast(
                              msg: 'Success Remove from My Collections',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.lime.shade700,
                              textColor: Colors.white,
                              fontSize: 15,
                            );
                          }
                        });
                      },
                      icon: meal.toggle!
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                              size: 30,
                            ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Divider(
                    height: 3,
                    color: Colors.teal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal.shade200,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        meals.strCategory!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Instruction",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text(
                  meals.strInstructions!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            WebView.routeName,
                            arguments: ArgumentsWebView(
                                meals.strYoutube!, 'Youtube View'),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                        ),
                        child: const Text(
                          'View Video',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            WebView.routeName,
                            arguments:
                                ArgumentsWebView(meals.strSource!, 'Web View'),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                        ),
                        child: const Text(
                          'Read More',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(context),
    );
  }
}
