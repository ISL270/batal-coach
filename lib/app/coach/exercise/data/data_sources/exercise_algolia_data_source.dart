import 'package:algoliasearch/algoliasearch.dart';
import 'package:btl/app/coach/exercise/data/data_sources/exercise_remote_data_source.dart';
import 'package:btl/app/coach/exercise/data/models/exercise_rm.dart';
import 'package:btl/app/core/models/generic_exception.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part '../models/exercise_algolia.dart';
part 'exercise_algolia_data_source.g.dart';

@Singleton(as: ExerciseRemoteDataSource)
class ExerciseAlgoliaDataSource implements ExerciseRemoteDataSource {
  final _client = SearchClient(
    appId: 'A12DSW0DJT',
    apiKey: 'ed3abc9f3c0939bb752b8e350d26993a',
  );

  @override
  Future<Either<NetworkException, Iterable<ExerciseRM>>> getExercises({
    required String searchTerm,
    required int pageSize,
    required int page,
  }) async {
    final queryHits = SearchForHits(
      indexName: 'exercises',
      query: searchTerm,
      page: page,
      hitsPerPage: pageSize,
    );
    try {
      final responseHits = await _client.searchIndex(request: queryHits);
      final exercises = responseHits.hits.map(ExerciseAlgolia.fromJson);
      return right(exercises);
    } catch (e) {
      return left(NetworkException(code: 'placeholder1', message: e.toString()));
    }
  }
}
