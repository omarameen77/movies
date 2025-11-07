import 'package:dio/dio.dart';
import 'package:movies/features/movies_details/data/model_movies_details/movies_details_model.dart';
import 'package:movies/features/movies_details/data/model_movies_details/similar_movie.dart';

class MoviesDetailsWebService {
  final Dio _dio;
  static const String _baseUrl = 'https://yts.mx/api/v2';

  MoviesDetailsWebService({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: _baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  /// Get movie details with cast and images

  Future<MovieDetailResponse> getMovieDetails({
    required int movieId,
    bool withImages = true,
    bool withCast = true,
  }) async {
    try {
      final response = await _dio.get(
        '/movie_details.json',
        queryParameters: {
          'movie_id': movieId,
          'with_images': withImages,
          'with_cast': withCast,
        },
      );

      return MovieDetailResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get similar movies (suggestions)
  Future<SimilarMoviesResponse> getSimilarMovies({required int movieId}) async {
    try {
      final response = await _dio.get(
        '/movie_suggestions.json',
        queryParameters: {'movie_id': movieId},
      );

      return SimilarMoviesResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Error handler
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please try again.';

      case DioExceptionType.badResponse:
        return 'Server error: ${error.response?.statusCode}';

      case DioExceptionType.cancel:
        return 'Request cancelled';

      case DioExceptionType.connectionError:
        return 'No internet connection';

      default:
        return 'Something went wrong: ${error.message}';
    }
  }
}
