import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model_home/home_model.dart';
import '../../data/reposatory/reposatory.dart';


part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRepository moviesRepository;

  MoviesCubit(this.moviesRepository) : super(MoviesInitial());

  Future<void> getMoviesList() async {
    try {
      emit(MoviesLoading());
      final moviesList = await moviesRepository.getMovies();
      moviesList.shuffle();
      emit(MoviesLoaded(moviesList: moviesList));
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }

  Future<List<MoviesDetails>> getMoviesByGenre(String genre) async {
    try {
      final movies = await moviesRepository.getMoviesByGenre(genre);
      movies.shuffle();
      return movies;
    } catch (e) {
      return [];
    }
  }

  Future<void> refreshMoviesList() async {
    await getMoviesList();
  }
}