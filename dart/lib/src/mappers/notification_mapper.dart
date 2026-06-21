import '../models/notification_model.dart';
import '../utils/date_time_utils.dart';

class NotificationMapper {
  static AppNotification fromMap(
    Map<String, dynamic> map,
    bool isRead,
    NotificationType type,
  ) {
    return AppNotification(
      id: map['id'] as String? ?? '',
      message: map['message'] as String? ?? '',
      timestamp: DateTimeUtils.parse(map['timestamp']) ?? DateTime.now(),
      type: type,
      isRead: isRead,
      title: map['title'] as String? ?? '',
      snippet: map['snippet'] as String?,
      actions: map['actions'] == null
          ? null
          : (map['actions'] as List<dynamic>)
              .map((e) => NotificationAction.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  static Map<String, dynamic> toFirestore(AppNotification notification) {
    return {
      'id': notification.id,
      'message': notification.message,
      'timestamp': notification.timestamp, // DateTime
      'title': notification.title,
      if (notification.snippet != null) 'snippet': notification.snippet,
      if (notification.actions != null)
        'actions': notification.actions!.map((e) => e.toJson()).toList(),
    };
  }

  static Map<String, dynamic> toMap(AppNotification notification) {
    return {
      'id': notification.id,
      'message': notification.message,
      'timestamp': notification.timestamp.toIso8601String(), // String
      'title': notification.title,
      if (notification.snippet != null) 'snippet': notification.snippet,
      if (notification.actions != null)
        'actions': notification.actions!.map((e) => e.toJson()).toList(),
    };
  }
}
