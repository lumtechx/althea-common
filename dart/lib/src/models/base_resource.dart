
import 'quiz_request.dart';

abstract class Resource {
  final String id;
  final String name;
  final DateTime uploadDate;
  final String fileType;
  final String? size;
  final String? fileId;
  final String? thumbnailUrl;
  final ResourceUrl url;
  final String tag;

  Resource({
    required this.fileType,
    required this.url,
    this.fileId,
    this.size,
    required this.id,
    required this.name,
    required this.uploadDate,
    this.thumbnailUrl,
      required this.tag,
  });

  SourceMaterial toSourceMaterial() {
    return SourceMaterial(
      id: id,
      name: name,
      url: url.url,
      type: fileType,
      fileId: fileId,
    );
  }

  bool get isPDF => fileType == "application/pdf";
  bool get fileIsLinkType;
}

sealed class ResourceUrl {
  const ResourceUrl();

  factory ResourceUrl.fromJson(dynamic json) {
    if (json is String) {
      return UrlString(json);
    } else if (json is Map<String, dynamic>) {
      return UrlObject(view: json['view'], download: json['download']);
    } else {
      throw ArgumentError("Invalid URL format");
    }
  }

  dynamic toJson();

  String get url;
}

class UrlString extends ResourceUrl {
  final String urlString;

  const UrlString(this.urlString);

  @override
  String toJson() => urlString;

  @override
  String get url => urlString;
}

class UrlObject extends ResourceUrl {
  final String view;
  final String download;

  const UrlObject({required this.view, required this.download});

  @override
  Map<String, dynamic> toJson() => {'view': view, 'download': download};

  @override
  String get url => download;
}