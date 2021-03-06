import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_app/core/errors/failure.dart';
import 'package:number_app/core/usecases/usecase.dart';
import 'package:number_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_app/features/number_trivia/domain/repositories/number_trivia_repo.dart';

class GetConcreteNumberTrivia extends Usecase<NumberTrivia, Params> {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTrivia({
    required this.numberTriviaRepository,
  });

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(
      params.number,
    );
  }
}

class Params extends Equatable {
  final int number;
  const Params({required this.number});
  @override
  List<Object?> get props => [number];
}
