import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import "package:mockito/annotations.dart";
import 'package:number_app/core/usecases/usecase.dart';
import "get_random_number_trivia_test.mocks.dart";
import 'package:number_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import 'package:number_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_app/features/number_trivia/domain/repositories/number_trivia_repo.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

@GenerateMocks([MockNumberTriviaRepository])
void main() {
  late GetRandomNumberTrivia usecase;
  late MockMockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockMockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(
        numberTriviaRepository: mockNumberTriviaRepository);
  });

  const tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    'Should get trivia for the random number from the repository',
    () async {
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const Right(tNumberTrivia));

      final result = await usecase(NoParams());

      expect(result, const Right(tNumberTrivia));

      verify(mockNumberTriviaRepository.getRandomNumberTrivia());

      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
