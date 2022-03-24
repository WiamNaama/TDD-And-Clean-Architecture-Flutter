import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_app/core/errors/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

///Doesn't accept any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
