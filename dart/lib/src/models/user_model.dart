import 'institution_models.dart';
import 'resource_model.dart';
import 'package:equatable/equatable.dart';
import '../mappers/user_mapper.dart';

class UserData extends ProfileBase with EquatableMixin {
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserData({
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required super.uid,
    required super.displayName,
    required super.academic,
    required super.status,
    super.profile,
    super.contact,
  });

  factory UserData.fromJson(
      Map<String, dynamic> json, DateTime? Function(dynamic value) dateParser) {
    return UserMapper.fromMap(json);
  }

  Map<String, dynamic> toJson() {
    return UserMapper.toMap(this);
  }

  bool get isCourseRep => status.roles.contains('Course Representative');

  bool get isModerator => status.roles.contains('Moderator') || isCourseRep;

  UserData copyWith({
    String? uid,
    String? email,
    String? displayName,
    DateTime? createdAt,
    DateTime? updatedAt,
    Profile? profile,
    Academic? academic,
    Contact? contact,
    Status? status,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      profile: profile ?? this.profile,
      academic: academic ?? this.academic,
      contact: contact ?? this.contact,
      status: status ?? this.status,
    );
  }

  UserDetail toUserDetail() {
    return UserDetail(
      uploadedBy: displayName,
      uploadedById: uid,
      roles: status.roles,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        createdAt,
        updatedAt,
        profile,
        academic,
        contact,
        status,
      ];

  @override
  bool? get stringify => true;
}

class Profile extends Equatable {
  final String? username;
  final String? bio;
  final ProfilePicture? profilePicture;

