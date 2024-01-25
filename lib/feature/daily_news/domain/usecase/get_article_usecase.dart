import 'package:flutter_news/core/resource/data_state.dart';
import 'package:flutter_news/core/usecase/usecase.dart';
import 'package:flutter_news/feature/daily_news/data/data_source/local/app_database.dart';
import 'package:flutter_news/feature/daily_news/domain/entities/article.dart';
import 'package:flutter_news/feature/daily_news/domain/repository/article_repository.dart';

class GetArticleUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) async {
    return await _articleRepository.getNewsArticles();
  }
}
