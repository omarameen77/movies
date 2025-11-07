import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/features/movies_details/data/model_movies_details/similar_movie.dart';
import 'package:movies/features/movies_details/data/reposatory/movies_repository.dart';


part 'similar_movies_state.dart';

class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  final MoviesDetailsRepository moviesDetailsRepository;

  SimilarMoviesCubit(this.moviesDetailsRepository) : super(SimilarMoviesInitial());

  Future<void> getSimilarMovies(int movieId) async {
    emit(SimilarMoviesLoading());
    try {
      final similarMovies = await moviesDetailsRepository.getSimilarMovies(movieId: movieId);
      emit(SimilarMoviesLoaded(similarMovies: similarMovies));
    } catch (e) {
      emit(SimilarMoviesError(message: e.toString()));
    }
  }
}
