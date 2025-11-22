import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/auth_feature/auth/login/login_screen.dart';

class ExportApp extends StatefulWidget {
  const ExportApp({super.key});
  static const String routeName = "/Export";

  @override
  State<ExportApp> createState() => _ExportAppState();
}

class _ExportAppState extends State<ExportApp> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<Map<String, dynamic>> pages = [
    {
      "image": "assets/images/Movies Posters Group.png",
      "title": "Find Your Next Favorite Movie Here",
      "description":
          "Get access to a huge library of movies to suit all tastes. You will surely like it.",
      "gradient": [Colors.black.withAlpha(20), Colors.black,]
    },
    {
      "image": "assets/images/hero.png",
      "title": "Discover Movies",
      "description":
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      "gradient": [Colors.lightBlue.withAlpha(20), Colors.blue.withAlpha(180)],
    },
    {
      "image": "assets/images/godfather.png",
      "title": "Explore All Genres",
      "description":
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
      "gradient": [ Color.fromARGB(255, 240, 76, 0).withAlpha(20),Color.fromARGB(255, 240, 76, 0).withAlpha(180)],
    },
    {
      "image": "assets/images/badboy.png",
      "title": "Create Watchlists",
      "description":
          "Save movies to your watchlist to keep track of what you want to watch next.",
      "gradient": [ Colors.purpleAccent.withAlpha(20),Colors.purple.withAlpha(180)],
    },
    {
      "image": "assets/images/red.png",
      "title": "Rate, Review, and Learn",
      "description":
          "Share your thoughts on the movies you've watched and learn from others.",
      "gradient": [Colors.red.withAlpha(20), Colors.red.withAlpha(150)],
    },
    {
      "image": "assets/images/111.png",
      "title": "Start Watching Now",
      "description":
          "Start your cinematic journey now and explore amazing movies.",
      "gradient": [Colors.white.withAlpha(20), Colors.grey.withAlpha(150)],
    },
  ];

  void nextPage() {
    if (currentIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = pages[currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image.asset(
                    pages[index]["image"],
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                  ),

                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: pages[index]["gradient"],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          if (currentIndex == 0)
            Positioned(
              left: 20,
              right: 20,
              bottom: 60,
              child: Column(
                children: [
                  Text(
                    page["title"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    page["description"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: nextPage,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Explore Now",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          /// ALL OTHER PAGES (WITH CONTAINER)
          if (currentIndex != 0)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 30),
                decoration: const BoxDecoration(
                  color: AppColors.blackThree,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      page["title"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      page["description"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 22),

                    /// BUTTONS UNDER EACH OTHER
                    Column(
                      children: [
                        /// NEXT
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: nextPage,
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.gold,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              currentIndex == pages.length - 1
                                  ? "Finish"
                                  : "Next",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// BACK BUTTON
                        if (currentIndex > 1 && currentIndex < pages.length - 1)
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: previousPage,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: AppColors.gold,
                                  width: 2,
                                ),
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                "Back",
                                style: TextStyle(
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
