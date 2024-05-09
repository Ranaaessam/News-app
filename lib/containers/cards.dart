import 'package:flutter/material.dart';
import 'package:news_app/models/categorymodel.dart';
import '../views/categoryView.dart';

class CardsWidget extends StatelessWidget {
  const CardsWidget({Key? key, required this.model}) : super(key: key);

  final categoryModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return CategoryView(category: model.categoryName);
            }));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Center(
          child: Container(
            height: 85,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(model.image),
                fit: BoxFit.fill,
              ),
              color: Colors.blueAccent,
            ),
            child: Center(
              child: Text(
                model.categoryName,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final List<categoryModel> category = const [
  categoryModel(image: 'assets/images/card.jpeg', categoryName: 'Business'),
  categoryModel(image: 'assets/images/medical.jpeg', categoryName: 'Health'),
  categoryModel(image: 'assets/images/tech.jpeg', categoryName: 'Medical'),
  categoryModel(image: 'assets/images/OIP.jpeg', categoryName: 'Sports'),
  categoryModel(image: 'assets/images/medical.jpeg', categoryName: 'Finance'),
  categoryModel(image: 'assets/images/medical.jpeg', categoryName: 'Technical'),
];

class CardsList extends StatelessWidget {
  const CardsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<categoryModel> categoriesWithImages =
    category.where((category) => hasImage(category)).toList();

    return SizedBox(
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesWithImages.length,
        itemBuilder: (context, index) {
          return CardsWidget(model: categoriesWithImages[index]);
        },
      ),
    );
  }

  bool hasImage(categoryModel category) {
    return AssetImage(category.image).assetName.isNotEmpty;
  }
}
