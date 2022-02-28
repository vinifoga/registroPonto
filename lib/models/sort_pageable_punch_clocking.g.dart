// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_pageable_punch_clocking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortPageablePunchClocking _$SortPageablePunchClockingFromJson(
        Map<String, dynamic> json) =>
    SortPageablePunchClocking(
      content: (json['content'] as List<dynamic>)
          .map((e) => PunchClocking.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageable: Pageable.fromJson(json['pageable'] as Map<String, dynamic>),
      sort: Sort.fromJson(json['sort'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SortPageablePunchClockingToJson(
        SortPageablePunchClocking instance) =>
    <String, dynamic>{
      'content': instance.content,
      'pageable': instance.pageable,
      'sort': instance.sort,
    };
