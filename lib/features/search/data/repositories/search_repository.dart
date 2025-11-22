import '../../domain/entities/movie.dart';
import '../../domain/repositories/search_repository.dart';
import '../data_sources/search_remote_data_source.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> searchMovies(String query) async {
    try {
      final movieModels = await remoteDataSource.searchMovies(query);

      return movieModels
          .map(
            (model) => Movie(
              title: model.title,
              image: model.image,
              rating: model.rating,
              id: model.id,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }
}
