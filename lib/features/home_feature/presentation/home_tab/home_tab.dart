import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/home_feature/data/reposatory/reposatory.dart';
import 'package:movies/features/home_feature/data/web_service/movies_web_service.dart';
import 'package:movies/features/home_feature/presentation/home_tab/widget/available_now_section.dart';
import 'package:movies/features/home_feature/presentation/home_tab/widget/genre_movies_section.dart';


import '../../business_logic/cubit/movies_cubit.dart';


class HomeTabs extends StatefulWidget {
    final Function(String genre)? onSeeMore;
  const HomeTabs({super.key, this.onSeeMore});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  final List<String> _allGenres = [
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


  late List<String> _selectedGenres;

  @override
  void initState() {
    super.initState();
    _selectRandomGenres();
  }


  void _selectRandomGenres() {
    final shuffled = List<String>.from(_allGenres)..shuffle();
    _selectedGenres = shuffled.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          MoviesCubit(MoviesRepository(moviesWebService: MoviesWebService()))
            ..getMoviesList(),
      child: Scaffold(
        body: BlocBuilder<MoviesCubit, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoaded) {
              final movies = state.moviesList;
              final cubit = context.read<MoviesCubit>();
        
              return RefreshIndicator(
                color: AppColors.gold,
                onRefresh: () async {
                  await cubit.getMoviesList();
        
                  setState(() {
                    _selectRandomGenres();
                  });
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // Available Now Section
                      AvailableNowSection(movies: movies),
                      const SizedBox(height: 8),
                      ...List.generate(
                        _selectedGenres.length,
                        (index) => GenreMoviesSection(
                          key: ValueKey(_selectedGenres[index]),
                          title: _selectedGenres[index],
                          moviesFuture: cubit.getMoviesByGenre(
                            _selectedGenres[index].toLowerCase(),
                          ),
                           onSeeMorePressed: () {
                                 widget.onSeeMore?.call(_selectedGenres[index]);
                              },
                        ),
                      ),
        
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            } else if (state is MoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              );
            } else if (state is MoviesError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
