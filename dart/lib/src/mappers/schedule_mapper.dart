import '../models/schedule.dart';
import '../utils/date_time_utils.dart';

class ScheduleMapper {
  static Schedule fromMap(Map<String, dynamic> map) {
    return Schedule(
      id: map['id'],
      type: courseEventTypeFromString(map['type'] as String),
      courseName: map['courseName'] as String?,
      title: map['title'] as String,
      dateTime: DateTimeUtils.parse(map['dateTime'])!,
      endTime: DateTimeUtils.parse(map['endTime']),
      location: map['location'] as String?,
      notes: map['notes'] as String?,
    );
  }

  static Map<String, dynamic> toFirestore(Schedule schedule) {
    return {
      'id': schedule.id,
      'type': courseEventTypeToString(schedule.type),
      if (schedule.courseName != null) 'courseName': schedule.courseName,
      'title': schedule.title,
      'dateTime': schedule.dateTime, // DateTime
      if (schedule.endTime != null) 'endTime': schedule.endTime, // DateTime
      if (schedule.location != null) 'location': schedule.location,
      if (schedule.notes != null) 'notes': schedule.notes,
    };
  }

  static Map<String, dynamic> toMap(Schedule schedule) {
    return {
      'id': schedule.id,
      'type': courseEventTypeToString(schedule.type),
      if (schedule.courseName != null) 'courseName': schedule.courseName,
      'title': schedule.title,
      'dateTime': schedule.dateTime.toIso8601String(), // String
      if (schedule.endTime != null) 'endTime': schedule.endTime!.toIso8601String(), // String
      if (schedule.location != null) 'location': schedule.location,
      if (schedule.notes != null) 'notes': schedule.notes,
    };
  }

  static bool isSameDay(DateTime? dateA, DateTime? dateB) {
    return dateA?.year == dateB?.year &&
        dateA?.month == dateB?.month &&
        dateA?.day == dateB?.day;
  }

  static (Schedule?, Schedule?, int, int) findNextSchedules(
    List<Schedule> schedules,
  ) {
    final now = DateTime.now();
    Schedule? ongoing;
    Schedule? next;
    int completedTodayCount = 0;
    int totalTodayCount = 0;

    for (final schedule in schedules) {
      final endTime =
          schedule.endTime ?? schedule.dateTime.add(const Duration(hours: 1));
      if (schedule.dateTime.isBefore(now) && endTime.isAfter(now)) {
        ongoing = schedule;
      }
      if (schedule.dateTime.isAfter(now) &&
          (next == null || schedule.dateTime.isBefore(next.dateTime))) {
        next = schedule;
      }
      final isSameDay = ScheduleMapper.isSameDay(schedule.dateTime, now);
      if (isSameDay) {
        totalTodayCount++;
        if (schedule.dateTime.isBefore(now)) {
          completedTodayCount++;
        }
      }
    }
    return (ongoing, next, completedTodayCount, totalTodayCount);
  }
}
