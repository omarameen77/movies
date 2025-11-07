import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies_details/business_logic/cast_cubit/cast_state.dart';
import 'package:movies/features/movies_details/data/reposatory/movies_repository.dart';

class CastCubit extends Cubit<CastState> {
  final MoviesDetailsRepository moviesDetailsRepository;

  CastCubit(this.moviesDetailsRepository) : super(CastInitial());

  Future<void> getMovieCast(int movieId) async {
    emit(CastLoading());
    try {
      final castList = await moviesDetailsRepository.getMovieCast(
        movieId: movieId,
      );

      emit(CastLoaded(castList));
    } catch (e) {
      emit(CastError(e.toString()));
    }
  }
}
