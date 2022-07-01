import 'package:ca_tdd/core/error/failures.dart';
import 'package:ca_tdd/core/network/network_info.dart';
import 'package:ca_tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:ca_tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:ca_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:ca_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:ca_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import './number_trivia_repository_impl_test.mocks.dart';

class MRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

class MLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MNetworkInfo extends Mock implements NetworkInfo {}

@GenerateMocks([MRemoteDataSource, MLocalDataSource, MNetworkInfo])
void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockMRemoteDataSource mockRemoteDataSource;
  late MockMLocalDataSource mockLocalDataSource;
  late MockMNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockMRemoteDataSource();
    mockLocalDataSource = MockMLocalDataSource();
    mockNetworkInfo = MockMNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });
  final tNumber = 1;
  final tNumberTriviaModel =
      NumberTriviaModel(text: "Test Text", number: tNumber);
  final NumberTrivia tNumberTrivia = tNumberTriviaModel;

  group("device is online", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test(
        "Should return remote data when we call remote source returns some data successfully",
        () async {
      //Arrange
      when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
          .thenAnswer((_) async => tNumberTriviaModel);
      // when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
      //     .thenAnswer((_) async => tNumberTriviaModel);
      //Act
      final result = await repository.getConcreteNumberTrivia(tNumber);

      verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      expect(result, equals(Right(tNumberTrivia)));
    });

    test(
        "Should cache data when we call remote source returns some data successfully",
        () async {
      //ARRANGE
      when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
          .thenAnswer((_) async => tNumberTriviaModel);
      // ACT
      await repository.getConcreteNumberTrivia(tNumber);
      // assert
      verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
    });

    test("Should return server failure when remote data call is unsuccessful",
        () async {
      //arrange
      when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
          .thenThrow(ServerException());
      //act
      final result = await repository.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group("Device is offline", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    test("", () async {});
  });

  // group('getConcreteNumberTrivia', () {
  //   //DATA FOR MOCKS & ASSERTIONS
  //   // We'll use these three vars throughout all these tests

  //   test("Should check if device is online", () {
  //     //Arrange
  //     when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  //     // Act
  //     repository.getConcreteNumberTrivia(tNumber);
  //     // Assert
  //     verify(mockNetworkInfo.isConnected);
  //   });
  // });
}
