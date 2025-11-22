
import 'package:movies/features/search/Core/network/api_constants.dart';
import 'package:movies/features/search/Core/network/dio_client.dart';

import '../models/movie_search_model.dart';

class SearchRemoteDataSource {
  final DioClient dioClient;

  SearchRemoteDataSource(this.dioClient);

  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await dioClient.get(
        listMoviesEndpoint,
        params: {"query_term": query},
      );

      final data = response.data["data"];
      if (data == null || data["movies"] == null) {
        return [];
      }

      final moviesJson = data["movies"] as List<dynamic>;
      return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to fetch movies: $e");
    }
  }
}
