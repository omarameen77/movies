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

  final List<Map<String, String>> pages = [
    {
      "image": "assets/images/Movies Posters Group.png",
      "title": "Find Your Next Favorite Movie Here",
      "description": "Get access to a huge library of movies to suit all tastes. You will surely like it.",
    },
    {
      "image": "assets/images/TheGodfather1.png",
      "title": "Discover Movies",
      "description": "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    },
    {
      "image": "assets/images/1917.png",
      "title": "Stream Anywhere",
      "description": "Watch your favorite movies anywhere, anytime, with high quality.",
    },
    {
      "image": "assets/images/xl_9419884_887ed6c7 1.png",
      "title": "Enjoy the Experience",
      "description": "Create your watchlist and enjoy a world of entertainment.",
    },
  ];

  void nextPage() {
    if (currentIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final page = pages[index];
              return Stack(
                children: [
                  // الخلفية
                  Positioned.fill(
                    child: Image.asset(
                      page["image"]!,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // التدرّج
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.85),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // المحتوى السفلي
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            page["title"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            page["description"]!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // مؤشر الصفحات
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              pages.length,
                              (i) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                height: 8,
                                width: currentIndex == i ? 20 : 8,
                                decoration: BoxDecoration(
                                  color: currentIndex == i
                                      ? AppColors.gold
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // زرّ "Next" أو "Get Started"
                          FilledButton(
                            onPressed: nextPage,
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.gold,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              currentIndex == pages.length - 1
                                  ? "Get Started"
                                  : "Next",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
