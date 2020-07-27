import 'package:flutter/material.dart';

class RecipeBundle {
  final int id, items, recipes;
  final String title, description, imageSrc;
  final Color color;

  RecipeBundle(
      {this.id,
      this.items,
      this.recipes,
      this.title,
      this.description,
      this.imageSrc,
      this.color});
}

// Demo list
List<RecipeBundle> recipeBundles = [
  RecipeBundle(
    id: 1,
    items: 3,
    title: "all star Everyday",
    description: " every minute",
    imageSrc: "assets/images/shoe.png",
    color: Color(0xFFD82D40),
  ),
  RecipeBundle(
    id: 2,
    items: 8,
    title: "Best of 2020",
    description: "for special occasions",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Color(0xFF90AF17),
  ),
  RecipeBundle(
    id: 3,
    items: 10,
    title: "Food Court",
    description: "What's your favorite food dish make it now",
    imageSrc: "assets/images/food_court@2x.png",
    color: Color(0xFF2DBBD8),
  ),
];
