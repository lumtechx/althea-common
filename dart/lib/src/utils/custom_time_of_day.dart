import 'package:equatable/equatable.dart';

class CustomTimeOfDay extends Equatable {
  final int hour;
  final int minute;

  const CustomTimeOfDay({
    required this.hour,
    required this.minute,
  }) : assert(hour >= 0 && hour < 24),
       assert(minute >= 0 && minute < 60);

  factory CustomTimeOfDay.fromDateTime(DateTime dateTime) {
    return CustomTimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  factory CustomTimeOfDay.fromString(String timeString) {
    final parts = timeString.split(':');
    return CustomTimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  String toFormattedString() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  @override
  List<Object?> get props => [hour, minute];
}
