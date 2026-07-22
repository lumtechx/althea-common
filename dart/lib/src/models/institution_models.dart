import 'package:equatable/equatable.dart';
import '../mappers/onboarding_directory_mapper.dart';

class OnboardingDirectory extends Equatable {
  final Map<String, Institution> institutions;

  const OnboardingDirectory({required this.institutions});

  factory OnboardingDirectory.fromMap(Map<String, dynamic> map) {
    final institutionsList = parseCollection<Institution>(
      map['institutions'],
      (e) => Institution.fromMap(e),
    );
    final Map<String, Institution> instMap = {};

    for (final inst in institutionsList) {
      instMap[inst.id] = inst;
    }

    return OnboardingDirectory(institutions: instMap);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> instMap = {};
    institutions.forEach((key, val) {
      instMap[key] = val.toMap();
    });
    return {'institutions': instMap};
  }

  OnboardingDirectory copyWith({Map<String, Institution>? institutions}) {
    return OnboardingDirectory(
      institutions: institutions ?? this.institutions,
    );
  }

  OnboardingDirectory addInstitution(Institution institution) =>
      OnboardingDirectoryMapper.addInstitution(this, institution);

  OnboardingDirectory removeInstitution(String institutionId) =>
      OnboardingDirectoryMapper.removeInstitution(this, institutionId);

  OnboardingDirectory addCollege(String institutionId, College college) =>
      OnboardingDirectoryMapper.addCollege(this, institutionId, college);

  OnboardingDirectory removeCollege(String institutionId, String collegeId) =>
      OnboardingDirectoryMapper.removeCollege(this, institutionId, collegeId);

  OnboardingDirectory addProgramme(
          String institutionId, String collegeId, Programme programme) =>
      OnboardingDirectoryMapper.addProgramme(
          this, institutionId, collegeId, programme);

  OnboardingDirectory removeProgramme(
          String institutionId, String collegeId, String programmeId) =>
      OnboardingDirectoryMapper.removeProgramme(
          this, institutionId, collegeId, programmeId);

  OnboardingDirectory addYear(String institutionId, String collegeId,
          String programmeId, Level year) =>
      OnboardingDirectoryMapper.addYear(
          this, institutionId, collegeId, programmeId, year);

  OnboardingDirectory removeYear(String institutionId, String collegeId,
          String programmeId, String yearId) =>
      OnboardingDirectoryMapper.removeYear(
          this, institutionId, collegeId, programmeId, yearId);

  OnboardingDirectory removeYearById(String yearId) =>
      OnboardingDirectoryMapper.removeYearById(this, yearId);

  OnboardingDirectory addAcademicData({
    required Institution institution,
    required College college,
    required Programme programme,
    required Level year,
  }) =>
      OnboardingDirectoryMapper.addAcademicData(
        this,
        institution: institution,
        college: college,
        programme: programme,
        year: year,
      );

  OnboardingDirectory addSignUpData(SignUpData signUpData) =>
      OnboardingDirectoryMapper.addSignUpData(this, signUpData);

  ({
    Institution institution,
    College college,
    Programme programme,
    Level year,
  })? findYearLocation(String yearId) =>
      OnboardingDirectoryMapper.findYearLocation(this, yearId);

  OnboardingDirectory updateYearUserCount(String yearId, int userCount) =>
      OnboardingDirectoryMapper.updateYearUserCount(this, yearId, userCount);

  @override
  List<Object?> get props => [institutions];
}

class Institution extends Equatable {
  final String id;
  final String name;
  final String shortName;
  final String logoUrl;
  final String location;
  final List<String> acceptedEmailDomains;
  final String sections;
  final List<String> emailAccessInstructions;
  final List<College> colleges;

  const Institution({
    required this.id,
    required this.name,
    required this.shortName,
    required this.logoUrl,
    required this.location,
    required this.acceptedEmailDomains,
    required this.sections,
    required this.emailAccessInstructions,
    required this.colleges,
  });

