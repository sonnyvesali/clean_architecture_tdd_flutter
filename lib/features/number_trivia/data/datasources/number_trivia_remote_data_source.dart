import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  // Calls the https://numbersapi.com/{number} endpoint
  // thows a server exception for all error codes
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  //Calls the https://numbersapi.com/random endpoint.
  // Throws a serverexception for all error codes
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
