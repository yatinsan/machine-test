
import 'package:freezed_annotation/freezed_annotation.dart';


part 'meeting_item_model.g.dart';
part 'meeting_item_model.freezed.dart';

@freezed
abstract class MeetingItemModel with _$MeetingItemModel {
  const factory MeetingItemModel({
    String? id,
    String? title,
    String? time,
    bool? conflicted,
  }) = _MeetingItemModel;

  factory MeetingItemModel.fromJson(Map<String, Object?> json) => _$MeetingItemModelFromJson(json);
}