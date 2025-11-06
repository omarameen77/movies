
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../business_logic/cubit/movies_cubit.dart';
import '../../../data/model_home/home_model.dart';
import 'movie_card_widget.dart';

class GenreMoviesGrid extends StatelessWidget {
  final String genre;

  const GenreMoviesGrid({required this.genre});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MoviesCubit>();

    return FutureBuilder<List<MoviesDetails>>(
      future: cubit.getMoviesByGenre(genre.toLowerCase()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.gold),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading $genre movies',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    (context as Element).markNeedsBuild();
                  },
                  child: const Text(
                    'Retry',
                    style: TextStyle(color: AppColors.gold),
                  ),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.movie_filter_outlined,
                  color: Colors.grey,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'No $genre movies found',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        final movies = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCard(movie: movie);
            },
          ),
        );
      },
    );
  }
}
