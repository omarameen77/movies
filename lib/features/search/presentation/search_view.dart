import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/features/movies_details/presentation/screen/movies_details_screen.dart';
import 'package:movies/features/search/data/repositories/search_repository.dart';
import 'package:movies/features/search/domain/entities/movie.dart';
import 'package:movies/features/search/domain/usecases/search_movies_usecase.dart';
import 'package:movies/features/search/logic/cubit/search_cubit.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        SearchMoviesUseCase(
          RepositoryProvider.of<SearchRepositoryImpl>(context),
        ),
      ),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF282A28),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            context.read<SearchCubit>().searchMovies(value);
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: const TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                          prefixIcon: const ImageIcon(
                            AssetImage("assets/images/Vector.png"),
                            size: 24,
                            color: Colors.white,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),

                     SizedBox(height: context.height * 0.02),

                    Expanded(
                      child: BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, state) {
                          if (state is SearchInitial) {
                            return Center(
                              child: Image.asset(
                                "assets/images/empty.png",
                                height: 124,
                                width: 124,
                              ),
                            );
                          } else if (state is SearchLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                            );
                          } else if (state is SearchLoaded) {
                            final List<Movie> movies = state.movies;

                            if (movies.isEmpty) {
                              return const Center(
                                child: Text(
                                  "No movies found.",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              );
                            }

                            return GridView.builder(
                              itemCount: movies.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 13,
                                    childAspectRatio: 0.65,
                                  ),
                              itemBuilder: (context, index) {
                                final movie = movies[index];
                                return GestureDetector(
                                  onTap: () {
                                       Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 400),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  MoviesDetailsScreen(movieId: movie.id),
                            transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                        ),
                      );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          movie.image,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                  
                                        Positioned(
                                          top: 6,
                                          left: 6,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius.circular(
                                                6,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  movie.rating.toStringAsFixed(1),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const SizedBox(width: 2),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 14,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (state is SearchError) {
                            return Center(
                              child: Text(
                                state.message,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}