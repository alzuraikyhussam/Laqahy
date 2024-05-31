
class Post {
  final int? id;
  final String postTitle;
  final String postDescription;
  final dynamic postImage;
  final String? postPublishDate;

  Post({
    required this.postTitle,
    required this.postDescription,
    required this.postImage,
    this.postPublishDate,
    this.id,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      postTitle: json['post_title'] as String,
      postDescription: json['post_description'],
      postImage: json['image_url'] ,
      postPublishDate: json['post_publish_date'] as String,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'post_title': postTitle,
  //     'post_description': postDescription,
  //     'post_image': postImage?.path,
  //   };
  // }
}
