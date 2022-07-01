// we will now be testing the relationship between this and the Entity
import 'dart:convert';

import 'package:ca_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:ca_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  // if it doesn't fail b/c of typing and your confused it's the values since
  // dart doesn't have value equivocation it just throws a default they are
  // not equal and you're confused b/c the types are the same but in this case
  // it's b/c of the values so keep that in mind if you're confused
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test Text");
  // ^^ since values are assigned the late keyword isn't needed but if there
  // was a setup function you would have to add final before those variables

  test(
    "Should be a subclass of NumberTrivia entity",
    () async {
      //assert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group("fromJson", () {
    test("Should return a valid model when the JSON numner is an integer",
        () async {
      final Map<String, dynamic> jsonMap = jsonDecode(fixture("trivia.json"));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });
  });

  group("ToJSON", () {
    test("Should Convert Model to valid JSON", () async {
      /*
      Pseudo Code:
          1. Get the JSON file from fixtures
          2. Get the Model, and feed it into the toJSON method 
          3. Compare the Serialized Model and the JSON file
       */
      // final jsonMap = jsonEncode(fixture("trivia.json"));
      final jsonMap = {
        "text": "Test Text",
        "number": 1,
      };
      // this has extra fields so testing equivocatio /doesn't workd
      final expectedResult = tNumberTriviaModel.toJson();
      expect(expectedResult, jsonMap);
    });
  });
}
