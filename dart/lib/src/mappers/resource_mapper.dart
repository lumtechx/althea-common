import '../models/resource_model.dart';
import '../models/personal_resource_model.dart';
import '../models/base_resource.dart';
import '../utils/date_time_utils.dart';

class ResourceMapper {
  static ClassResource classResourceFromMap(Map<String, dynamic> map) {
    return ClassResource(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      tag: map['tag'] as String? ?? '',
      type: map['type'] as String? ?? '',
      fileType: map['fileType'] as String? ?? '',
      uploader: UserDetail.fromMap(map['uploader']),
      uploadDate: DateTimeUtils.parse(map['uploadDate']) ?? DateTime.now(),
      courseCode: map['courseCode'] as String? ?? '',
      url: ResourceUrl.fromJson(map['url']),
      size: map['size'] as String?,
      thumbnailUrl: map['thumbnailUrl'] as String?,
      fileId: map['fileId'] as String?,
    );
  }

  static Map<String, dynamic> classResourceToFirestore(ClassResource resource) {
    return {
      'id': resource.id,
      'name': resource.name,
      'tag': resource.tag,
      'type': resource.type,
      'fileType': resource.fileType,
      'uploader': resource.uploader.toMap(),
      'uploadDate': resource.uploadDate,
      'courseCode': resource.courseCode,
      'url': resource.url.toJson(),
      if (resource.size != null) 'size': resource.size,
      if (resource.thumbnailUrl != null) 'thumbnailUrl': resource.thumbnailUrl,
      if (resource.fileId != null) 'fileId': resource.fileId,
    };
  }

  static Map<String, dynamic> classResourceToMap(ClassResource resource) {
    return {
      'id': resource.id,
      'name': resource.name,
      'tag': resource.tag,
      'type': resource.type,
      'fileType': resource.fileType,
      'uploader': resource.uploader.toMap(),
      'uploadDate': resource.uploadDate.toIso8601String(), // String
      'courseCode': resource.courseCode,
      'url': resource.url.toJson(),
      if (resource.size != null) 'size': resource.size,
      if (resource.thumbnailUrl != null) 'thumbnailUrl': resource.thumbnailUrl,
      if (resource.fileId != null) 'fileId': resource.fileId,
    };
  }

  static PersonalResource personalResourceFromMap(Map<String, dynamic> map) {
    return PersonalResource(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      uploadDate: DateTimeUtils.parse(map['uploadDate']) ?? DateTime.now(),
      fileType: map['fileType'] as String? ?? '',
      url: ResourceUrl.fromJson(map['url']),
      size: map['size'] as String?,
      thumbnailUrl: map['thumbnailUrl'] as String?,
      fileId: map['fileId'] as String?,
      tag: map['tag'] as String? ?? 'Personal Resource',
    );
  }

  static Map<String, dynamic> personalResourceToFirestore(PersonalResource resource) {
    return {
      'id': resource.id,
      'name': resource.name,
      'uploadDate': resource.uploadDate, // DateTime
      'fileType': resource.fileType,
      'url': resource.url.toJson(),
      if (resource.size != null) 'size': resource.size,
      if (resource.thumbnailUrl != null) 'thumbnailUrl': resource.thumbnailUrl,
      if (resource.fileId != null) 'fileId': resource.fileId,
      'tag': resource.tag,
    };
  }

  static Map<String, dynamic> personalResourceToMap(PersonalResource resource) {
    return {
      'id': resource.id,
      'name': resource.name,
      'uploadDate': resource.uploadDate.toIso8601String(), // String
      'fileType': resource.fileType,
      'url': resource.url.toJson(),
      if (resource.size != null) 'size': resource.size,
      if (resource.thumbnailUrl != null) 'thumbnailUrl': resource.thumbnailUrl,
      if (resource.fileId != null) 'fileId': resource.fileId,
      'tag': resource.tag,
    };
  }
}
