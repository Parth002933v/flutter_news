import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/feature/daily_news/domain/entities/article.dart';
import 'package:flutter_news/feature/daily_news/domain/usecase/delete_article_usecase.dart';
import 'package:flutter_news/feature/daily_news/domain/usecase/get_saved_article_usecase.dart';
import 'package:flutter_news/feature/daily_news/domain/usecase/save_article_usecase.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'local_article_event.dart';
part 'local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticleUseCase _getSavedArticlesCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final DeleteArticleUseCase _deleteArticleUseCase;

  LocalArticleBloc(
    this._getSavedArticlesCase,
    this._saveArticleUseCase,
    this._deleteArticleUseCase,
  ) : super(LocalArticleLoading()) {
    on<GetSavedArticleEvent>(_onGetSavedArticles);
    on<LocalArticleSavedButtonClickedEvent>(_onToggaleArticles);
    // on<DeleteArticle>(_onDeleteArticle);
  }

  FutureOr<void> _onGetSavedArticles(
    GetSavedArticleEvent event,
    Emitter<LocalArticleState> emit,
  ) async {
    emit(LocalArticleLoading());

    final articles = await _getSavedArticlesCase.call();
    // final articles = state;

    emit(LocalArticleDone(articleEntitys: articles));
  }

  FutureOr<void> _onToggaleArticles(
    LocalArticleSavedButtonClickedEvent event,
    Emitter<LocalArticleState> emit,
  ) async {
    // emit(_LocalArticleLoading());

    // await _saveArticleUseCase.call(params: event.articleEntity);

    final articles = state;

    // final articles = await _getSavedArticlesCase.call();

    if (state.articleEntity!.contains(event.articleEntity!)) {
      emit(LocalArticleLoading());
      final articleEntity = event.articleEntity;

      await _deleteArticleUseCase.call(params: articleEntity);

      emit(LocalArticleDone(
          articleEntitys: List.from(articles.articleEntity!)
            ..remove(event.articleEntity!)));
    } else {
      emit(LocalArticleLoading());
      final articleEntity = event.articleEntity;
      await _saveArticleUseCase.call(params: articleEntity);

      emit(LocalArticleDone(
          articleEntitys: List.from(articles.articleEntity!)
            ..add(event.articleEntity!)));
    }
  }

  FutureOr<void> _onDeleteArticle(
    DeleteArticle event,
    Emitter<LocalArticleState> emit,
  ) async {
    // emit(_LocalArticleLoading());

    // await _deleteArticleUseCase.call(params: event.articleEntity);

    // final articles = await _getSavedArticlesCase.call();

    final articles = state;

    // emit(LocalArticleDone(
    //     List.from(articles.articleEntity!)..remove(event.articleEntity!)));
    // emit(LocalArticleDone(articles));
  }

  // @override
  // LocalArticleState? fromJson(Map<String, dynamic> json) =>
  //     LocalArticleState.fromMap(json);
  //
  // @override
  // Map<String, dynamic>? toJson(LocalArticleState state) => state.toMap();
}
