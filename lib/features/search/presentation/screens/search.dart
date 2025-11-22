
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/search/Core/network/dio_client.dart';
import 'package:movies/features/search/data/data_sources/search_remote_data_source.dart';
import 'package:movies/features/search/data/repositories/search_repository.dart';
import 'package:movies/features/search/domain/usecases/search_movies_usecase.dart';
import 'package:movies/features/search/logic/cubit/search_cubit.dart';
import 'package:movies/features/search/presentation/search_view.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => SearchRemoteDataSource(DioClient()),
        ),
        RepositoryProvider(
          create: (context) => SearchRepositoryImpl(
            context.read<SearchRemoteDataSource>(),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => SearchCubit(
          SearchMoviesUseCase(
            context.read<SearchRepositoryImpl>(),
          ),
        ),
        child:  SearchView(),
      ),
    );
  }
}