  const Profile({this.username, this.bio, this.profilePicture});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      username: json['username'],
      bio: json['bio'],
      profilePicture: json['profilePicture'] != null
          ? ProfilePicture.fromJson(json['profilePicture'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'bio': bio,
        'profilePicture': profilePicture?.toJson(),
      };

  Profile copyWith({
    String? username,
    String? bio,
    ProfilePicture? profilePicture,
  }) {
    return Profile(
      username: username ?? this.username,
      bio: bio ?? this.bio,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  List<Object?> get props => [username, bio, profilePicture];
}

class ProfilePicture extends Equatable {
  final String url;
  final String? hash;
  final String? cloudId;

  const ProfilePicture({
    required this.url,
    this.hash,
    this.cloudId,
  });

  factory ProfilePicture.fromJson(Map<String, dynamic> json) {
    return ProfilePicture(
      url: json['url'] as String,
      hash: json['hash'] as String?,
      cloudId: json['cloudId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'hash': hash,
        'cloudId': cloudId,
      };

  ProfilePicture copyWith({
    String? url,
    String? hash,
    String? cloudId,
  }) {
    return ProfilePicture(
      url: url ?? this.url,
      hash: hash ?? this.hash,
      cloudId: cloudId ?? this.cloudId,
    );
  }

  @override
  List<Object?> get props => [url, hash, cloudId];
}

class Academic extends Equatable {
  final AcademicUnit institution;
  final AcademicUnit college;
  final AcademicUnit programme;
  final AcademicUnit year;

  const Academic({
    required this.institution,
    required this.college,
    required this.programme,
    required this.year,
  });

  factory Academic.fromJson(Map<String, dynamic> json) {
    return Academic(
      institution: AcademicUnit.fromJson(json['institution']),
      college: AcademicUnit.fromJson(json['college']),
      programme: AcademicUnit.fromJson(json['programme']),
      year: AcademicUnit.fromJson(json['year']),
    );
  }

  Map<String, dynamic> toJson() => {
        'institution': institution.toJson(),
        'college': college.toJson(),
        'programme': programme.toJson(),
        'year': year.toJson(),
      };

  static Academic fromSignUp(SignUpData s) {
    return Academic(
      institution: AcademicUnit(
        id: s.institution!.id,
        name: s.institution!.name,
      ),
      college: AcademicUnit(id: s.college!.id, name: s.college!.name),
      programme: AcademicUnit(id: s.programme!.id, name: s.programme!.name),
      year: AcademicUnit(id: s.year!.id, name: s.year!.name),
    );
  }

  Academic copyWith({
    AcademicUnit? institution,
    AcademicUnit? college,
    AcademicUnit? programme,
    AcademicUnit? year,
  }) {
    return Academic(
      institution: institution ?? this.institution,
      college: college ?? this.college,
      programme: programme ?? this.programme,
      year: year ?? this.year,
    );
  }

  String get topic => year.id;

  @override
  List<Object?> get props => [institution, college, programme, year];
}

class AcademicUnit extends Equatable {
  final String id;
  final String name;

  const AcademicUnit({required this.id, required this.name});

  factory AcademicUnit.fromJson(Map<String, dynamic> json) {
    return AcademicUnit(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  AcademicUnit copyWith({String? id, String? name}) {
    return AcademicUnit(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  List<Object?> get props => [id, name];
}

class Contact extends Equatable {
  final Socials? socials;

  const Contact({this.socials});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      socials:
          json['socials'] != null ? Socials.fromJson(json['socials']) : null,
    );
  }

  Map<String, dynamic> toJson() => {'socials': socials?.toJson()};

  Contact copyWith({Socials? socials}) {
    return Contact(socials: socials ?? this.socials);
  }

  @override
  List<Object?> get props => [socials];
}

class Socials extends Equatable {
  final String? linkedin;
  final String? github;
  final String? portfolio;

  const Socials({this.linkedin, this.github, this.portfolio});

  factory Socials.fromJson(Map<String, dynamic> json) {
    return Socials(
      linkedin: json['linkedin'],
      github: json['github'],
      portfolio: json['portfolio'],
    );
  }

  Map<String, dynamic> toJson() => {
        'linkedin': linkedin,
        'github': github,
        'portfolio': portfolio,
      };

  Socials copyWith({String? linkedin, String? github, String? portfolio}) {
    return Socials(
      linkedin: linkedin ?? this.linkedin,
      github: github ?? this.github,
      portfolio: portfolio ?? this.portfolio,
    );
  }

  @override
  List<Object?> get props => [linkedin, github, portfolio];
}

class Status extends Equatable {
  final bool isVerified;
  final List<String> roles;
  final DateTime? lastSeen;
  final Map<String, BlockedData>? blockedUsers;

  const Status({
    required this.isVerified,
    required this.roles,
    this.lastSeen,
    this.blockedUsers,
  });

  factory Status.fromJson(
      Map<String, dynamic> json, DateTime? Function(dynamic value) dateParser) {
    return UserStatusMapper.fromMap(json);
  }

  Map<String, dynamic> toJson() => UserStatusMapper.toMap(this);

  Status copyWith({
    bool? isVerified,
    List<String>? roles,
    DateTime? lastSeen,
    Map<String, BlockedData>? blockedUsers,
  }) {
    return Status(
      isVerified: isVerified ?? this.isVerified,
      roles: roles ?? this.roles,
      lastSeen: lastSeen ?? this.lastSeen,
      blockedUsers: blockedUsers ?? this.blockedUsers,
    );
  }

  @override
  List<Object?> get props => [isVerified, roles, lastSeen, blockedUsers];
}

class BlockedData extends Equatable {
  final bool? blocked;
  final DateTime? blockedAt;

  const BlockedData({required this.blockedAt, required this.blocked});

  factory BlockedData.fromJson(
      Map<String, dynamic> map, DateTime? Function(dynamic value) dateParser) {
    return BlockedDataMapper.fromMap(map);
  }

  Map<String, dynamic> toJson() => BlockedDataMapper.toMap(this);

  BlockedData copyWith({bool? blocked, DateTime? blockedAt}) {
    return BlockedData(
      blockedAt: blockedAt ?? this.blockedAt,
      blocked: blocked ?? this.blocked,
    );
  }

  @override
  List<Object?> get props => [blockedAt, blocked];
}

sealed class ProfileBase extends Equatable {
  final String uid;
  final String displayName;
  final Profile? profile;
  final Academic academic;
  final Contact? contact;
  final Status status;

  const ProfileBase({
    required this.uid,
    required this.displayName,
    this.profile,
    required this.academic,
    this.contact,
    required this.status,
  });

  @override
  List<Object?> get props => [
        uid,
        displayName,
        profile,
        academic,
        contact,
        status,
      ];
}

class UserProfileData extends ProfileBase with EquatableMixin {
  UserProfileData({
    required super.uid,
    required super.displayName,
    required super.academic,
    required super.status,
    super.profile,
    super.contact,
  });

  factory UserProfileData.fromJson(
      Map<String, dynamic> json, DateTime? Function(dynamic value) dateParser) {
    return UserMapper.profileDataFromMap(json);
  }
}
