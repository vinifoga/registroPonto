import 'package:json_annotation/json_annotation.dart';
import 'package:registroponto/models/pageable.dart';
import 'package:registroponto/models/punch_clocking.dart';
import 'package:registroponto/models/sort.dart';

part 'sort_pageable_punch_clocking.g.dart';

@JsonSerializable()
class SortPageablePunchClocking{
  late final List<PunchClocking> content;
  late final Pageable pageable;
  late final Sort sort;

  SortPageablePunchClocking({required this.content, required this.pageable, required this.sort});

  factory SortPageablePunchClocking.fromJson(Map<String, dynamic> json) => _$SortPageablePunchClockingFromJson(json);

  Map<String, dynamic> toJson() => _$SortPageablePunchClockingToJson(this);
}