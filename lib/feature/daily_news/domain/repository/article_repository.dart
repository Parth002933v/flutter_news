import 'package:flutter_news/core/resource/data_state.dart';
import 'package:flutter_news/feature/daily_news/data/models/article.dart';
import 'package:flutter_news/feature/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  Future<void> saveArticle(ArticleEntity articleModel);

  Future<List<ArticleModel>> getSavedArticles();

  deleteArticle(ArticleEntity articleModel);
}
