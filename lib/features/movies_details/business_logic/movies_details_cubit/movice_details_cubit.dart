import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/features/movies_details/data/model_movies_details/movies_details_model.dart';
import 'package:movies/features/movies_details/data/reposatory/movies_repository.dart';


part 'movice_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MoviesDetailsRepository moviesDetailsRepository;

  MovieDetailsCubit(this.moviesDetailsRepository)
    : super(MovieDetailsInitial());

  Future<void> getMoviesDetails(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final movieDetails = await moviesDetailsRepository.getMovieDetails(
        movieId: movieId,
      );
      if (movieDetails != null) {
        emit(MoviesDetailsLoaded(movie: movieDetails));
      } else {
        emit(MovieDetailsError(message: 'No movie details found.'));
      }
    } catch (e) {
      emit(MovieDetailsError(message: e.toString()));
    }
  }
}
