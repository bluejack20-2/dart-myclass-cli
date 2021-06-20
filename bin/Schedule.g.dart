// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return Schedule(
    json['StartDate'] as String,
    json['DisplayStartDate'] as String,
    json['StartTime'] as String,
    json['EndTime'] as String,
    json['SsrComponentDescription'] as String,
    json['ClassCode'] as String,
    json['Room'] as String,
    json['Campus'] as String,
    json['DeliveryMode'] as String,
    json['CourseCode'] as String,
    json['CourseTitleEn'] as String,
    json['ClassType'] as String,
    json['WeekSession'] as int,
    json['CourseSessionNumber'] as int,
    json['MeetingId'] as String,
    json['MeetingPassword'] as String,
    json['MeetingUrl'] as String,
    json['UserFlag'] as String,
    json['BinusianId'] as String,
    json['PersonCode'] as String,
    json['FullName'] as String,
    json['AcademicCareer'] as String,
    json['ClassMeetingId'] as String,
    json['Location'] as String,
    json['MeetingStartDate'] as String,
  );
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'StartDate': instance.StartDate,
      'DisplayStartDate': instance.DisplayStartDate,
      'StartTime': instance.StartTime,
      'EndTime': instance.EndTime,
      'SsrComponentDescription': instance.SsrComponentDescription,
      'ClassCode': instance.ClassCode,
      'Room': instance.Room,
      'Campus': instance.Campus,
      'DeliveryMode': instance.DeliveryMode,
      'CourseCode': instance.CourseCode,
      'CourseTitleEn': instance.CourseTitleEn,
      'ClassType': instance.ClassType,
      'WeekSession': instance.WeekSession,
      'CourseSessionNumber': instance.CourseSessionNumber,
      'MeetingId': instance.MeetingId,
      'MeetingPassword': instance.MeetingPassword,
      'MeetingUrl': instance.MeetingUrl,
      'UserFlag': instance.UserFlag,
      'BinusianId': instance.BinusianId,
      'PersonCode': instance.PersonCode,
      'FullName': instance.FullName,
      'AcademicCareer': instance.AcademicCareer,
      'ClassMeetingId': instance.ClassMeetingId,
      'Location': instance.Location,
      'MeetingStartDate': instance.MeetingStartDate,
    };
