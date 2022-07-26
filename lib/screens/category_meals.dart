import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  List<Meal> availableMeals;
  String categoryTitle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'];
    categoryTitle = routeArgs['title'];
    availableMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: availableMeals.isNotEmpty
          ? ListView.builder(
              itemBuilder: (ctx, index) {
                return MealItem(availableMeals[index]);
              },
              itemCount: availableMeals.length)
          : const Center(
              child: Text('No meals found'),
            ),
    );
  }
}
