import 'package:wordle/core/core.dart';
import 'package:wordle/dio/dio.dart';

abstract class WordExistenceRemoteProvider {
  Future<Result<RemoteFetchFailure, bool>> exists(String word);
}

class RapidApiWordExistenceRemoteProvider
    implements WordExistenceRemoteProvider {
  const RapidApiWordExistenceRemoteProvider({
    required DioFacade dio,
  }) : _dio = dio;

  final DioFacade _dio;

  @override
  Future<Result<RemoteFetchFailure, bool>> exists(String word) async {
    final result = await _dio.get(
      '$word/hasUsages',
    );

    return result.when(
      failed: (f) => f.when(
        timeout: () => Result.failure(f.toRemoteFetchFailure()),
        unknown: (info) => Result.failure(f.toRemoteFetchFailure()),
        noInternet: () => Result.failure(f.toRemoteFetchFailure()),
        badResponse: (response) {
          if (response.statusCode == 404) return Result.success(false);
          return Result.failure(f.toRemoteFetchFailure());
        },
      ),
      successful: (response) {
        if (response.statusCode == 200) return Result.success(true);

        return Result.success(false);
      },
    );
  }
}
