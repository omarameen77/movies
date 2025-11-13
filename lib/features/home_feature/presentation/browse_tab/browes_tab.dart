import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/features/home_feature/presentation/browse_tab/widget/genre_movise_grid.dart';

import '../../../../core/theme/app_colors.dart';
import '../../business_logic/cubit/movies_cubit.dart';
import '../../data/reposatory/reposatory.dart';
import '../../data/web_service/movies_web_service.dart';


class BrowseTab extends StatefulWidget {
  final String? selectedGenre;

  const BrowseTab({super.key, this.selectedGenre});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _genres = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'Horror',
    'Music',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Sport',
    'Thriller',
    'War',
    'Western',
  ];

  @override
  void initState() {
    super.initState();

    int initialIndex = 0;
    if (widget.selectedGenre != null) {
      final index = _genres.indexWhere(
            (g) => g.toLowerCase() == widget.selectedGenre!.toLowerCase(),
      );
      if (index != -1) {
        initialIndex = index;
      }
    }

    _tabController = TabController(
      length: _genres.length,
      vsync: this,
      initialIndex: initialIndex,
    );
  }


  @override
  void didUpdateWidget(BrowseTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.selectedGenre != null &&
        widget.selectedGenre != oldWidget.selectedGenre) {
      final newIndex = _genres.indexWhere(
        (g) => g.toLowerCase() == widget.selectedGenre!.toLowerCase(),
      );
      if (newIndex != -1 && newIndex != _tabController.index) {
        _tabController.animateTo(newIndex);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          MoviesCubit(MoviesRepository(moviesWebService: MoviesWebService())),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TabBar (Genres)
              SizedBox(
                height: context.height * 0.06,
                child: TabBar(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  controller: _tabController,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.black,
                  unselectedLabelColor: AppColors.gold,
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                  tabs: _genres.asMap().entries.map((entry) {
                    final index = entry.key;
                    final genre = entry.value;
                    return Tab(
                      child: AnimatedBuilder(
                        animation: _tabController,
                        builder: (context, child) {
                          final isSelected = _tabController.index == index;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.gold
                                  : Colors.transparent,
                              border: Border.all(
                                color: AppColors.gold,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                genre,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.black
                                      : AppColors.gold,
                                  fontSize: 16,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 16),

              // TabBarView (Movies Grid)
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _genres.map((genre) {
                    return GenreMoviesGrid(genre: genre);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}