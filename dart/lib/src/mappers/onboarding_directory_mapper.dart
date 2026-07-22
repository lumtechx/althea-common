import '../models/institution_models.dart';

class OnboardingDirectoryMapper {
  static OnboardingDirectory fromMap(Map<String, dynamic> map) {
    return OnboardingDirectory.fromMap(map);
  }

  static Map<String, dynamic> toMap(OnboardingDirectory directory) {
    return directory.toMap();
  }

  static Map<String, dynamic> toFirestore(OnboardingDirectory directory) {
    return directory.toMap();
  }

  /// Adds or updates an [Institution] in the directory.
  static OnboardingDirectory addInstitution(
    OnboardingDirectory directory,
    Institution institution,
  ) {
    final newInstitutions = Map<String, Institution>.from(directory.institutions);
    newInstitutions[institution.id] = institution;
    return directory.copyWith(institutions: newInstitutions);
  }

  /// Removes an [Institution] by ID.
  static OnboardingDirectory removeInstitution(
    OnboardingDirectory directory,
    String institutionId,
  ) {
    final newInstitutions = Map<String, Institution>.from(directory.institutions);
    newInstitutions.remove(institutionId);
    return directory.copyWith(institutions: newInstitutions);
  }

  /// Adds or updates a [College] under a specific institution ID.
  static OnboardingDirectory addCollege(
    OnboardingDirectory directory,
    String institutionId,
    College college,
  ) {
    final inst = directory.institutions[institutionId];
    if (inst == null) return directory;

    final updatedColleges = List<College>.from(inst.colleges);
    final index = updatedColleges.indexWhere((c) => c.id == college.id);
    if (index >= 0) {
      updatedColleges[index] = college;
    } else {
      updatedColleges.add(college);
    }

    final updatedInst = inst.copyWith(colleges: updatedColleges);
    return addInstitution(directory, updatedInst);
  }

  /// Removes a [College] by ID from a specific institution.
  static OnboardingDirectory removeCollege(
    OnboardingDirectory directory,
    String institutionId,
    String collegeId,
  ) {
    final inst = directory.institutions[institutionId];
    if (inst == null) return directory;

    final updatedColleges =
        inst.colleges.where((c) => c.id != collegeId).toList();
    final updatedInst = inst.copyWith(colleges: updatedColleges);
    return addInstitution(directory, updatedInst);
  }

  /// Adds or updates a [Programme] under a specific institution and college ID.
  static OnboardingDirectory addProgramme(
    OnboardingDirectory directory,
    String institutionId,
    String collegeId,
    Programme programme,
  ) {
    final inst = directory.institutions[institutionId];
    if (inst == null) return directory;

    final collegeIndex = inst.colleges.indexWhere((c) => c.id == collegeId);
    if (collegeIndex < 0) return directory;

    final college = inst.colleges[collegeIndex];
    final updatedProgrammes = List<Programme>.from(college.programmes);
    final progIndex = updatedProgrammes.indexWhere((p) => p.id == programme.id);
    if (progIndex >= 0) {
      updatedProgrammes[progIndex] = programme;
    } else {
      updatedProgrammes.add(programme);
    }

    final updatedCollege = College(
      id: college.id,
      name: college.name,
      programmes: updatedProgrammes,
    );

    return addCollege(directory, institutionId, updatedCollege);
  }

  /// Removes a [Programme] by ID from a specific college and institution.
  static OnboardingDirectory removeProgramme(
    OnboardingDirectory directory,
    String institutionId,
    String collegeId,
    String programmeId,
  ) {
    final inst = directory.institutions[institutionId];
    if (inst == null) return directory;

    final collegeIndex = inst.colleges.indexWhere((c) => c.id == collegeId);
    if (collegeIndex < 0) return directory;

    final college = inst.colleges[collegeIndex];
    final updatedProgrammes =
        college.programmes.where((p) => p.id != programmeId).toList();

    final updatedCollege = College(
      id: college.id,
      name: college.name,
      programmes: updatedProgrammes,
    );

    return addCollege(directory, institutionId, updatedCollege);
  }

  /// Adds or updates a year/level ([Level]) under a specific institution, college, and programme ID.
  static OnboardingDirectory addYear(
    OnboardingDirectory directory,
    String institutionId,
    String collegeId,
    String programmeId,
    Level year,
  ) {
    final inst = directory.institutions[institutionId];
    if (inst == null) return directory;

    final collegeIndex = inst.colleges.indexWhere((c) => c.id == collegeId);
    if (collegeIndex < 0) return directory;

    final college = inst.colleges[collegeIndex];
    final progIndex = college.programmes.indexWhere((p) => p.id == programmeId);
    if (progIndex < 0) return directory;

    final programme = college.programmes[progIndex];
    final updatedYears = List<Level>.from(programme.years);
    final yrIndex = updatedYears.indexWhere((y) => y.id == year.id);
    if (yrIndex >= 0) {
      updatedYears[yrIndex] = year;
    } else {
      updatedYears.add(year);
    }

    final updatedProgramme = Programme(
      id: programme.id,
      name: programme.name,
      duration: programme.duration,
      years: updatedYears,
    );

    return addProgramme(directory, institutionId, collegeId, updatedProgramme);
  }

