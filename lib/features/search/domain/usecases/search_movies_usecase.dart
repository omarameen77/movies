import '../entities/movie.dart';
import '../repositories/search_repository.dart';

class SearchMoviesUseCase {
  final SearchRepository repository;

  SearchMoviesUseCase(this.repository);

  Future<List<Movie>> call(String query) async {
    return await repository.searchMovies(query);
  }
}
