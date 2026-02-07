import 'dart:io';

class ProductModel {
  final int id;
  final String image;
  final String title;

  final String description;
  final int price;
  final double rating;
  final int reviewCount;

  ProductModel({
    required this.id,
    required this.image,
    required this.title,

    required this.description,
    required this.price,
    required this.rating,
    required this.reviewCount,
  });
}
