import '../models/post_models.dart';
import '../utils/date_time_utils.dart';

class PostMapper {
  static Post postFromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String? ?? '',
      timestamp: DateTimeUtils.parse(map['timestamp']) ?? DateTime.now(),
      content: PostContent(
        text: map['content']['text'] as String? ?? '',
        images: (map['content']['images'] as List<dynamic>?)
            ?.map(
              (e) => MediaContent(
                url: e['url'] as String? ?? '',
                hash: e['hash'] as String? ?? '',
              ),
            )
            .toList(),
        links: (map['content']['links'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
      ),
      author: PostUser(
        id: map['author']['id'] as String? ?? '',
        name: map['author']['name'] as String? ?? '',
        profilePicture: map['author']['profilePicture'] as String?,
      ),
      likeCount: map['likeCount'] as int? ?? 0,
      commentCount: map['commentCount'] as int? ?? 0,
      liked: map['liked'] as bool? ?? false,
      isSubscribed: map['isSubscribed'] as bool?,
    );
  }

  static Map<String, dynamic> postToFirestore(Post post) {
    return {
      'id': post.id,
      'timestamp': post.timestamp, // DateTime
      'content': {
        'text': post.content.text,
        if (post.content.images != null)
          'images': post.content.images!
              .map((e) => {'url': e.url, 'hash': e.hash})
              .toList(),
        if (post.content.links != null) 'links': post.content.links,
      },
      'author': {
        'id': post.author.id,
        'name': post.author.name,
        if (post.author.profilePicture != null)
          'profilePicture': post.author.profilePicture,
      },
      'likeCount': post.likeCount,
      'commentCount': post.commentCount,
      'liked': post.liked,
      'isSubscribed': post.isSubscribed,
    };
  }

  static Map<String, dynamic> postToMap(Post post) {
    return {
      'id': post.id,
      'timestamp': post.timestamp.toIso8601String(), // String
      'content': {
        'text': post.content.text,
        if (post.content.images != null)
          'images': post.content.images!
              .map((e) => {'url': e.url, 'hash': e.hash})
              .toList(),
        if (post.content.links != null) 'links': post.content.links,
      },
      'author': {
        'id': post.author.id,
        'name': post.author.name,
        if (post.author.profilePicture != null)
          'profilePicture': post.author.profilePicture,
      },
      'likeCount': post.likeCount,
      'commentCount': post.commentCount,
      'liked': post.liked,
      'isSubscribed': post.isSubscribed,
    };
  }

  static PostComment commentFromMap(Map<String, dynamic> map) {
    return PostComment(
      id: map['id'] as String? ?? '',
      postId: map['postId'] as String? ?? '',
      parentCommentId: map['parentCommentId'] as String?,
      timestamp: DateTimeUtils.parse(map['timestamp']) ?? DateTime.now(),
      content: PostContent(
        text: map['content']['text'] as String? ?? '',
        images: (map['content']['images'] as List<dynamic>?)
            ?.map(
              (e) => MediaContent(
                url: e['url'] as String? ?? '',
                hash: e['hash'] as String? ?? '',
              ),
            )
            .toList(),
        links: (map['content']['links'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
      ),
      author: PostUser(
        id: map['author']['id'] as String? ?? '',
        name: map['author']['name'] as String? ?? '',
        profilePicture: map['author']['profilePicture'] as String?,
      ),
      likeCount: map['likeCount'] as int? ?? 0,
      commentCount: (map['commentCount'] as int?) ?? 0,
      liked: map['liked'] as bool? ?? false,
      isSubscribed: map['isSubscribed'] as bool?,
    );
  }

  static Map<String, dynamic> commentToFirestore(PostComment comment) {
    return {
      'id': comment.id,
      'postId': comment.postId,
      if (comment.parentCommentId != null) 'parentCommentId': comment.parentCommentId,
      'timestamp': comment.timestamp, // DateTime
      'content': {
        'text': comment.content.text,
        if (comment.content.images != null)
          'images': comment.content.images!
              .map((e) => {'url': e.url, 'hash': e.hash})
              .toList(),
        if (comment.content.links != null) 'links': comment.content.links,
      },
      'author': {
        'id': comment.author.id,
        'name': comment.author.name,
        if (comment.author.profilePicture != null)
          'profilePicture': comment.author.profilePicture,
      },
      'likeCount': comment.likeCount,
      'commentCount': comment.commentCount,
      'liked': comment.liked,
      'isSubscribed': comment.isSubscribed,
    };
  }

  static Map<String, dynamic> commentToMap(PostComment comment) {
    return {
      'id': comment.id,
      'postId': comment.postId,
      if (comment.parentCommentId != null) 'parentCommentId': comment.parentCommentId,
      'timestamp': comment.timestamp.toIso8601String(), // String
      'content': {
        'text': comment.content.text,
        if (comment.content.images != null)
          'images': comment.content.images!
              .map((e) => {'url': e.url, 'hash': e.hash})
              .toList(),
        if (comment.content.links != null) 'links': comment.content.links,
      },
      'author': {
        'id': comment.author.id,
        'name': comment.author.name,
        if (comment.author.profilePicture != null)
          'profilePicture': comment.author.profilePicture,
      },
      'likeCount': comment.likeCount,
      'commentCount': comment.commentCount,
      'liked': comment.liked,
      'isSubscribed': comment.isSubscribed,
    };
  }
}
