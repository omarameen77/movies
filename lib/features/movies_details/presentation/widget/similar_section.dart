import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/theme/app_text_theme.dart';
import 'package:movies/features/movies_details/business_logic/similar_movies_cubit/similar_movies_cubit.dart';
import 'package:movies/features/movies_details/presentation/screen/movies_details_screen.dart';
import 'package:movies/features/movies_details/presentation/widget/cast_section.dart';
import 'package:movies/features/movies_details/presentation/widget/genres_section.dart';

class SimilarMoviesSection extends StatelessWidget {
  const SimilarMoviesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarMoviesCubit, SimilarMoviesState>(
      builder: (context, state) {
        if (state is SimilarMoviesLoaded) {
          final similar = state.similarMovies;
          final summary = similar.first.summary ?? "Not found";
          final listGenres = similar.first.genres;
          if (similar.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("No similar movies found"),
              ),
            );
          }

          return Padding(
            padding: EdgeInsetsGeometry.only(right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Similar", style: TextStyleHelper.font18WhiteBold),
                SizedBox(height: context.height * 0.01),

                GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: similar.length,
                  itemBuilder: (context, index) {
                    final movie = similar[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(
                              milliseconds: 400,
                            ),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    MoviesDetailsScreen(movieId: movie.id!),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              movie.mediumCoverImage ?? "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stack) =>
                                  const Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: context.height * 0.01),
                Text("Summary", style: TextStyleHelper.font18WhiteBold),
                SizedBox(height: context.height * 0.01),
                Text(
                  summary,
                  style: TextStyleHelper.font14GreyRegular,
                  maxLines: 20,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.height * 0.01),
                CastSection(),
                SizedBox(height: context.height * 0.01),
                GenresSection(genres: listGenres),
              ],
            ),
          );
        } else if (state is SimilarMoviesError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('Error: ${state.message}'),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
