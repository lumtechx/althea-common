import '../mappers/notification_mapper.dart';
enum NotificationType { personal, course }

class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  final String? snippet;
  final bool isRead;
  final List<NotificationAction>? actions;

  AppNotification({
    required this.id,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
    required this.title,
    this.snippet,
    this.actions,
  });

  factory AppNotification.fromMap(Map<String, dynamic> map, bool isRead,
      NotificationType type, DateTime? Function(dynamic value) dateParser) {
    return NotificationMapper.fromMap(map, isRead, type);
  }

  Map<String, dynamic> toMap() {
    return NotificationMapper.toMap(this);
  }

  Map<String, dynamic> toFirestore() {
    return NotificationMapper.toFirestore(this);
  }

  AppNotification copyWith({
    String? id,
    String? message,
    DateTime? timestamp,
    NotificationType? type,
    bool? isRead,
    String? title,
  }) {
    return AppNotification(
      id: id ?? this.id,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      title: title ?? this.title,
    );
  }
}

abstract class NotificationAction {
  const NotificationAction();

  factory NotificationAction.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final payload = json['payload'] as Map<String, dynamic>;

    switch (type) {
      case 'OPEN_URL':
        return OpenUrl.fromJson(payload);
      default:
        throw ArgumentError('Unknown NotificationAction type: $type');
    }
  }

  Map<String, dynamic> toJson();
}

class OpenUrl extends NotificationAction {
  final String url;

  OpenUrl({required this.url});

  factory OpenUrl.fromJson(Map<String, dynamic> json) {
    return OpenUrl(url: json['url'] as String);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'OPEN_URL',
      'payload': {'url': url},
    };
  }
}
