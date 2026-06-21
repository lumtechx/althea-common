import 'dart:io';

class CreatePostData {
  final String textContent;
  final List<File> images;

  CreatePostData({required this.textContent, required this.images});
}
