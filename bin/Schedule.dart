import 'package:json_annotation/json_annotation.dart';

part 'Schedule.g.dart';

@JsonSerializable()
class Schedule {
  String StartDate;
  String DisplayStartDate;
  String StartTime;
  String EndTime;
  String SsrComponentDescription;
  String ClassCode;
  String Room;
  String Campus;
  String DeliveryMode;
  String CourseCode;
  String CourseTitleEn;
  String ClassType;
  int WeekSession;
  int CourseSessionNumber;
  String MeetingId;
  String MeetingPassword;
  String MeetingUrl;
  String UserFlag;
  String BinusianId;
  String PersonCode;
  String FullName;
  String AcademicCareer;
  String ClassMeetingId;
  String Location;
  String MeetingStartDate;

  Schedule(
      this.StartDate,
      this.DisplayStartDate,
      this.StartTime,
      this.EndTime,
      this.SsrComponentDescription,
      this.ClassCode,
      this.Room,
      this.Campus,
      this.DeliveryMode,
      this.CourseCode,
      this.CourseTitleEn,
      this.ClassType,
      this.WeekSession,
      this.CourseSessionNumber,
      this.MeetingId,
      this.MeetingPassword,
      this.MeetingUrl,
      this.UserFlag,
      this.BinusianId,
      this.PersonCode,
      this.FullName,
      this.AcademicCareer,
      this.ClassMeetingId,
      this.Location,
      this.MeetingStartDate);

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

  @override
  String toString() {
    return 'Class Date: $DisplayStartDate; Start Time: $StartTime; End Time: $EndTime; Course: $CourseTitleEn';
  }
}
