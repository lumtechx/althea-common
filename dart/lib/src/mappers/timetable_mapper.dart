import '../models/timetable_model.dart';
import '../models/schedule.dart';
import '../utils/custom_time_of_day.dart';

class TimetableMapper {
  static TimetableEvent eventFromMap(Map<String, dynamic> map) {
    return TimetableEvent(
      id: map['id'] as String? ?? '',
      dayIndex: DayOfWeek.values[((map['dayIndex'] ?? (map['day'] as int? ?? 1)) - 1) % 7],
      startTime: CustomTimeOfDay.fromString(map['startTime'] as String? ?? '00:00'),
      endTime: CustomTimeOfDay.fromString(map['endTime'] as String? ?? '00:00'),
      courseCode: map['courseCode'] as String? ?? '',
      location: map['location'] as String? ?? '',
      notes: map['notes'] as String?,
      eventType: map['eventType'] != null
          ? courseEventTypeFromString(map['eventType'] as String)
          : null,
    );
  }

  static Map<String, dynamic> eventToMap(TimetableEvent event) {
    return {
      'id': event.id,
      'day': event.dayIndex.name,
      'dayIndex': event.dayIndex.index + 1,
      'startTime': event.startTime.toFormattedString(),
      'endTime': event.endTime.toFormattedString(),
      'courseCode': event.courseCode,
      'location': event.location,
      if (event.notes != null) 'notes': event.notes,
      if (event.eventType != null) 'eventType': event.eventType!.name,
    };
  }

  static Timetable timetableFromMap(Map<String, dynamic> map) {
    final rawEvents = map['events'];
    List<TimetableEvent> parsedEvents = [];
    if (rawEvents is Map) {
      parsedEvents = rawEvents.values
          .map((e) => eventFromMap(Map<String, dynamic>.from(e as Map)))
          .toList();
    } else if (rawEvents is List) {
      parsedEvents = rawEvents
          .map((e) => eventFromMap(Map<String, dynamic>.from(e as Map)))
          .toList();
    }
    return Timetable(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      events: parsedEvents,
    );
  }

  static Map<String, dynamic> timetableToMap(Timetable timetable) {
    return {
      'id': timetable.id,
      'name': timetable.name,
      'events': timetable.events.map((e) => eventToMap(e)).toList(),
    };
  }
}
