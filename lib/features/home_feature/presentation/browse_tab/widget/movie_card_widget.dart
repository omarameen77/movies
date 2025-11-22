import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/features/movies_details/presentation/screen/movies_details_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/shared/custom_rating_card.dart';
import '../../../data/model_home/home_model.dart';


class MovieCard extends StatelessWidget {
  final MoviesDetails movie;

  const MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        // TODO: Navigate to movie details
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) =>
                MoviesDetailsScreen(movieId: movie.id!),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster
          Expanded(
            child: Stack(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: movie.mediumCoverImage??"",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[800]!,
                      highlightColor: Colors.grey[700]!,
                      child: Container(
                        color: Colors.grey[850],
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[800],
                      child: const Icon(Icons.movie, color: Colors.grey, size: 40),
                    ),
                  ),
                ),


                buildCustomRatingCard(horizontal: 12.0,vertical: 10.0,movie: movie)

                // Rating Badge (Top Left)

              ],
            ),
          ),
        ],
      ),
    );
  }
}