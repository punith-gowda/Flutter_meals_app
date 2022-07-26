import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters.dart';

class MainDrawer extends StatelessWidget {
  Widget buildSideDrawerTiles(
      BuildContext context, IconData icon, String text, String path) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(path);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          height: 120,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).primaryColor,
          child: Text(
            'Cooking Up!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        buildSideDrawerTiles(context, Icons.restaurant, 'Meals', '/'),
        buildSideDrawerTiles(context, Icons.settings, 'Filters', FilterScreen.routeName),
      ]),
    );
  }
}
