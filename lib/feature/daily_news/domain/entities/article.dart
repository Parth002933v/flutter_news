import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  // final int? id;

  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleEntity({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    // this.id,
    // this.id,
  });

  @override
  List<Object?> get props =>
      [author, title, description, url, urlToImage, publishedAt, content];
}
