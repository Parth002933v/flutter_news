import 'package:floor/floor.dart';
import 'package:flutter_news/feature/daily_news/domain/entities/article.dart';
import 'package:json_annotation/json_annotation.dart';
part 'article.g.dart';

@Entity(tableName: 'ArticleModel')
@JsonSerializable()
class ArticleModel extends ArticleEntity {
  @override
  const ArticleModel({
    // final int? id,
    final String? author,
    final String? title,
    final String? description,
    final String? url,
    final String? urlToImage,
    final String? publishedAt,
    final String? content,
  }) : super(
          // id: id,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  factory ArticleModel.fromEntity(ArticleEntity articlesEntity) => ArticleModel(
        // id: articlesEntity.id,
        content: articlesEntity.content,
        publishedAt: articlesEntity.publishedAt,
        urlToImage: articlesEntity.urlToImage,
        url: articlesEntity.url,
        description: articlesEntity.description,
        title: articlesEntity.title,
        author: articlesEntity.author,
      );
}
