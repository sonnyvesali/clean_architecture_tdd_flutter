import 'package:ca_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:ca_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:ca_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import './get_concrete_number_trivia_test.mocks.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

@GenerateMocks([MockNumberTriviaRepository])
void main() {
  // ohh the reason they don't get instantiated is b/c of null safety and
  // is assigned such upon deployment if you want this to be ameliorated
  // add the late keywork
  late GetConcreteNumberTrivia usecase;
  late MockMockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockMockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });
  const tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test("Should get trivia for number from the repository", () async {
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber))
        .thenAnswer((_) async => Right(tNumberTrivia));
    final result = await usecase(const Params(number: tNumber));

    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
// this shit took so long to get I'm just happy you got it you went through
// you did your best and you came out winning my mind is a little fried on
// the programming front let's read and then come back after dinner to
// watch the vid take notes and then go to sleep
