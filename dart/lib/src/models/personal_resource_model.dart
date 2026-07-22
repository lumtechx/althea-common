import 'base_resource.dart';
import '../mappers/resource_mapper.dart';

class PersonalResource extends Resource {
  PersonalResource({
    required super.id,
    required super.name,
    required super.uploadDate,
    required super.fileType,
    super.size,
    super.fileId,
    super.thumbnailUrl,
    required super.url,
    required super.tag,
  });

  factory PersonalResource.fromMap(Map<String, dynamic> map) {
    return ResourceMapper.personalResourceFromMap(map);
  }

  @override
  bool get fileIsLinkType => tag == 'Link & Video';

  static List<String> allTags = ['File', 'Link & Video'];

  Map<String, dynamic> toMap() {
    return ResourceMapper.personalResourceToMap(this);
  }

  Map<String, dynamic> toFirestore() {
    return ResourceMapper.personalResourceToFirestore(this);
  }
}
