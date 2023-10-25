import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_page/profile_screen.dart';
import 'package:login_page/feedback_screen.dart';
import 'package:login_page/intern_screen.dart';
import 'package:login_page/chatbot.dart';

void main() {
  runApp(
    MaterialApp(
      home: FeaturedScreen(),
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
          bodySmall: TextStyle(fontSize: 14),

          headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(searchText: searchText),
            Body(searchText: searchText),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  final String searchText;
  Body({required this.searchText});

  List<Category> getFilteredCategories(List<Category> categories) {
    if (searchText.isEmpty) {
      return categories;
    } else {
      return categories
          .where((category) =>
              category.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredCategories = getFilteredCategories(categoryList);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Explore Categories",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "See All",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.blue),
                ),
              )
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 20,
            mainAxisSpacing: 24,
          ),
          itemBuilder: (context, index) {
            return CategoryCard(
              category: filteredCategories[index],
            );
          },
          itemCount: filteredCategories.length,
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  CategoryCard({Key? key, required this.category}) : super(key: key);

  String getCategoryHeading() {
    if (category.name == 'Category 1') {
      return 'Guider';
    } else if (category.name == 'Category 2') {
      return 'Ongo Internships';
    } else if (category.name == 'Category 3') {
      return 'Chatbot';
    } else if (category.name == 'Category 4') {
      return 'Feedback';
    } else {
      return 'Others';
    }
  }

  void navigateToScreen(BuildContext context) {
    if (category.name == 'Category 1') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GuiderScreen(),
        ),
      );
    } else if (category.name == 'Category 2') {

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => InternScreen(), // Replace with the content you want to display on InternScreen
  ),
);





    } else if (category.name == 'Category 3') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>Chatbot(),
        ),
      );
    } else if (category.name == 'Category 4') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FeedbackScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToScreen(context);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                category.thumbnail,
                height: kCategoryCardImageSize,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              getCategoryHeading(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${category.noOfCourses.toString()} courses",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final String searchText;

  CustomAppBar({required this.searchText});

  String _getGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final greeting = _getGreeting();

    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5],
          colors: [
            Color.fromARGB(255, 247, 29, 14),
            Color.fromARGB(255, 214, 16, 16),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/fff.png'),
                  radius: 30,
                ),
              ),
              Text(
                '$greeting,',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class Category {
  final String name;
  final String thumbnail;
  final int noOfCourses;

  Category({
    required this.name,
    required this.thumbnail,
    required this.noOfCourses,
  });
}

final categoryList = <Category>[
  Category(name: 'Category 1', thumbnail: 'assets/images/guidance.png', noOfCourses: 8),
  Category(name: 'Category 2', thumbnail: 'assets/images/graduates.png', noOfCourses: 12),
  Category(name: 'Category 3', thumbnail: 'assets/images/chatbot.png', noOfCourses: 6),
  Category(name: 'Category 4', thumbnail: 'assets/images/other.png', noOfCourses: 10),
];
const double kCategoryCardImageSize = 100.0;

class GuiderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guider Screen'),
      ),
      body: Center(
        child: Text('This is the Guider Screen'),
      ),
    );
  }
}





