import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/home_feature/business_logic/cubit/movies_cubit.dart';


class SliderMovie extends StatelessWidget {
  final ValueNotifier<int> currentIndexNotifier;

  const SliderMovie({super.key, required this.currentIndexNotifier});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MoviesLoaded) {
          final movies = state.moviesList;

          if (currentIndexNotifier.value >= movies.length) {
            currentIndexNotifier.value = 0;
          }
          return CarouselSlider(
            items: movies
                .map(
                  (item) => GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   PageRouteBuilder(
                      //     transitionDuration: const Duration(milliseconds: 400),
                      //     pageBuilder:
                      //         (context, animation, secondaryAnimation) =>
                      //             MoviesDetailsScreen(movieId:item.id!),
                      //     transitionsBuilder:
                      //         (context, animation, secondaryAnimation, child) {
                      //           return FadeTransition(
                      //             opacity: animation,
                      //             child: child,
                      //           );
                      //         },
                      //   ),
                      // );
                    },
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.backGroundColor.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            Image.network(
                              item.mediumCoverImage ?? "",
                              fit: BoxFit.cover,
                            ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding:  EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 10.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star, color: AppColors.gold, size: 12),
                                const SizedBox(width: 5),
                                Text(
                                  item.rating.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: context.height * 0.35,
              viewportFraction: 0.52,
              initialPage: 0,
              autoPlayInterval: const Duration(seconds: 4),
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              autoPlay: true,
              enlargeFactor: 0.25,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                currentIndexNotifier.value = index;
              },
            ),
          );
        } else if (state is MoviesError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.message, style: TextStyle(color: Colors.red)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => context.read<MoviesCubit>().getMoviesList(),
                  child: Text("Retry"),
                ),
              ],
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
