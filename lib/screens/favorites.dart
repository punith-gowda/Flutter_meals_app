import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoriteScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    return favoriteMeals.isNotEmpty
        ? ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(favoriteMeals[index]);
            },
            itemCount: favoriteMeals.length)
        : const Center(
            child: Text('No meals found'),
          );
  }
}
