import 'package:number_app/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required int number,
    required String text,
  }) : super(
          number: number,
          text: text,
        );

  factory NumberTriviaModel.fromJson(Map<String, dynamic> jsonData) {
    return NumberTriviaModel(
      text: jsonData['text'],
      number: (jsonData['number'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
    };
  }
}
