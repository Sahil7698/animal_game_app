class Posts {
  final int id;
  final String title;
  final String thumbnailUrl;

  Posts({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory Posts.fromMap({required Map data}) {
    return Posts(
      id: data['id'],
      title: data['title'],
      thumbnailUrl: data['thumbnailUrl'],
    );
  }
}