  factory Institution.fromMap(Map<String, dynamic> map) {
    List<College> colList =
        parseCollection(map['colleges'], (e) => College.fromMap(e));
    return Institution(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      shortName: map['shortName'] as String? ?? '',
      logoUrl: map['logoUrl'] as String? ?? '',
      location: map['location'] as String? ?? '',
      acceptedEmailDomains:
          List<String>.from(map['acceptedEmailDomains'] ?? []),
      sections: map['sections'] as String? ?? '',
      emailAccessInstructions: List<String>.from(
        map['emailAccessInstructions'] ?? [],
      ),
      colleges: colList,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> colMap = {};
    for (final col in colleges) {
      colMap[col.id] = col.toMap();
    }
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
      'logoUrl': logoUrl,
      'location': location,
      'acceptedEmailDomains': acceptedEmailDomains,
      'sections': sections,
      'emailAccessInstructions': emailAccessInstructions,
      'colleges': colMap,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  Institution copyWith({
    String? id,
    String? name,
    String? shortName,
    String? logoUrl,
    String? location,
    List<String>? acceptedEmailDomains,
    String? sections,
    List<String>? emailAccessInstructions,
    List<College>? colleges,
  }) {
    return Institution(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      logoUrl: logoUrl ?? this.logoUrl,
      location: location ?? this.location,
      acceptedEmailDomains: acceptedEmailDomains ?? this.acceptedEmailDomains,
      sections: sections ?? this.sections,
      emailAccessInstructions:
          emailAccessInstructions ?? this.emailAccessInstructions,
      colleges: colleges ?? this.colleges,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        shortName,
        logoUrl,
        location,
        acceptedEmailDomains,
        sections,
        emailAccessInstructions,
        colleges,
      ];
}

class College extends Section {
  final List<Programme> programmes;

  College({
    required super.id,
    required super.name,
    required this.programmes,
  });

  factory College.fromMap(Map<String, dynamic> map) {
    List<Programme> progList =
        parseCollection(map['programmes'], (e) => Programme.fromMap(e));
    return College(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      programmes: progList,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> progMap = {};
    for (final prog in programmes) {
      progMap[prog.id] = prog.toMap();
    }
    return {
      'id': id,
      'name': name,
      'programmes': progMap,
    };
  }

  @override
  List<Object?> get props => [id, name, programmes];
}

class Programme extends Section {
  final int duration;
  final List<Level> years;

  Programme({
    required super.id,
    required super.name,
    required this.duration,
    required this.years,
  });

  factory Programme.fromMap(Map<String, dynamic> map) {
    final rawYears = map['years'];
    List<Level> yearList = [];
    if (rawYears is Map) {
      yearList = rawYears.values
          .map((e) => Level.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    } else if (rawYears is List) {
      yearList = rawYears
          .map((e) => Level.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    }

    return Programme(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      duration: map['duration'] as int? ?? 0,
      years: yearList,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> yrMap = {};
    for (final yr in years) {
      yrMap[yr.id] = yr.toMap();
    }
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'years': yrMap,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  @override
  List<Object?> get props => [id, name, duration, years];
}

class Level extends Section {
  final int? userCount;

  Level({
    required super.id,
    required super.name,
    this.userCount,
  });

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      userCount: map['userCount'] as int?,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      if (userCount != null) 'userCount': userCount,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  @override
  List<Object?> get props => [id, name, userCount];
}

sealed class Section extends Equatable {
  final String id;
  final String name;

  Section({required this.id, required this.name});

  Map<String, dynamic> toMap();

  @override
  List<Object?> get props => [id, name];
}

class SignUpData {
  Institution? institution;
  College? college;
  Programme? programme;
  Level? year;
  String? email;
  String? fullName;

  SignUpData({
    this.institution,
    this.college,
    this.programme,
    this.year,
    this.email,
    this.fullName,
  });

  SignUpData copyWith({
    Institution? institution,
    College? college,
    Programme? programme,
    Level? year,
    String? email,
    String? fullName,
  }) {
    return SignUpData(
      institution: institution ?? this.institution,
      college: college ?? this.college,
      programme: programme ?? this.programme,
      year: year ?? this.year,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'institution': institution?.toMap()?..remove('colleges'),
      'college': college?.toMap()?..remove('programmes'),
      'programme': programme?.toMap()?..remove('years'),
      'year': year?.toMap(),
      'email': email,
      'fullName': fullName,
    };
  }
}

List<T> parseCollection<T>(
  dynamic source,
  T Function(Map<String, dynamic>) parser,
) {
  if (source is Map) {
    return source.values
        .map((e) => parser(Map<String, dynamic>.from(e)))
        .toList();
  }

  if (source is List) {
    return source.map((e) => parser(Map<String, dynamic>.from(e))).toList();
  }

  return [];
}
