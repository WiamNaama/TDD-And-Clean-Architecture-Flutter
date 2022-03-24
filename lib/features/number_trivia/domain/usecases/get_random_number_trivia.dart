import 'package:dartz/dartz.dart';
import 'package:number_app/core/errors/failure.dart';
import 'package:number_app/core/usecases/usecase.dart';
import 'package:number_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_app/features/number_trivia/domain/repositories/number_trivia_repo.dart';

class GetRandomNumberTrivia extends Usecase<NumberTrivia, NoParams> {
  final NumberTriviaRepository numberTriviaRepository;

  GetRandomNumberTrivia({
    required this.numberTriviaRepository,
  });

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await numberTriviaRepository.getRandomNumberTrivia();
  }
}
