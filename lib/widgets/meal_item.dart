import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  const MealItem(this.meal);

  String get complexityText {
    if (meal.complexity == Complexity.Simple) {
      return 'Simple';
    } else if (meal.complexity == Complexity.Challenging) {
      return 'Challenging';
    } else {
      return 'Hard';
    }
  }

  String get affordabilityText {
    if (meal.affordability == Affordability.Affordable) {
      return 'Affordable';
    } else if (meal.affordability == Affordability.Luxurious) {
      return 'Luxurious';
    } else {
      return 'Pricey';
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetailsScreen.routeName, arguments: meal);
  }

  Widget buildRowWithIcon(MediaQueryData mediaQuery, BuildContext context,
      IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: mediaQuery.size.width > 400 ? 20 : 14,
        ),
        const SizedBox(
          width: 6,
        ),
        FittedBox(
            child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  meal.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20,
                width: mediaQuery.size.width - 20,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black54),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  child: FittedBox(
                    child: Text(
                      meal.title,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(mediaQuery.size.width > 400 ? 20 : 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildRowWithIcon(mediaQuery, context, Icons.schedule,
                      '${meal.duration} min'),
                  buildRowWithIcon(
                      mediaQuery, context, Icons.work_rounded, complexityText),
                  buildRowWithIcon(mediaQuery, context, Icons.attach_money,
                      affordabilityText),
                ]),
          )
        ]),
      ),
    );
  }
}
