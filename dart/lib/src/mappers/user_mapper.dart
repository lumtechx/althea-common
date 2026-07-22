import '../models/resource_model.dart';
import '../models/user_model.dart';
import '../utils/date_time_utils.dart';

class UserMapper {
  static UserData fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'] as String? ?? '',
      email: map['email'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      createdAt: DateTimeUtils.parse(map['createdAt']) ?? DateTime.now(),
      updatedAt: DateTimeUtils.parse(map['updatedAt']) ?? DateTime.now(),
      profile: map['profile'] != null ? Profile.fromJson(map['profile']) : null,
      academic: Academic.fromJson(map['academic']),
      contact: map['contact'] != null ? Contact.fromJson(map['contact']) : null,
      status: UserStatusMapper.fromMap(map['status']),
    );
  }

  static UserDetail toUserDetail(ProfileBase user) {
    return UserDetail(
      uploadedBy: user.displayName,
      uploadedById: user.uid,
      roles: user.status.roles,
      profilePicUrl: user.profile?.profilePicture?.url,
    );
  }

  static Map<String, dynamic> toFirestore(UserData user) {
    return {
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'createdAt': user.createdAt, // DateTime
      'updatedAt': user.updatedAt, // DateTime
      'profile': user.profile?.toJson(),
      'academic': user.academic.toJson(),
      'contact': user.contact?.toJson(),
      'status': UserStatusMapper.toFirestore(user.status),
    };
  }

  static Map<String, dynamic> toMap(UserData user) {
    return {
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'createdAt': user.createdAt.toIso8601String(), // String
      'updatedAt': user.updatedAt.toIso8601String(), // String
      'profile': user.profile?.toJson(),
      'academic': user.academic.toJson(),
      'contact': user.contact?.toJson(),
      'status': UserStatusMapper.toMap(user.status),
    };
  }

  static UserProfileData profileDataFromMap(Map<String, dynamic> map) {
    return UserProfileData(
      uid: map['uid'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      academic: Academic.fromJson(map['academic']),
      status: UserStatusMapper.fromMap(map['status']),
      profile: map['profile'] != null ? Profile.fromJson(map['profile']) : null,
      contact: map['contact'] != null ? Contact.fromJson(map['contact']) : null,
    );
  }
}

class UserStatusMapper {
  static Status fromMap(Map<String, dynamic> map) {
    return Status(
      isVerified: map['isVerified'] as bool? ?? false,
      roles: List<String>.from(map['roles'] ?? []),
      lastSeen: DateTimeUtils.parse(map['lastSeen']),
      blockedUsers: map['blockedUsers'] != null
          ? (map['blockedUsers'] as Map<String, dynamic>).map(
              (key, value) =>
                  MapEntry(key, BlockedDataMapper.fromMap(value)),
            )
          : null,
    );
  }

  static Map<String, dynamic> toFirestore(Status status) {
    return {
      'isVerified': status.isVerified,
      'roles': status.roles,
      'lastSeen': status.lastSeen, // DateTime
      'blockedUsers': status.blockedUsers?.map(
        (key, value) => MapEntry(key, BlockedDataMapper.toFirestore(value)),
      ),
    };
  }

  static Map<String, dynamic> toMap(Status status) {
    return {
      'isVerified': status.isVerified,
      'roles': status.roles,
      'lastSeen': status.lastSeen?.toIso8601String(), // String
      'blockedUsers': status.blockedUsers?.map(
        (key, value) => MapEntry(key, BlockedDataMapper.toMap(value)),
      ),
    };
  }
}

class BlockedDataMapper {
  static BlockedData fromMap(Map<String, dynamic> map) {
    return BlockedData(
      blockedAt: DateTimeUtils.parse(map['blockedAt']),
      blocked: map['blocked'] as bool?,
    );
  }

  static Map<String, dynamic> toFirestore(BlockedData data) {
    return {
      'blocked': data.blocked,
      'blockedAt': data.blockedAt, // DateTime
    };
  }

  static Map<String, dynamic> toMap(BlockedData data) {
    return {
      'blocked': data.blocked,
      'blockedAt': data.blockedAt?.toIso8601String(), // String
    };
  }
}
