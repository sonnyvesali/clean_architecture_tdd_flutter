// remember these are the shapes of the data that biz logic
// uses and is received from repositories

import 'package:equatable/equatable.dart';

class NumberTrivia extends Equatable {
  final String text;
  final int number;

  NumberTrivia({
    required this.text,
    required this.number,
  });

  @override
  List<Object> get props => [
        text,
        number
      ]; /* this is ued when we want State 
                                            to other values declared inside the
                                            list, in our case text and number
                                           */
}
