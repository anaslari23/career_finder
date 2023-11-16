import 'package:flutter/material.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Explore Trending Courses",
    image: "assets/images/image1.png",
    desc: "Discover new and trending courses to enhance your skills and stay ahead in your field.",
  ),
  OnboardingContents(
    title: "Job Search Made Easy",
    image: "assets/images/image2.png",
    desc:
        "Find your dream job with ease. Our app provides a comprehensive job search tailored for college students.",
  ),
  OnboardingContents(
    title: "Discover Ongoing Internships",
    image: "assets/images/image3.png",
    desc:
        "Explore and apply for ongoing internship opportunities and kickstart your career.",
  ),
];
