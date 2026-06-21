import '../models/class_member_model.dart';

class ClassMemberMapper {
  static ClassMember fromMap(Map<String, dynamic> map) {
    return ClassMember(
      name: map['name']!,
      profilePicture: map['profilePicture'],
      roles: List<String>.from(map['roles'] ?? []),
    );
  }

  static Map<String, dynamic> toSuggestionMap(ClassMember member, String uid) {
    return {
      'id': uid,
      'display': member.name,
      'mention': member,
    };
  }
}
