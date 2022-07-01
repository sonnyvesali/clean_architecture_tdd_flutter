import 'dart:convert';

import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({required String text, required int number})
      : super(text: text, number: number);
  // : super(number: number, text: text);
  /* Factory constructors use a factor keyword when implementing a constructor
   that doesn't always createa new instance of a class for example 
   1. a factory constructor might return an instance from cache or it
      might return an instance of a subtype
   2. Another use case for facotyr constructors is iniatlizing a final variable
      using logic that can't be handled in the initializer first
       */

  /*
  In this case we are using factory here to return a subtype (use case #1) 
  that may not always be returns for example if this is instantiated and 
  fromJson isn't called then the subtype instantiation of the NumberTriviaModel 
  wouldn't be instantiated 
   */
  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json['text'], // remember json is a mapping
      number: (json['number'] as num).toInt(),
    );
  }
  // explain why this is doesn't work:
  // factory NumberTriviaModel.toJson(NumberTriviaModel model) {
  //   return jsonEncode(model);
  // }

  //Right Code

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "number": number,
    };
  }
}
