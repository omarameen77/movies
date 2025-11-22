import '../entities/movie.dart';

abstract class SearchRepository {
  Future<List<Movie>> searchMovies(String query);
}
