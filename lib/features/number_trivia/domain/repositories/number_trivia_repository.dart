import 'package:dartz/dartz.dart'; // for the either typing
import '../../../../core/error/failures.dart'; //for the dedicated failure type
import '../entities/number_trivia.dart'; // for the expected return type
// once data gets received

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
