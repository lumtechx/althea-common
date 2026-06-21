import '../models/banner_model.dart';

class EventItemMapper {
  static EventItem fromMap(Map<String, dynamic> map) {
    return EventItem(
      id: map['id'],
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
    );
  }

  static Map<String, dynamic> toMap(EventItem event) {
    return {
      'title': event.title,
      'imageUrl': event.imageUrl,
      'description': event.description,
      'id': event.id,
    };
  }
}
