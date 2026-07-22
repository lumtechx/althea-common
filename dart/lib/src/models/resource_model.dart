import 'dart:convert';
import 'dart:io';
import 'base_resource.dart';
import '../mappers/resource_mapper.dart';

class ClassResource extends Resource {
  final String type;
  final UserDetail uploader;
  final String courseCode;

  ClassResource({
    required this.uploader,
    required super.fileType,
    required this.courseCode,
    required super.url,
    super.fileId,
    super.size,
    required super.id,
    required super.name,
    required super.tag,
    required this.type,
    required super.uploadDate,
    super.thumbnailUrl,
  });

  factory ClassResource.fromMap(Map<String, dynamic> map) {
    return ResourceMapper.classResourceFromMap(map);
  }

  Map<String, dynamic> toMap() {
    return ResourceMapper.classResourceToMap(this);
  }

  Map<String, dynamic> toFirestore() {
    return ResourceMapper.classResourceToFirestore(this);
  }

  static List<String> allTags = [
    'Slide',
    'Past Question',
    'Note',
    "Link & Video"
  ];
  static List<String> allTypes = ['Peer Contributions', 'Official Resources'];

  static bool isLinkType(String? tag) {
    return tag == 'Link & Video';
  }

  @override
  bool get fileIsLinkType => isLinkType(tag);
}

class UserDetail {
  final String uploadedById;
  final String uploadedBy;
  final List<String>? roles;
  final String? profilePicUrl;

  UserDetail({
    required this.uploadedBy,
    required this.uploadedById,
    required this.roles,
    this.profilePicUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uploadedById': uploadedById,
      'uploadedBy': uploadedBy,
      'profilePicUrl': profilePicUrl,
      'roles': roles,
    };
  }

  factory UserDetail.fromMap(Map<String, dynamic> map) {
    return UserDetail(
      uploadedById: map['uploadedById'],
      uploadedBy: map['uploadedBy'],
      profilePicUrl: map['profilePicUrl'],
      roles: map['roles'] != null ? List<String>.from(map['roles']) : null,
    );
  }

  UserDetail copyWith({String? uploadedBy}) {
    return UserDetail(
      uploadedBy: uploadedBy ?? this.uploadedBy,
      uploadedById: uploadedById,
      roles: roles,
    );
  }
}

class UploadMaterialData {
  final String uploadType;
  final String materialTag;
  final String displayName;
  final String? url;
  final File? file;

  UploadMaterialData({
    required this.uploadType,
    required this.materialTag,
    required this.displayName,
    this.url,
    this.file,
  });

  String stringify(String courseCode, String url, String? path) {
    return jsonEncode({
      'tag': materialTag,
      'type': uploadType,
      'url': url,
      'path': path,
      'name': displayName,
      'courseCode': courseCode,
    });
  }
}

class ResourcesFilter {
  String type = 'All';
  List<String> tags = [];
  String? searchQuery;
  UserDetail? uploadedBy;
  String? action;

  ResourcesFilter({
    this.searchQuery,
    this.uploadedBy,
    List<String>? tags,
    String? type,
    this.action,
  }) {
    this.tags = tags ?? [];
    this.type = type ?? 'All';
  }

  bool get hasFilters =>
      type != 'All' ||
      tags.isNotEmpty ||
      (searchQuery != null && searchQuery!.isNotEmpty) ||
      uploadedBy != null;

  ResourcesFilter copyWith({
    String? type,
    List<String>? tags,
    String? searchQuery,
    UserDetail? uploadedBy,
    String? action,
  }) {
    return ResourcesFilter(
      type: type ?? this.type,
      tags: tags ?? this.tags,
      searchQuery: searchQuery ?? this.searchQuery,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      action: action ?? this.action,
    );
  }

  void clear() {
    action = null;
    type = 'All';
    searchQuery = null;
    tags.clear();
    uploadedBy = null;
  }

  void removeTag(String tag) => tags.remove(tag);

  void addTag(String tag) {
    tags.add(tag);
  }

  factory ResourcesFilter.fromMap(Map<String, dynamic> map) {
    return ResourcesFilter(
      type: map['type'],
      tags: List<String>.from(map['tags'] ?? []),
      action: map['action'],
      searchQuery: map['searchQuery'],
      uploadedBy: map['uploadedById'] == null
          ? null
          : UserDetail(
              roles: List.empty(),
              uploadedBy: map['uploadedBy'] ?? 'User',
              uploadedById: map['uploadedById']!,
            ),
    );
  }

  List<ClassResource> filterResources(List<ClassResource> resources) {
    List<ClassResource> filteredResources = resources;

    if (!typeisNull) {
      filteredResources = filteredResources.where((resource) {
        return resource.type == type;
      }).toList();
    }
    if (tags.isNotEmpty) {
      filteredResources = filteredResources.where((resource) {
        return tags.contains(resource.tag);
      }).toList();
    }
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      filteredResources = filteredResources.where((resource) {
        return resource.name.toLowerCase().contains(searchQuery!);
      }).toList();
    }
    if (uploadedBy != null) {
      filteredResources = filteredResources.where((resource) {
        return resource.uploader.uploadedById == uploadedBy!.uploadedById;
      }).toList();
    }

    return filteredResources;
  }

  bool get typeisNull => type == 'All';

  final List<String> typeOptions = ['All', ...ClassResource.allTypes];
  final List<String> tagOptions = [...ClassResource.allTags, 'Other'];
}
