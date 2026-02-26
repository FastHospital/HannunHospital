//  EX web Model
/*
  Created in: 12/01/2026 14:09
  Author: Chansol, Park
  Description: EX web Model
  Update log: 
    DUMMY 00/00/0000 00:00, 'Point X, Description', Creator: Chansol, Park
  Version: 1.0
  Dependency: SQFlite, Path, collection

  DateTime MUST converted using value.toIso8601String() consider .toUtc and .isUtc
  Stored DateTime in String MUST converted using DateTime.parse(value);
*/

class ModelWeb {
  //  Property
  int? seq;
  String value1;
  double value2;
  DateTime value3;

  //  Constructor
  ModelWeb({
    this.seq,
    required this.value1,
    required this.value2,
    required this.value3,
  });

  //  Decode from Json type
  factory ModelWeb.fromJson(Map<String, dynamic> json) {
    return ModelWeb(
      seq: json['seq'],
      value1: json['value1'],
      value2: json['value2'],
      value3: DateTime.parse(json['value3']),
    );
  }

  //  Encode to Json type
  Map<String, dynamic> toJson() {
    return {
      'seq': seq,
      'value1': value1,
      'value2': value2,
      'value3': value3.isUtc
          ? value3.toIso8601String()
          : value3.toUtc().toIso8601String(),
    };
  }

  //  copyWith for Riverpod state
  /*  
  ****NOTICE****
    All keys MUST NOT be changed. Therefore NO keys in copyWith requirement.
  */

  ModelWeb copyWith({String? value1, double? value2, DateTime? value3}) {
    return ModelWeb(
      seq: seq,
      value1: value1 ?? this.value1,
      value2: value2 ?? this.value2,
      value3: value3 ?? this.value3,
    );
  }
}
