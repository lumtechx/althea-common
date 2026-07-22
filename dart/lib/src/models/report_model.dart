import '../mappers/report_mapper.dart';

/// Represents the type of issue being reported.
enum ReportType { spam, nudity, inappropriate, violation, systemError, other }

/// A helper extension to get user-friendly display names for the enum.
extension ReportTypeExtension on ReportType {
  String get displayName {
    switch (this) {
      case ReportType.spam:
        return 'Spam or Misleading';
      case ReportType.nudity:
        return 'Nudity or Sexual Content';
      case ReportType.inappropriate:
        return 'Inappropriate Content';
      case ReportType.violation:
        return 'Community Guideline Violation';
      case ReportType.systemError:
        return 'Technical Issue or Bug';
      case ReportType.other:
        return 'Other';
    }
  }

  static ReportType fromString(String val) {
    return ReportType.values.firstWhere(
          (e) => e.name == val,
      orElse: () => ReportType.other,
    );
  }
}

class ReportData {
  final ReportType type;
  final String description;

  ReportData({required this.type, required this.description});

  Map<String, dynamic> toMap(String contentSnippet) {
    return {
      'reportType': type.name,
      'description': description,
      'contentSnippet': contentSnippet,
    };
  }

  @override
  String toString() {
    return 'ReportData(type: ${type.name}, description: "$description")';
  }
}

// --- NEW ADDITIONS FOR FETCHING REPORTS ---

enum ReportStatus { pendingReview, resolved, forwardedToAdmin }

extension ReportStatusExtension on ReportStatus {
  String get displayName {
    switch (this) {
      case ReportStatus.pendingReview:
        return 'Pending Review';
      case ReportStatus.resolved:
        return 'Resolved';
      case ReportStatus.forwardedToAdmin:
        return 'Forwarded to Admin';
    }
  }

  static ReportStatus fromString(String val) {
    switch (val) {
      case 'Pending Review':
      case 'pendingReview':
        return ReportStatus.pendingReview;
      case 'Resolved':
      case 'resolved':
        return ReportStatus.resolved;
      case 'Forwarded to Admin':
      case 'forwardedToAdmin':
        return ReportStatus.forwardedToAdmin;
      default:
        return ReportStatus.pendingReview;
    }
  }
}

class ReportUser {
  final String id;
  final String name;

  ReportUser({required this.id, required this.name});

  factory ReportUser.fromMap(Map<String, dynamic> map) {
    return ReportUser(
      id: map['id'] ?? '',
      name: map['name'] ?? 'Unknown',
    );
  }
}

class SubmittedReport {
  final String id;
  final ReportUser reporter;
  final DateTime timestamp;
  final String reportedContentId;
  final String reportedContentType;
  final ReportType reportType;
  final String description;
  final String? contentSnippet;
  final ReportStatus status;
  final String? resolutionNotes;
  final DateTime? forwardedToAdminTimestamp;
  final ReportUser? forwardedBy;
  final String? forwardingNotes;
  final String? courseCode;

  SubmittedReport({
    required this.id,
    required this.reporter,
    required this.timestamp,
    required this.reportedContentId,
    required this.reportedContentType,
    required this.reportType,
    required this.description,
    this.contentSnippet,
    required this.status,
    this.resolutionNotes,
    this.forwardedToAdminTimestamp,
    this.forwardedBy,
    this.forwardingNotes,
    this.courseCode,
  });

  factory SubmittedReport.fromMap(Map<String, dynamic> map) {
    return ReportMapper.fromMap(map);
  }

  Map<String, dynamic> toMap() {
    return ReportMapper.toMap(this);
  }

  Map<String, dynamic> toFirestore() {
    return ReportMapper.toFirestore(this);
  }


  SubmittedReport copyWith({
    String? id,
    ReportUser? reporter,
    DateTime? timestamp,
    String? reportedContentId,
    String? reportedContentType,
    ReportType? reportType,
    String? description,
    String? contentSnippet,
    ReportStatus? status,
    String? resolutionNotes,
    DateTime? forwardedToAdminTimestamp,
    ReportUser? forwardedBy,
    String? forwardingNotes,
    String? courseCode,
  }) {
    return SubmittedReport(
      id: id ?? this.id,
      reporter: reporter ?? this.reporter,
      timestamp: timestamp ?? this.timestamp,
      reportedContentId: reportedContentId ?? this.reportedContentId,
      reportedContentType: reportedContentType ?? this.reportedContentType,
      reportType: reportType ?? this.reportType,
      description: description ?? this.description,
      contentSnippet: contentSnippet ?? this.contentSnippet,
      status: status ?? this.status,
      resolutionNotes: resolutionNotes ?? this.resolutionNotes,
      forwardedToAdminTimestamp:
          forwardedToAdminTimestamp ?? this.forwardedToAdminTimestamp,
      forwardedBy: forwardedBy ?? this.forwardedBy,
      forwardingNotes: forwardingNotes ?? this.forwardingNotes,
      courseCode: courseCode ?? this.courseCode,
    );
  }
}