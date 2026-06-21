import 'package:equatable/equatable.dart';
import '../mappers/post_mapper.dart';

class MediaContent {
  final String url;
  final String hash;

  MediaContent({required this.url, required this.hash});
}

class PostUser extends Equatable {
  final String id;
  final String name;
  final String? profilePicture;

  const PostUser({required this.id, required this.name, this.profilePicture});
  @override
  List<Object?> get props => [id, name, profilePicture];
}

class PostContent extends Equatable {
  final String text;
  final List<MediaContent>? images;
  final List<String>? links;
  const PostContent({required this.text, this.images, this.links});
  @override
  List<Object?> get props => [text, images, links];
}

class Post extends FeedItem {
  const Post({
    required super.id,
    required super.timestamp,
    required super.content,
    required super.author,
    required super.likeCount,
    required super.commentCount,
    required super.isSubscribed,
    required super.liked,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return PostMapper.postFromMap(map);
  }

  Map<String, dynamic> toMap() {
    return PostMapper.postToMap(this);
  }

  Map<String, dynamic> toFirestore() {
    return PostMapper.postToFirestore(this);
  }

  Post copyWith({
    int? likeCount,
    int? commentCount,
    bool? liked,
    bool? isSubscribed,
  }) {
    return Post(
      id: id,
      timestamp: timestamp,
      content: content,
      author: author,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      liked: liked ?? this.liked,
      isSubscribed: isSubscribed ?? this.isSubscribed,
    );
  }
}

class PostComment extends FeedItem {
  final String postId;
  final String? parentCommentId;

  const PostComment({
    required this.postId,
    required this.parentCommentId,
    required super.id,
    required super.timestamp,
    required super.content,
    required super.author,
    required super.likeCount,
    required super.commentCount,
    required super.isSubscribed,
    required super.liked,
  });
  factory PostComment.fromMap(Map<String, dynamic> map) {
    return PostMapper.commentFromMap(map);
  }

  Map<String, dynamic> toMap() {
    return PostMapper.commentToMap(this);
  }

  Map<String, dynamic> toFirestore() {
    return PostMapper.commentToFirestore(this);
  }
  @override
  List<Object?> get props => [...super.props, postId, isSubscribed];

  PostComment copyWith({
    int? likeCount,
    int? commentCount,
    bool? liked,
    bool? isSubscribed,
  }) {
    return PostComment(
      id: id,
      postId: postId,
      parentCommentId: parentCommentId,
      timestamp: timestamp,
      content: content,
      author: author,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      liked: liked ?? this.liked,
      isSubscribed: isSubscribed ?? this.isSubscribed,
    );
  }
}

sealed class FeedItem extends Equatable {
  final String id;
  final DateTime timestamp;
  final PostContent content;
  final PostUser author;
  final int likeCount;
  final int commentCount;
  final bool liked;
  final bool? isSubscribed;

  const FeedItem({
    required this.id,
    required this.timestamp,
    required this.content,
    required this.author,
    required this.likeCount,
    required this.commentCount,
    required this.isSubscribed,
    required this.liked,
  });
  @override
  List<Object?> get props => [
    id,
    timestamp,
    content,
    author,
    likeCount,
    commentCount,
    liked,
    isSubscribed,
  ];
}
