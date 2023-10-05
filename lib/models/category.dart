import 'package:flutter/material.dart';

class Category {
  String thumbnail;
  String name;
  int noOfCourses;

  Category({
    required this.name,
    required this.noOfCourses,
    required this.thumbnail,
  });
}

List<Category> categoryList = [
  Category(
    name: 'COMPUTER ENGG',
    noOfCourses: 55,
    thumbnail: 'assets/icons/laptop.jpg',
  ),
  Category(
    name: 'ELECTRONICS',
    noOfCourses: 20,
    thumbnail: 'assets/icons/accounting.jpg',
  ),
  Category(
    name: 'ELECTRICAL',
    noOfCourses: 16,
    thumbnail: 'assets/icons/photography.jpg',
  ),
  Category(
    name: 'CIVIL',
    noOfCourses: 25,
    thumbnail: 'assets/icons/design.jpg',
  ),
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Category List',
      home: CategoryListScreen(),
    );
  }
}

class CategoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category List'),
      ),
      body: AnimatedCategoryList(),
    );
  }
}

class AnimatedCategoryList extends StatefulWidget {
  @override
  _AnimatedCategoryListState createState() => _AnimatedCategoryListState();
}

class _AnimatedCategoryListState extends State<AnimatedCategoryList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Category> animatedCategoryList = [];

  @override
  void initState() {
    super.initState();
    animatedCategoryList.addAll(categoryList);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: animatedCategoryList.length,
      itemBuilder: (context, index, animation) {
        return buildCategoryItem(animatedCategoryList[index], animation, index);
      },
    );
  }

  Widget buildCategoryItem(Category category, Animation<double> animation, int index) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: Card(
        child: InkWell(
          onTap: () {
            // Handle category item tap.
            print('Tapped on ${category.name}');
          },
          child: ListTile(
            leading: Image.asset(
              category.thumbnail,
              width: 48,
              height: 48,
            ),
            title: Text(category.name),
            subtitle: Text('No. of Courses: ${category.noOfCourses}'),
          ),
        ),
      ),
    );
  }
}
