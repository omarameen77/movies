part of 'similar_movies_cubit.dart';

@immutable
sealed class SimilarMoviesState {}

class SimilarMoviesInitial extends SimilarMoviesState {}

class SimilarMoviesLoading extends SimilarMoviesState {}

class SimilarMoviesLoaded extends SimilarMoviesState {
  final List<Movies> similarMovies;
  SimilarMoviesLoaded({required this.similarMovies});
}

class SimilarMoviesError extends SimilarMoviesState {
  final String message;
  SimilarMoviesError({required this.message});
}
