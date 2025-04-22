
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meetings/data/model/meeting_item_model.dart';


part 'meeting_date_model.g.dart';
part 'meeting_date_model.freezed.dart';

@freezed
abstract class MeetingDateModel with _$MeetingDateModel {
  const factory MeetingDateModel({
    String? date,
    List<MeetingItemModel>? items,
  }) = _MeetingDateModel;

  factory MeetingDateModel.fromJson(Map<String, Object?> json) => _$MeetingDateModelFromJson(json);
}