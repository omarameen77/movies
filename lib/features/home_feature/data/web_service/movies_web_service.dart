import 'dart:math';
import 'package:dio/dio.dart';

import '../model_home/home_model.dart';


class MoviesWebService {
  final Dio dio = Dio();

  Future<MoviesResponse> getMovies({
    int limit = 14,
    String? genre,
  }) async {
    final randomPage = Random().nextInt(5) + 1;
    try {
      final queryParams = {
        'limit': limit,
        'page': randomPage,
        'sort_by': 'year',
      };

      if (genre != null && genre.isNotEmpty) {
        queryParams['genre'] = genre;
      }

      final response = await dio.get(
        "https://yts.lt/api/v2/list_movies.json",
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        return MoviesResponse.fromJson(response.data);
      } else {
        throw Exception(
            "API returned error: ${response.statusCode} - ${response.data}");
      }
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}