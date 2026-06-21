import 'course_model.dart';
import 'schedule.dart';
import '../utils/custom_time_of_day.dart';
import '../utils/string_extension.dart';
import '../mappers/timetable_mapper.dart';

// ignore: constant_identifier_names
enum DayOfWeek { MON, TUE, WED, THU, FRI, SAT, SUN }

class TimetableEvent {
  final String id;
  final DayOfWeek dayIndex;
  final CustomTimeOfDay startTime;
  final CustomTimeOfDay endTime;
  final String courseCode;
  final String location;
  final String? notes;
  final CourseEventType? eventType;

  TimetableEvent({
    required this.id,
    required this.dayIndex,
    required this.startTime,
    required this.endTime,
    required this.courseCode,
    required this.location,
    this.notes,
    this.eventType,
  });

  factory TimetableEvent.fromMap(Map<String, dynamic> map) {
    return TimetableMapper.eventFromMap(map);
  }

  TimetableEvent copyWith({
    String? id,
    DayOfWeek? dayIndex,
    CustomTimeOfDay? startTime,
    CustomTimeOfDay? endTime,
    String? courseCode,
    String? location,
    String? notes,
    CourseEventType? eventType,
  }) {
    return TimetableEvent(
      id: id ?? this.id,
      dayIndex: dayIndex ?? this.dayIndex,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      courseCode: courseCode ?? this.courseCode,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      eventType: eventType ?? this.eventType,
    );
  }

  Map<String, dynamic> toMap() {
    return TimetableMapper.eventToMap(this);
  }

  Schedule toSchedule(List<Course> courses, String name) {
    final course = courses.where((e) => e.courseCode == courseCode).firstOrNull;
    final type = eventType ?? CourseEventType.lecture;
    final nextStartTime = calculateNextOccurrence(dayIndex, startTime);
    final nextEndTime = DateTime(
      nextStartTime.year,
      nextStartTime.month,
      nextStartTime.day,
      endTime.hour,
      endTime.minute,
    );
    return Schedule(
      id: id,
      title: ('${course?.courseName ?? ''} ${type.name.capitalizeWords()}')
          .capitalizeWords(),
      courseName: course?.courseName,
      type: type,
      dateTime: nextStartTime,
      endTime: nextEndTime,
      location: location,
      notes: '${notes != null ? notes! : ''} from Timetable: $name',
    );
  }
}

class Timetable {
  final String id;
  final String name;
  final List<TimetableEvent> events;

  Timetable({required this.name, required this.events, required this.id});

  factory Timetable.fromMap(Map<String, dynamic> map) {
    return TimetableMapper.timetableFromMap(map);
  }

  Map<String, dynamic> toMap() {
    return TimetableMapper.timetableToMap(this);
  }

  TimetableEvent? getNextUpcomingEvent() {
    final now = DateTime.now();
    final today = DayOfWeek.values[now.weekday - 1];
    final currentTime = CustomTimeOfDay.fromDateTime(now);

    final upcomingEvents = events.where((event) {
      if (event.dayIndex.index > today.index) return true;
      if (event.dayIndex.index == today.index) {
        return (event.startTime.hour * 60 + event.startTime.minute) >
            (currentTime.hour * 60 + currentTime.minute);
      }
      return false;
    }).toList();

    upcomingEvents.sort((a, b) {
      int dayCompare = a.dayIndex.index.compareTo(b.dayIndex.index);
      if (dayCompare != 0) return dayCompare;
      return (a.startTime.hour * 60 + a.startTime.minute).compareTo(
        b.startTime.hour * 60 + b.startTime.minute,
      );
    });
    return upcomingEvents.firstOrNull;
  }
}

DateTime calculateNextOccurrence(
    DayOfWeek eventDay, CustomTimeOfDay eventTime) {
  final now = DateTime.now();

  // Get the integer index for today's weekday (0=Mon, 1=Tue, ..., 6=Sun)
  // DateTime.weekday returns 1 for Monday, so we subtract 1.
  final todayWeekdayIndex = now.weekday - 1;

  // Get the integer index for the event's weekday.
  final eventWeekdayIndex = eventDay.index;

  // Calculate the difference in days to the next event.
  int daysToAdd = eventWeekdayIndex - todayWeekdayIndex;

  // If the calculated difference is negative, it means the day has already passed
  // this week, so we need to schedule it for the next week.
  // e.g., Today is Friday (4), event is on Monday (0). Difference = -4. Add 7 -> 3 days away.
  if (daysToAdd < 0) {
    daysToAdd += 7;
  }
  // If the event is on the same day of the week as today...
  else if (daysToAdd == 0) {
    // ...check if the event time has already passed today.
    final nowInMinutes = now.hour * 60 + now.minute;
    final eventTimeInMinutes = eventTime.hour * 60 + eventTime.minute;

    if (nowInMinutes >= eventTimeInMinutes) {
      // The time has passed, so schedule it for the same day next week.
      daysToAdd += 7;
    }
    // Otherwise, `daysToAdd` remains 0, and it's scheduled for later today.
  }

  // Calculate the target date by adding the calculated number of days.
  final targetDate = now.add(Duration(days: daysToAdd));

  // Return a new DateTime object with the correct date and the event's time.
  return DateTime(
    targetDate.year,
    targetDate.month,
    targetDate.day,
    eventTime.hour,
    eventTime.minute,
  );
}
