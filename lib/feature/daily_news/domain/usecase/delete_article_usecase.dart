import 'package:flutter_news/core/usecase/usecase.dart';
import 'package:flutter_news/feature/daily_news/domain/entities/article.dart';
import 'package:flutter_news/feature/daily_news/domain/repository/article_repository.dart';

class DeleteArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  DeleteArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) async {
    return _articleRepository.deleteArticle(params!);
  }
}
