class Course {
  final String courseCode;
  final int courseCredit;
  final String courseName;
  final DateTime? lastAccessed;
  final String? lecturerName;
  final String? lecturerEmail;

  Course({
    required this.courseCode,
    required this.courseCredit,
    required this.courseName,
    this.lastAccessed,
    this.lecturerName,
    this.lecturerEmail,
  });
}
