part of 'local_article_bloc.dart';

@immutable
sealed class LocalArticleEvent {
  final ArticleEntity? articleEntity;

  const LocalArticleEvent({this.articleEntity});
}

class GetSavedArticleEvent extends LocalArticleEvent {}

class LocalArticleSavedButtonClickedEvent extends LocalArticleEvent {
  const LocalArticleSavedButtonClickedEvent(ArticleEntity articleEntity)
      : super(articleEntity: articleEntity);
}

class DeleteArticle extends LocalArticleEvent {
  const DeleteArticle(ArticleEntity articleEntity)
      : super(articleEntity: articleEntity);
}
