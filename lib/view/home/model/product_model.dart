import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utility/assets.dart';

class ProductModel {
  final String id;
  final String name;
  final String brand;
  final double price;
  final double? oldPrice;
  final double rating;
  final int reviewCount;
  final String image;
  final String category;
  final String description;
  final List<String> sizes;
  final List<Color> colors;
  final RxBool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.reviewCount,
    required this.image,
    required this.category,
    required this.description,
    this.sizes = const ["US 7", "US 8", "US 9", "US 10", "US 11"],
    this.colors = const [
      Colors.white,
      Colors.black,
      Color(0xFF8B5A3C),
      Color(0xFFFF6A00),
    ],
    bool favorite = false,
  }) : isFavorite = favorite.obs;

  static List<ProductModel> sampleProducts = [
    ProductModel(
      id: "1",
      name: "Nike Court Vision Low",
      brand: "Nike",
      price: 135.0,
      oldPrice: 175.0,
      rating: 4.8,
      reviewCount: 248,
      image: Assets.nike,
      category: "Sneakers",
      description:
          "In love with the classic look of '80s basketball, but have a thing for the fast-paced culture of today's game? Meet the Nike Court Vision Low. Its crisp upper and stitched overlays are inspired by the hook shot of old-school basketball.",
      favorite: true,
    ),
    ProductModel(
      id: "2",
      name: "Nike Air Max Pulse",
      brand: "Nike",
      price: 150.0,
      oldPrice: 190.0,
      rating: 4.9,
      reviewCount: 312,
      image: Assets.nike,
      category: "Running",
      description:
          "The Air Max Pulse pulls inspiration from the London music scene, bringing an underground touch to the iconic Air Max line. Point-loaded Air cushioning offers better bounce.",
      favorite: false,
    ),
    ProductModel(
      id: "3",
      name: "Air Jordan 1 Low OG",
      brand: "Jordan",
      price: 140.0,
      oldPrice: 160.0,
      rating: 4.7,
      reviewCount: 185,
      image: Assets.nike,
      category: "Basketball",
      description:
          "The Air Jordan 1 Low OG remixes the classic sneaker with fresh colors and textures. Premium materials and accents give modern expression to an all-time favorite.",
      favorite: true,
    ),
    ProductModel(
      id: "4",
      name: "Nike Dunk Low Retro",
      brand: "Nike",
      price: 115.0,
      oldPrice: 130.0,
      rating: 4.9,
      reviewCount: 520,
      image: Assets.nike,
      category: "Sneakers",
      description:
          "Created for the hardwood but taken to the streets, the '80s b-ball icon returns with perfectly shined overlays and original team colors.",
      favorite: false,
    ),
    ProductModel(
      id: "5",
      name: "Nike Pegasus 40",
      brand: "Nike",
      price: 130.0,
      oldPrice: 155.0,
      rating: 4.6,
      reviewCount: 96,
      image: Assets.nike,
      category: "Running",
      description:
          "A springy ride for any run, the Peg's familiar, just-for-you feel returns to help you accomplish your goals. This milestone edition has improved responsiveness and neutral support.",
      favorite: false,
    ),
    ProductModel(
      id: "6",
      name: "Nike Blazer Mid '77",
      brand: "Nike",
      price: 105.0,
      oldPrice: 125.0,
      rating: 4.8,
      reviewCount: 420,
      image: Assets.nike,
      category: "Casual",
      description:
          "Styled for the '70s. Loved in the '80s. Classic in the '90s. Ready for the future. The Nike Blazer Mid '77 Vintage delivers a timeless design that's easy to wear.",
      favorite: true,
    ),
  ];
}
