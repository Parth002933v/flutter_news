import 'package:floor/floor.dart';
import 'package:flutter_news/feature/daily_news/data/models/article.dart';

@dao
abstract class ArticleModelDAO {
  @insert
  Future<void> insertArticle(ArticleModel articleModel);

  @delete
  Future<void> deleteArticle(ArticleModel articleModel);

  @Query('SELECT * FROM ArticleModel')
  Future<List<ArticleModel>> getArticles();
}
