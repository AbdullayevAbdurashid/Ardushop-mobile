// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageData _$MessageDataFromJson(Map<String, dynamic> json) => MessageData(
      id: json['id'] as String,
      payload: json['payload'] as Map<String, dynamic>?,
      action: json['action'] as Map<String, dynamic>?,
      createdAt: json['created_at'] as String,
      seen: ConvertData.stringToInt(json['seen']),
    );

Map<String, dynamic> _$MessageDataToJson(MessageData instance) => <String, dynamic>{
      'id': instance.id,
      'payload': instance.payload,
      'action': instance.action,
      'created_at': instance.createdAt,
      'seen': instance.seen,
    };
