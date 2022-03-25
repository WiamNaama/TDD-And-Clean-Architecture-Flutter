import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_app/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test Text");

  final expectedJsonMap = {
    "text": "Test Text",
    "number": 1,
  };

  test("Should be a subclass of NumberTrivia entity", () async {
    //assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group("FromJson", () {
    test("Should return a valid model when JSON number is an integer",
        () async {
      //arrange
      final Map<String, dynamic> jsonData = jsonDecode(fixture('trivia.json'));

      //act
      final result = NumberTriviaModel.fromJson(jsonData);

      //assert
      expect(result, tNumberTriviaModel);
    });

    test(
      'Should return a valid model when the JSON number is regarded as a double',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_double.json'));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, tNumberTriviaModel);
      },
    );
  });

  test("Should return a JSON map containing the proper data", () {
    //act
    final result = tNumberTriviaModel.toJson();

    //assert
    expect(result, expectedJsonMap);
  });
}
