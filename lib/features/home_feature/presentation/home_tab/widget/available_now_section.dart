import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/features/home_feature/data/model_home/home_model.dart';
import 'package:movies/features/home_feature/presentation/home_tab/widget/slider_movie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/shared/custom_gradiant_container.dart';



class AvailableNowSection extends StatelessWidget {
final  List<MoviesDetails> movies;
   AvailableNowSection({super.key , required this.movies});

  final ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.6,
      child: Stack(
        children: [
          ValueListenableBuilder<int>(
            valueListenable: currentIndexNotifier,
            builder: (context, currentIndex, _) {
              final currentMovie = movies[currentIndex % movies.length];
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
               child:  CachedNetworkImage(
                  imageUrl: currentMovie.largeCoverImage ?? "",
                  key: ValueKey(currentMovie.mediumCoverImage),
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
              );
            },
          ),

          //  gradient
          CustomGradientContainer(),

          //  Available Now
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                "assets/images/AvailableNow.png",
                width: context.width * 0.6,
              ),
            ),
          ),

          // SliderMovie
          Positioned(
            top: context.height * 0.12,
            left: 0,
            right: 0,
            child: SliderMovie(currentIndexNotifier: currentIndexNotifier),
          ),

          //  WatchNow
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                "assets/images/WatchNow.png",
                width: context.width * 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}