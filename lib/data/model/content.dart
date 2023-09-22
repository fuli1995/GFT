import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Content {
  final String? field1;
  final String? field2;
  final String? field3;
  final String? field4;
  final String? field5;
  final String? field6;

  Content(this.field1, this.field2, this.field3, this.field4, this.field5,
      this.field6);
}
