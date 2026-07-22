import '../models/course_model.dart';
import '../utils/date_time_utils.dart';

class CourseMapper {
  static Course fromMap(Map<String, dynamic> map) {
    return Course(
      courseCode: map['courseCode'] as String,
      courseCredit: map['courseCredit'] as int,
      courseName: map['courseName'] as String,
      lastAccessed: DateTimeUtils.parse(map['lastAccessed']),
      lecturerName: map['lecturerName'] as String?,
      lecturerEmail: map['lecturerEmail'] as String?,
    );
  }

  static Map<String, dynamic> toFirestore(Course course) {
    return {
      'courseCode': course.courseCode.replaceAll(' ', ''),
      'courseCredit': course.courseCredit,
      'courseName': course.courseName,
      if (course.lastAccessed != null) 'lastAccessed': course.lastAccessed,
      if (course.lecturerName != null) 'lecturerName': course.lecturerName,
      if (course.lecturerEmail != null) 'lecturerEmail': course.lecturerEmail,
    };
  }

  static Map<String, dynamic> toMap(Course course) {
    return {
      'courseCode': course.courseCode.replaceAll(' ', ''),
      'courseCredit': course.courseCredit,
      'courseName': course.courseName,
      if (course.lastAccessed != null) 'lastAccessed': course.lastAccessed!.toIso8601String(),
      if (course.lecturerName != null) 'lecturerName': course.lecturerName,
      if (course.lecturerEmail != null) 'lecturerEmail': course.lecturerEmail,
    };
  }
}
