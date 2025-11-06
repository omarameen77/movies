

import '../model_home/home_model.dart';
import '../web_service/movies_web_service.dart';

class MoviesRepository {
  final MoviesWebService moviesWebService;

  MoviesRepository({required this.moviesWebService});

  Future<List<MoviesDetails>> getMoviesByGenre(String genre) async {
    final moviesResponse = await moviesWebService.getMovies(genre: genre);
    return moviesResponse.data?.movies ?? [];
  }

  Future<List<MoviesDetails>> getMovies() async {
    final moviesResponse = await moviesWebService.getMovies();
    return moviesResponse.data?.movies ?? [];
  }
}