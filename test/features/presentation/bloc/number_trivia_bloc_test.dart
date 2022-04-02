import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_app/core/constants/constant.dart';
import 'package:number_app/core/errors/failure.dart';
import 'package:number_app/core/usecases/usecase.dart';
import 'package:number_app/core/utils/input_converter.dart';
import 'package:number_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_app/features/number_trivia/presentation/bloc/bloc/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

@GenerateMocks([MockGetConcreteNumberTrivia])
@GenerateMocks([MockGetRandomNumberTrivia])
@GenerateMocks([MockInputConverter])
void main() {
  late NumberTriviaBloc bloc;
  late MockMockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockMockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockMockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockMockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockMockGetRandomNumberTrivia();
    mockInputConverter = MockMockInputConverter();

    bloc = NumberTriviaBloc(
      mockGetConcreteNumberTrivia,
      mockGetRandomNumberTrivia,
      mockInputConverter,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    // The event takes in a String
    const tNumberString = '1';
    // This is the successful output of the InputConverter
    final tNumberParsed = int.parse(tNumberString);
    // NumberTrivia instance is needed too, of course
    const tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    test(
      'Should call the InputConverter to validate and convert the string to an unsigned integer',
      () async* {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        // assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test(
      'Should emit [Error] when the input is invalid',
      () async* {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
        // assert later
        final expected = [
          // The initial state is always emitted first
          Empty(),
          const Error(message: invalidInputFailureMessage),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
    );

    test(
      'Should get data from the concrete use case',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockGetConcreteNumberTrivia(any));
        // assert
        verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
      },
    );
    test(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      () async* {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Loaded(trivia: tNumberTrivia),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
    );
    test(
      'Should emit [Loading, Error] when getting data fails',
      () async* {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: serverFailureMessage),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
    );
    test(
      'Should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async* {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: cacheFailureMessage),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      },
    );
  });

  group('GetTriviaForRandomNumber', () {
    const tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    test(
      'Should get data from the random use case',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        // act
        bloc.add(GetTriviaForRandomNumber());
        await untilCalled(mockGetRandomNumberTrivia(any));
        // assert
        verify(mockGetRandomNumberTrivia(NoParams()));
      },
    );

    test(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      () async* {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Loaded(trivia: tNumberTrivia),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );

    test(
      'Should emit [Loading, Error] when getting data fails',
      () async* {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: serverFailureMessage),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );

    test(
      'Should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async* {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          const Error(message: cacheFailureMessage),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );
  });
}
