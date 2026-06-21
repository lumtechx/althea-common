class Institution {
  final String id;
  final String name;
  final String shortName;
  final String logoUrl;
  final String location;
  final List<String> acceptedEmailDomains;
  final String sections;
  final List<String> emailAccessInstructions;
  final List<College> colleges;

  factory Institution.fromMap(Map<String, dynamic> map) {
    return Institution(
      id: map['id'] as String,
      name: map['name'] as String,
      shortName: map['shortName'] as String,
      logoUrl: map['logoUrl'] as String,
      location: map['location'] as String,
      acceptedEmailDomains: List<String>.from(map['acceptedEmailDomains']),
      sections: map['sections'],
      emailAccessInstructions: List<String>.from(
        map['emailAccessInstructions'],
      ),
      colleges: List.from(
        (map['colleges']??{}).values.map((e) => College.fromMap(e)),
      ),
    );
  }

  Institution({
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
}

class College  extends Section{
  final List<Programme> programmes;
  College({required super.id, required super.name, required this.programmes});

  factory College.fromMap(Map<String, dynamic> map) {
    return College(id: map['id'] as String, name: map['name'] as String,
      programmes: List.from((map['programmes']??{}).values.map((e) => Programme.fromMap(e)))
    );
  }
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
    return Programme(
      id: map['id'] as String,
      name: map['name'] as String,
      duration: map['duration'] as int,
      years: Map<String, dynamic>.from(
        map['years'],
      ).values.map((e) => Level.fromMap(e)).toList(),
    );
  }


}

class Level extends Section {
  Level({required super.id, required super.name});

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(id: map['id'] as String, name: map['name'] as String);
  }
}

class Section {
  final String id;
  final String name;

  Section({required this.id, required this.name});

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(id: map['id'] as String, name: map['name'] as String);
  }


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


}
