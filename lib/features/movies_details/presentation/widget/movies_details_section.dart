
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/consts/app_image.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/shared/custom_animated_elveted_button.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_theme.dart';
import 'package:movies/features/movies_details/business_logic/movies_details_cubit/movice_details_cubit.dart';
import 'package:movies/features/movies_details/presentation/screen/watch_web_viewer.dart';
import 'package:movies/features/movies_details/presentation/widget/header_details_widget.dart';
import 'package:movies/features/movies_details/presentation/widget/viewe_screenshot_widget.dart';

class MoviesDetailsSection extends StatelessWidget {
  const MoviesDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      builder: (context, state) {
        if (state is MoviesDetailsLoaded) {
          final movie = state.movie;
          return Column(
            children: [
              // Header (image-title-year)
              buildHeaderMoviesDetails(
                context: context,
                movieImage: movie.largeCoverImage ?? "",
                movieTitle: movie.title ?? "",
                movieYear: movie.year,
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trailer Button
                    AnimatedGlassButton(
                      colorType: "red",
                      title: "Watch Trailer",
                      onPressed: () {
                        if (movie.ytTrailerCode != null &&
                            movie.ytTrailerCode!.isNotEmpty) {
                          final trailerUrl =
                              "https://www.youtube.com/embed/${movie.ytTrailerCode}";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WatchWebViewer(url: trailerUrl),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("No trailer available"),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: context.height * 0.01),
                    // download Button
                    AnimatedGlassButton(
                      colorType: "green",
                      title: "Download",
                      onPressed: () {
                        if (movie.url != null &&
                            movie.url!.startsWith("http")) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WatchWebViewer(url: movie.url!),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("No download page found"),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: context.height * 0.02),
                    // Information
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildContainerDetails(
                          AssetImage(AppImage.love),
                          context: context,
                          title: movie.likeCount?.toString() ?? "0",
                        ),
                        _buildContainerDetails(
                          AssetImage(AppImage.clock),
                          context: context,
                          title: movie.runtime?.toString() ?? "0:0",
                        ),
                        _buildContainerDetails(
                          AssetImage(AppImage.star),
                          context: context,
                          title: movie.rating?.toString() ?? "0.0",
                        ),
                      ],
                    ),
                    SizedBox(height: context.height * 0.03),
                    // Screen Shots
                    Text(
                      "Screen Shots",
                      style: TextStyleHelper.font18WhiteBold,
                    ),
                    SizedBox(height: context.height * 0.02),

                    buildScreenShotImage(
                      movie.largeScreenshotImage1 ?? '',
                      context: context,
                    ),
                    SizedBox(height: context.height * 0.01),
                    buildScreenShotImage(
                      movie.largeScreenshotImage2 ?? '',
                      context: context,
                    ),
                    SizedBox(height: context.height * 0.01),
                    buildScreenShotImage(
                      movie.largeScreenshotImage3 ?? '',
                      context: context,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is MovieDetailsLoading) {
          return Padding(
            padding: EdgeInsetsGeometry.only(top: context.height * 0.5),
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.gold,
                strokeWidth: 2,
              ),
            ),
          );
        } else if (state is MovieDetailsError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildContainerDetails(
    ImageProvider image, {
    String title = '',
    required BuildContext context,
  }) {
    return Container(
      width: context.width * 0.26,
      height: context.height * 0.05,
      decoration: BoxDecoration(
        color: AppColors.blackFour,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(image, size: 20, color: AppColors.gold),
          SizedBox(width: context.width * 0.03),
          Text(title, style: TextStyleHelper.font16WhiteBold),
        ],
      ),
    );
  }
}
