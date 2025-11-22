

import 'package:movies/features/movies_details/data/model_movies_details/movies_details_model.dart';
import 'package:movies/features/movies_details/data/model_movies_details/similar_movie.dart';
import 'package:movies/features/movies_details/data/web_sevice/movies_details_web_service.dart';

class MoviesDetailsRepository {
  final MoviesDetailsWebService moviesDetailsWebService;

  MoviesDetailsRepository({required this.moviesDetailsWebService});

  /// Get movie details by ID
  Future<Movie?> getMovieDetails({required int movieId}) async {
    try {
      final response = await moviesDetailsWebService.getMovieDetails(
        movieId: movieId,
        withImages: true,
        withCast: true,
      );

      response.data?.movie?.cast ??= [];

      return response.data?.movie;
    } catch (e) {
      rethrow;
    }
  }

  /// Get similar movies
  Future<List<Movies>> getSimilarMovies({required int movieId}) async {
    try {
      final response = await moviesDetailsWebService.getSimilarMovies(
        movieId: movieId,
      );

      if (response.status == 'ok' && response.data?.movies != null) {
        return response.data!.movies!;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Get cast separately
  Future<List<Cast>> getMovieCast({required int movieId}) async {
    try {
      final response = await moviesDetailsWebService.getMovieDetails(
        movieId: movieId,
        withCast: true,
        withImages: false,
      );

      return response.data?.movie?.cast ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