  /// Removes a year/level by ID from a specific programme, college, and institution.
  static OnboardingDirectory removeYear(
    OnboardingDirectory directory,
    String institutionId,
    String collegeId,
    String programmeId,
    String yearId,
  ) {
    final inst = directory.institutions[institutionId];
    if (inst == null) return directory;

    final collegeIndex = inst.colleges.indexWhere((c) => c.id == collegeId);
    if (collegeIndex < 0) return directory;

    final college = inst.colleges[collegeIndex];
    final progIndex = college.programmes.indexWhere((p) => p.id == programmeId);
    if (progIndex < 0) return directory;

    final programme = college.programmes[progIndex];
    final updatedYears =
        programme.years.where((y) => y.id != yearId).toList();

    final updatedProgramme = Programme(
      id: programme.id,
      name: programme.name,
      duration: programme.duration,
      years: updatedYears,
    );

    return addProgramme(directory, institutionId, collegeId, updatedProgramme);
  }

  /// Intelligently searches for [yearId] across the entire directory and removes it.
  static OnboardingDirectory removeYearById(
    OnboardingDirectory directory,
    String yearId,
  ) {
    final loc = findYearLocation(directory, yearId);
    if (loc == null) return directory;
    return removeYear(
      directory,
      loc.institution.id,
      loc.college.id,
      loc.programme.id,
      yearId,
    );
  }

  /// Intelligently adds academic data hierarchy (institution, college, programme, year).
  /// If parent elements do not exist, they are created dynamically.
  static OnboardingDirectory addAcademicData(
    OnboardingDirectory directory, {
    required Institution institution,
    required College college,
    required Programme programme,
    required Level year,
  }) {
    final existingInst = directory.institutions[institution.id];

    if (existingInst == null) {
      final newProg = Programme(
        id: programme.id,
        name: programme.name,
        duration: programme.duration,
        years: [year],
      );
      final newCol = College(
        id: college.id,
        name: college.name,
        programmes: [newProg],
      );
      final newInst = institution.copyWith(colleges: [newCol]);
      return addInstitution(directory, newInst);
    }

    final existingCollege =
        existingInst.colleges.cast<College?>().firstWhere((c) => c?.id == college.id, orElse: () => null);

    if (existingCollege == null) {
      final newProg = Programme(
        id: programme.id,
        name: programme.name,
        duration: programme.duration,
        years: [year],
      );
      final newCol = College(
        id: college.id,
        name: college.name,
        programmes: [newProg],
      );
      return addCollege(directory, institution.id, newCol);
    }

    final existingProg =
        existingCollege.programmes.cast<Programme?>().firstWhere((p) => p?.id == programme.id, orElse: () => null);

    if (existingProg == null) {
      final newProg = Programme(
        id: programme.id,
        name: programme.name,
        duration: programme.duration,
        years: [year],
      );
      return addProgramme(directory, institution.id, college.id, newProg);
    }

    return addYear(directory, institution.id, college.id, programme.id, year);
  }

  /// Helper to add from [SignUpData] if all required academic fields are set.
  static OnboardingDirectory addSignUpData(
    OnboardingDirectory directory,
    SignUpData signUpData,
  ) {
    if (signUpData.institution == null ||
        signUpData.college == null ||
        signUpData.programme == null ||
        signUpData.year == null) {
      return directory;
    }
    return addAcademicData(
      directory,
      institution: signUpData.institution!,
      college: signUpData.college!,
      programme: signUpData.programme!,
      year: signUpData.year!,
    );
  }

  /// Intelligently finds the location of a year by its [yearId].
  static ({
    Institution institution,
    College college,
    Programme programme,
    Level year,
  })? findYearLocation(OnboardingDirectory directory, String yearId) {
    for (final inst in directory.institutions.values) {
      for (final col in inst.colleges) {
        for (final prog in col.programmes) {
          for (final yr in prog.years) {
            if (yr.id == yearId) {
              return (
                institution: inst,
                college: col,
                programme: prog,
                year: yr,
              );
            }
          }
        }
      }
    }
    return null;
  }

  /// Intelligently updates the [userCount] of a year by [yearId].
  static OnboardingDirectory updateYearUserCount(
    OnboardingDirectory directory,
    String yearId,
    int userCount,
  ) {
    final loc = findYearLocation(directory, yearId);
    if (loc == null) return directory;

    final updatedYear = Level(
      id: loc.year.id,
      name: loc.year.name,
      userCount: userCount,
    );

    return addYear(
      directory,
      loc.institution.id,
      loc.college.id,
      loc.programme.id,
      updatedYear,
    );
  }
}

typedef AppConfigMapper = OnboardingDirectoryMapper;
