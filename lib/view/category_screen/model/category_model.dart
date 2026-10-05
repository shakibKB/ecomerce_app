class CategoryModel {
  final String id;
  final String title;
  final String subtitle;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  static const List<CategoryModel> defaultCategories = [
    CategoryModel(id: "all", title: "All", subtitle: "All items"),
    CategoryModel(id: "sneakers", title: "Sneakers", subtitle: "Street style"),
    CategoryModel(id: "running", title: "Running", subtitle: "Performance"),
    CategoryModel(id: "basketball", title: "Basketball", subtitle: "Hardwood"),
    CategoryModel(id: "casual", title: "Casual", subtitle: "Everyday"),
  ];
}
