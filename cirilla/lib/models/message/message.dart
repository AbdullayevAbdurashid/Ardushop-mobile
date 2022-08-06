import 'package:cirilla/utils/convert_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class MessageData {
  String id;

  Map<String, dynamic>? payload;

  Map<String, dynamic>? action;

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(fromJson: ConvertData.stringToInt)
  int seen;

  MessageData({
    required this.id,
    this.payload,
    this.action,
    required this.createdAt,
    required this.seen,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) => _$MessageDataFromJson(json);

  factory MessageData.readMessage(bool value, MessageData data) => MessageData(
        id: data.id,
        payload: data.payload,
        action: data.action,
        createdAt: data.createdAt,
        seen: data.seen,
      );

  void read() {
    seen = 1;
  }

  Map<String, dynamic> toJson() => _$MessageDataToJson(this);
}
