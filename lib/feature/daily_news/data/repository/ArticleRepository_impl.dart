import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_news/core/constant/constant.dart';
import 'package:flutter_news/core/resource/data_state.dart';
import 'package:flutter_news/feature/daily_news/data/data_source/local/app_database.dart';
import 'package:flutter_news/feature/daily_news/data/data_source/remote/news_api_service.dart';
import 'package:flutter_news/feature/daily_news/data/models/article.dart';
import 'package:flutter_news/feature/daily_news/domain/entities/article.dart';
import 'package:flutter_news/feature/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsAPIService _newsAPIService;
  final AppDatabase _database;
  ArticleRepositoryImpl(this._newsAPIService, this._database);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final res = await _newsAPIService.getNewsArticles(
        country: AppConstant.countryQuery,
      );

      if (res.response.statusCode == HttpStatus.ok) {
        return DataSuccess(res.data);
      } else {
        return DataFailed(
          DioException(
            response: res.response,
            error: res.response.statusMessage,
            type: DioExceptionType.badResponse,
            requestOptions: res.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<void> saveArticle(ArticleEntity articlesEntity) async {
    final res = await _database.articleModelDAO
        .insertArticle(ArticleModel.fromEntity(articlesEntity));
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    final res = await _database.articleModelDAO.getArticles();
    return res;
  }

  @override
  deleteArticle(ArticleEntity articlesEntity) async {
    await _database.articleModelDAO
        .deleteArticle(ArticleModel.fromEntity(articlesEntity));
  }
}
