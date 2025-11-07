import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/features/movies_details/business_logic/cast_cubit/cast_cubit.dart';
import 'package:movies/features/movies_details/business_logic/movies_details_cubit/movice_details_cubit.dart';
import 'package:movies/features/movies_details/business_logic/similar_movies_cubit/similar_movies_cubit.dart';
import 'package:movies/features/movies_details/data/reposatory/movies_repository.dart';
import 'package:movies/features/movies_details/data/web_sevice/movies_details_web_service.dart';
import 'package:movies/features/movies_details/presentation/widget/movies_details_section.dart';
import 'package:movies/features/movies_details/presentation/widget/similar_section.dart';


class MoviesDetailsScreen extends StatelessWidget {
  final int movieId;
  const MoviesDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final repository = MoviesDetailsRepository(
      moviesDetailsWebService: MoviesDetailsWebService(),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              MovieDetailsCubit(repository)..getMoviesDetails(movieId),
        ),
        BlocProvider(
          create: (context) =>
              SimilarMoviesCubit(repository)..getSimilarMovies(movieId),
        ),
        BlocProvider(
          create: (context) => CastCubit(repository)..getMovieCast(movieId),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoviesDetailsSection(),
                SizedBox(height: context.height * 0.02),
                SimilarMoviesSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
