import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/meal-details';

  final Function toggleFavorite;
  final Function isFavorite;
  MealDetailsScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  Widget buildContainer(BuildContext context, Widget child, double _height) {
    return Container(
        padding: const EdgeInsets.all(10),
        height: _height,
        width: MediaQuery.of(context).size.width,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Meal;
    return Scaffold(
        appBar: AppBar(
          title: Text(routeArgs.title),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                routeArgs.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
                context,
                ListView.builder(
                  itemBuilder: (ctx, index) => Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(routeArgs.ingredients[index]),
                    ),
                  ),
                  itemCount: routeArgs.ingredients.length,
                ),
                double.parse((40 * routeArgs.ingredients.length).toString())),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
                context,
                ListView.builder(
                  itemBuilder: (ctx, index) => ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(routeArgs.steps[index]),
                  ),
                  itemCount: routeArgs.steps.length,
                ),
                double.parse((50 * routeArgs.steps.length + 10).toString())),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => toggleFavorite(routeArgs.id),
          child:
              Icon(isFavorite(routeArgs.id) ? Icons.star : Icons.star_border),
        ));
  }
}
