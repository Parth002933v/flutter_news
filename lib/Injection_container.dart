import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_news/feature/daily_news/data/data_source/local/app_database.dart';
import 'package:flutter_news/feature/daily_news/data/data_source/remote/news_api_service.dart';
import 'package:flutter_news/feature/daily_news/data/repository/ArticleRepository_impl.dart';
import 'package:flutter_news/feature/daily_news/domain/repository/article_repository.dart';
import 'package:flutter_news/feature/daily_news/domain/usecase/delete_article_usecase.dart';
import 'package:flutter_news/feature/daily_news/domain/usecase/get_article_usecase.dart';
import 'package:flutter_news/feature/daily_news/domain/usecase/get_saved_article_usecase.dart';
import 'package:flutter_news/feature/daily_news/domain/usecase/save_article_usecase.dart';
import 'package:flutter_news/feature/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_news/feature/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> initialiseDependency() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  sl.registerSingleton<AppDatabase>(database);

  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<NewsAPIService>(NewsAPIService(sl()));

  // sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl2(sl()));
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  sl.registerSingleton<DeleteArticleUseCase>(DeleteArticleUseCase(sl()));

  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));

  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));

  sl.registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(sl()));
  sl.registerFactory<LocalArticleBloc>(
    () => LocalArticleBloc(sl(), sl(), sl()),
  );
}
