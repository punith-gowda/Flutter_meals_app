import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/favorites.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;
  TabsScreen(this._favoriteMeals);
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  buildTabs() {
    return _pages.map((page) {
      return BottomNavigationBarItem(
        label: page['title'],
        icon: Icon(page['icon']),
      );
    }).toList();
  }

  @override
  void initState() {
    _pages = [
      {'page': CategoryScreen(), 'title': 'Categories', 'icon': Icons.home},
      {
        'page': FavoriteScreen(widget._favoriteMeals),
        'title': 'Favorites',
        'icon': Icons.star
      },
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        items: buildTabs(),
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _selectPage(index);
        },
      ),
    );
  }
}
