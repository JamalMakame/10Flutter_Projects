import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/models/explore_recipe.dart';

import 'author_card.dart';

class Card2 extends StatelessWidget {
  const Card2({Key? key, required ExploreRecipe recipe}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/magazine_pics/mag2.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          children: [
            // TODO 1: add author information
            const AuthorCard(
              authorName: 'Mike Katz',
              title: 'Smoothie Connoisseur',
              imageProvider: AssetImage('assets/profile_pics/person_katz.jpeg'),
            ),
            // TODO 4: add Positioned text
            // 1
            Expanded(
              // 2
              child: Stack(
                children: [
                  // 3
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Text(
                      'Recipe',
                      style: FooderlichTheme.lightTextTheme.headline1,
                    ),
                  ),
                  // 4
                  Positioned(
                    bottom: 70,
                    left: 16,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'Smoothies',
                        style: FooderlichTheme.lightTextTheme.headline1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
