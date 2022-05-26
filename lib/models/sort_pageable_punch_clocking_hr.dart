import 'package:json_annotation/json_annotation.dart';
import 'package:registroponto/models/pageable.dart';
import 'package:registroponto/models/punch_clocking.dart';
import 'package:registroponto/models/punch_clocking_hr.dart';
import 'package:registroponto/models/sort.dart';

part 'sort_pageable_punch_clocking_hr.g.dart';

@JsonSerializable()
class SortPageablePunchClockingHR{
  late final List<PunchClockingHR> content;
  late final Pageable pageable;
  late final Sort sort;

  SortPageablePunchClockingHR({required this.content, required this.pageable, required this.sort});

  factory SortPageablePunchClockingHR.fromJson(Map<String, dynamic> json) => _$SortPageablePunchClockingHRFromJson(json);

  Map<String, dynamic> toJson() => _$SortPageablePunchClockingHRToJson(this);
}