import '../models/report_model.dart';
import '../utils/date_time_utils.dart';

class ReportMapper {
  static SubmittedReport fromMap(Map<String, dynamic> map) {
    return SubmittedReport(
      id: map['id'] ?? '',
      reporter: ReportUser.fromMap(Map<String, dynamic>.from(map['reporter'] ?? {})),
      timestamp: DateTimeUtils.parse(map['timestamp']) ?? DateTime.now(),
      reportedContentId: map['reportedContentId'] ?? '',
      reportedContentType: map['reportedContentType'] ?? 'post',
      reportType: ReportTypeExtension.fromString(map['reportType'] ?? ''),
      description: map['description'] ?? '',
      contentSnippet: map['contentSnippet'] as String?,
      status: ReportStatusExtension.fromString(map['status'] ?? ''),
      resolutionNotes: map['resolutionNotes'] as String?,
      forwardedToAdminTimestamp: DateTimeUtils.parse(map['forwardedToAdminTimestamp']),
      forwardedBy: map['forwardedBy'] != null
          ? ReportUser.fromMap(Map<String, dynamic>.from(map['forwardedBy']))
          : null,
      forwardingNotes: map['forwardingNotes'] as String?,
      courseCode: map['courseCode'] as String?,
    );
  }

  static Map<String, dynamic> toFirestore(SubmittedReport report) {
    return {
      'id': report.id,
      'reporter': {
        'id': report.reporter.id,
        'name': report.reporter.name,
      },
      'timestamp': report.timestamp, // DateTime
      'reportedContentId': report.reportedContentId,
      'reportedContentType': report.reportedContentType,
      'reportType': report.reportType.name,
      'description': report.description,
      if (report.contentSnippet != null) 'contentSnippet': report.contentSnippet,
      'status': report.status.name,
      if (report.resolutionNotes != null) 'resolutionNotes': report.resolutionNotes,
      if (report.forwardedToAdminTimestamp != null) 'forwardedToAdminTimestamp': report.forwardedToAdminTimestamp, // DateTime
      if (report.forwardedBy != null)
        'forwardedBy': {
          'id': report.forwardedBy!.id,
          'name': report.forwardedBy!.name,
        },
      if (report.forwardingNotes != null) 'forwardingNotes': report.forwardingNotes,
      if (report.courseCode != null) 'courseCode': report.courseCode,
    };
  }

  static Map<String, dynamic> toMap(SubmittedReport report) {
    return {
      'id': report.id,
      'reporter': {
        'id': report.reporter.id,
        'name': report.reporter.name,
      },
      'timestamp': report.timestamp.toIso8601String(), // String
      'reportedContentId': report.reportedContentId,
      'reportedContentType': report.reportedContentType,
      'reportType': report.reportType.name,
      'description': report.description,
      if (report.contentSnippet != null) 'contentSnippet': report.contentSnippet,
      'status': report.status.name,
      if (report.resolutionNotes != null) 'resolutionNotes': report.resolutionNotes,
      if (report.forwardedToAdminTimestamp != null)
        'forwardedToAdminTimestamp': report.forwardedToAdminTimestamp!.toIso8601String(), // String
      if (report.forwardedBy != null)
        'forwardedBy': {
          'id': report.forwardedBy!.id,
          'name': report.forwardedBy!.name,
        },
      if (report.forwardingNotes != null) 'forwardingNotes': report.forwardingNotes,
      if (report.courseCode != null) 'courseCode': report.courseCode,
    };
  }
}
