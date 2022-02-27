import 'package:json_annotation/json_annotation.dart';

part 'pageable.g.dart';

@JsonSerializable()
class Pageable{
  late final totalPages;
  late final totalElements;
  late final last;
  late final first;

  Pageable({this.totalPages, this.totalElements, this.last, this.first});

  factory Pageable.fromJson(Map<String, dynamic> json) => _$PageableFromJson(json);

  Map<String, dynamic> toJson() => _$PageableToJson(this);
}