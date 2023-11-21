import 'package:flutter/material.dart';

class DashboardCategoriesModel{
  final String name;
  final String?subtitle;
  final String assetImage;
  final Color colors;
  final Color bgColors;

  DashboardCategoriesModel({required this.name, this.subtitle, required this.assetImage, required this.colors,required this.bgColors,});
}