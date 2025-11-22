part of 'movice_details_cubit.dart';

@immutable
sealed class MovieDetailsState {}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailsLoading extends MovieDetailsState {}

final class MoviesDetailsLoaded extends MovieDetailsState {
  final Movie movie;
  MoviesDetailsLoaded({required this.movie});
}

final class MovieDetailsError extends MovieDetailsState {
  final String message;
  MovieDetailsError({required this.message});
}
