import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/category_meals.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/screens/not_found.dart';
import 'package:meals_app/screens/tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS
          .where((element) => _filterMeal(element, _filters))
          .toList();
    });
  }

  bool _filterMeal(Meal meal, Map<String, bool> filterData) {
    if (filterData['gluten'] && !meal.isGlutenFree) {
      return false;
    }
    if (filterData['lactose'] && !meal.isLactoseFree) {
      return false;
    }
    if (filterData['vegan'] && !meal.isVegan) {
      return false;
    }
    if (filterData['vegetarian'] && !meal.isVegetarian) {
      return false;
    }
    return true;
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              headline6: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
      ),
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailsScreen.routeName: (ctx) =>
            MealDetailsScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (ctx) => NotFoundScreen(),
      ),
    );
  }
}
