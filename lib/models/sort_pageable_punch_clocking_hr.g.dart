// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_pageable_punch_clocking_hr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortPageablePunchClockingHR _$SortPageablePunchClockingHRFromJson(
        Map<String, dynamic> json) =>
    SortPageablePunchClockingHR(
      content: (json['content'] as List<dynamic>)
          .map((e) => PunchClockingHR.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageable: Pageable.fromJson(json['pageable'] as Map<String, dynamic>),
      sort: Sort.fromJson(json['sort'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SortPageablePunchClockingHRToJson(
        SortPageablePunchClockingHR instance) =>
    <String, dynamic>{
      'content': instance.content,
      'pageable': instance.pageable,
      'sort': instance.sort,
    };
