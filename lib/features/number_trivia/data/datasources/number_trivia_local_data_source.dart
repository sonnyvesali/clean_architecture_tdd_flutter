import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  //Gets the cached [NumberTriviaModel] which was gotten w/ the last API call

  //Thows the [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}
