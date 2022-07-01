import 'package:ca_tdd/core/usecases/usecase.dart';
import 'package:ca_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:ca_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:ca_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
// create the file later
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import './get_random_number_trivia_test.mocks.dart';

//same class ? ==> No need for Codegen and annotation b/c it's the same
class SecondMockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

// repository but if it was different you would add the following decorator
@GenerateMocks([SecondMockNumberTriviaRepository])
void main() {
  late GetRandomNumberTrivia usecase;
  late SecondMockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockSecondMockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });
  final tNumberTrivia = NumberTrivia(number: 1, text: "test");

  test("Should get trivia from random number in the repository", () async {
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumberTrivia));
    // class that works
    final result = await usecase(NoParams());
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
