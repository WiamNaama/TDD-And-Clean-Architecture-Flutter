import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_app/core/constants/constant.dart';
import 'package:number_app/core/errors/failure.dart';
import 'package:number_app/core/usecases/usecase.dart';
import 'package:number_app/core/utils/input_converter.dart';
import 'package:number_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaState get initialState => Empty();

  NumberTriviaBloc(
    this.getConcreteNumberTrivia,
    this.getRandomNumberTrivia,
    this.inputConverter,
  ) : super(Empty()) {
    on<NumberTriviaEvent>((event, emit) async {
      if (event is GetTriviaForConcreteNumber) {
        final inputEither =
            inputConverter.stringToUnsignedInteger(event.numberString);

        inputEither.fold(
            (l) => emit(
                  const Error(message: invalidInputFailureMessage),
                ), (r) async {
          emit(Loading());
          final failureOrTrivia = await getConcreteNumberTrivia(
            Params(number: r),
          );

          failureOrTrivia.fold(
            (l) => Error(message: _mapFailureToMessage(l)),
            (r) => Loaded(trivia: r),
          );
        });
      } else if (event is GetTriviaForRandomNumber) {
        emit(Loading());
        final failureOrTrivia = await getRandomNumberTrivia(
          NoParams(),
        );
        failureOrTrivia.fold(
          (l) => Error(message: _mapFailureToMessage(l)),
          (r) => Loaded(trivia: r),
        );
      }
    });
  }
}

String _mapFailureToMessage(Failure failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;
    case CacheFailure:
      return cacheFailureMessage;
    default:
      return 'Unexpected Error';
  }
}
