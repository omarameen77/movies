import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/shared/custom_rating_card.dart';

Widget buildCardMovies(BuildContext context, movie) {
  return Container(
    width: context.width * 0.32,
    margin: const EdgeInsets.only(right: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Movie Poster
        Expanded(
          child: Stack(
            children: [
              // Poster Image
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

              buildCustomRatingCard(
                horizontal: 8.0,
                vertical: 6.0,
                movie: movie
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
