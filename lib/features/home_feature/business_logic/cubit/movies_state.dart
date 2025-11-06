part of 'movies_cubit.dart';

@immutable
abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<MoviesDetails> moviesList;

  MoviesLoaded({required this.moviesList});
}

class MoviesError extends MoviesState {
  final String message;

  MoviesError({required this.message});
}
