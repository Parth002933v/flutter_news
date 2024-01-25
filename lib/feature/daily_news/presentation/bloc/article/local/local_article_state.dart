part of 'local_article_bloc.dart';

abstract class LocalArticleState extends Equatable {
  final List<ArticleEntity>? articleEntity;
  const LocalArticleState({this.articleEntity = const []});

  @override
  List<Object?> get props => [articleEntity];
  //
  // Map<String, dynamic> toMap() {
  //   return {
  //     'articleEntity': articleEntity,
  //   };
  // }

  // factory LocalArticleState.fromMap(Map<String, dynamic> map) {
  //   return LocalArticleState(
  //     articleEntity: map['articleEntity'] as List<ArticleEntity>,
  //   );
  // }
}

class LocalArticleLoading extends LocalArticleState {}

class LocalArticleDone extends LocalArticleState {
  const LocalArticleDone({required List<ArticleEntity> articleEntitys})
      : super(articleEntity: articleEntitys);
}

// sealed class LocalArticleActionSate extends LocalArticleState {}

// class _LocalArticleSavedState extends LocalArticleActionSate {}

// class _LocalArticleRemovedState extends LocalArticleActionSate {}
