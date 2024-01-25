part of 'remote_article_bloc.dart';

sealed class RemoteArticleEvent {
  const RemoteArticleEvent();
}

class GetArticleEvent extends RemoteArticleEvent {}
