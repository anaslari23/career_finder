import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_page/chatbot.dart';
import 'package:login_page/intern_screen.dart';
import 'package:login_page/jobportalapp.dart';
import 'package:login_page/profile_screen.dart';
import 'package:login_page/TrendingCoursesScreen.dart';
import 'package:login_page/ResumeBuilderScreen.dart';
import 'package:login_page/BookFinderScreen.dart';
import 'package:login_page/courseListingScreen.dart';
import 'package:login_page/NewsScreen.dart';

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

  void updateSearchText(String text) {
    setState(() {
      searchText = text;
    });
  }

  void openResumeBuilder(BuildContext context) {
    // Navigate to the Resume Builder screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResumeBuilderScreen(),
      ),
    );
  }

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              searchText: searchText,
              onSearchTextChanged: updateSearchText,
            ),
            Body(searchText: searchText),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Call the function to open the Resume Builder
            openResumeBuilder(context);
          },
          child: Icon(Icons.description),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

class CustomAppBar extends StatelessWidget {
  final String searchText;
  final Function(String) onSearchTextChanged;
  final TextEditingController _searchController = TextEditingController();

  CustomAppBar({required this.searchText, required this.onSearchTextChanged}) {
    _searchController.text = searchText;
  }

  static const Color appBarColor1 = Color(0xFFB2DFDB);
  static const Color appBarColor2 = Color(0xFF80CBC4);

  String _getGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening ';
    }
  }

  @override
  Widget build(BuildContext context) {
    final greeting = _getGreeting();

    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5],
          colors: [
            appBarColor1,
            appBarColor2,
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
                  // Navigate to the Profile Screen
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
                greeting,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // Two Circle-type Icons for Book Finder and Course Listing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleIconButton(
                icon: Icons.search,
                label: 'Book Finder',
                onPressed: () {
                  // Handle the click for book finder
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookFinderScreen(),
                    ),

                  );
                },
              ),
              CircleIconButton(
                icon: Icons.view_list,
                label: 'Course Listing',
                onPressed: () {
                  // Handle the click for course listing
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseListingScreen(qualificationId: 0),
                    ),
                  );
                },
              ),              CircleIconButton(
                icon: Icons.article,
                label: 'Tasks',
                onPressed: () {
                  // Handle the click for news
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsScreen(),
                    ),
                  );
                },
              ),



            ],
          ),
        ],
      ),
    );
  }
}
class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CircleIconButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 17, 17, 17), // Choose your desired color
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
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
      return 'Ongoing Internships';
    } else if (category.name == 'Category 3') {
      return 'Chatbot';
    } else if (category.name == 'Category 4') {
      return 'Recruitments';
    } else {
      return 'Others';
    }
  }

  void navigateToScreen(BuildContext context) {
    if (category.name == 'Category 1') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrendingCourseSearchPage(),
        ),
      );
    } else if (category.name == 'Category 2') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InternshipSearchPage(),
        ),
      );
    } else if (category.name == 'Category 3') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Chatbot(),
        ),
      );
    } else if (category.name == 'Category 4') {
      Navigator.push
        (
        context,
        MaterialPageRoute(
          builder: (context) => JobPortalApp(),
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
          color: Color.fromARGB(255, 144, 233, 233),
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
          ],
        ),
      ),
    );
  }
}


class Category {
  final String name;
  final String thumbnail;

  Category({
    required this.name,
    required this.thumbnail,
  });
}

final categoryList = <Category>[
  Category(name: 'Category 1', thumbnail: 'assets/images/guidance.png'),
  Category(name: 'Category 2', thumbnail: 'assets/images/graduates.png'),
  Category(name: 'Category 3', thumbnail: 'assets/images/chatbot.png'),
  Category(name: 'Category 4', thumbnail: 'assets/images/other.png'),
];
const double kCategoryCardImageSize = 100.0;