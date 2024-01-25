import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news/core/resource/data_state.dart';
import 'package:flutter_news/feature/daily_news/domain/entities/article.dart';
import 'package:flutter_news/feature/daily_news/domain/usecase/get_article_usecase.dart';
part 'remote_article_event.dart';
part 'remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticle;
  RemoteArticleBloc(this._getArticle) : super(const RemoteArticleLoading()) {
    on<GetArticleEvent>(_getArticleEvent);
  }

  FutureOr<void> _getArticleEvent(
      GetArticleEvent event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticle();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticleDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      print(dataState.error);
      emit(RemoteArticleError(dataState.error!));
    }
  }
}
