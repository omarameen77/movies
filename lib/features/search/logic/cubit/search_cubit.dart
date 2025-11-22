import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/search_movies_usecase.dart';
import '../../domain/entities/movie.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchMoviesUseCase searchMoviesUseCase;

  SearchCubit(this.searchMoviesUseCase) : super(SearchInitial());

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) return;

    emit(SearchLoading());

    try {
      final movies = await searchMoviesUseCase(query);
      emit(SearchLoaded(movies));
    } catch (e) {
      emit(SearchError("Failed to load movies: $e"));
    }
  }
}
