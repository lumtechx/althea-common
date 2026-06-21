
enum CourseEventType {
  lecture,
  assignment,
  quiz,
  lab,
  meeting,
  deadline,
  tutorial,
  exams,
  other,
}

CourseEventType courseEventTypeFromString(String type) {
  switch (type) {
    case 'Lecture':
      return CourseEventType.lecture;
    case 'Assignment':
      return CourseEventType.assignment;
    case 'Quiz':
      return CourseEventType.quiz;
    case 'Meeting':
      return CourseEventType.meeting;
    case 'Deadline':
      return CourseEventType.deadline;
    case 'Tutorial':
      return CourseEventType.tutorial;
    case 'Exams':
      return CourseEventType.exams;
    case 'Lab':
      return CourseEventType.lab;
    default:
      return CourseEventType.other;
  }
}

String courseEventTypeToString(CourseEventType type) {
  String name = type.toString().split('.').last;
  return name[0].toUpperCase() + name.substring(1);
}

class Schedule {
  final String id;
  final CourseEventType type;
  final String? courseName;
  final String title;
  final DateTime dateTime;
  final DateTime? endTime;
  final String? location;
  final String? notes;

  Schedule({
    required this.id,
    required this.type,
    this.courseName,
    required this.title,
    required this.dateTime,
    this.endTime,
    this.location,
    this.notes,
  });



  Schedule copyWith({
    String? id,
    CourseEventType? type,
    String? courseName,
    String? title,
    DateTime? dateTime,
    DateTime? endTime,
    String? location,
    String? notes,
  }) {
    return Schedule(
      id: id ?? this.id,
      type: type ?? this.type,
      courseName: courseName ?? this.courseName,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      notes: notes ?? this.notes,
    );
  }
}
