import 'package:json_annotation/json_annotation.dart';

part 'sort.g.dart';

@JsonSerializable()
class Sort{
  late final numberOfElements;
  late final size;
  late final number;
  late final empty;

  Sort({this.numberOfElements, this.size, this.number, this.empty});

  factory Sort.fromJson(Map<String, dynamic> json) => _$SortFromJson(json);

  Map<String, dynamic> toJson() => _$SortToJson(this);

}