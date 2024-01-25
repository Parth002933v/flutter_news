import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_news/feature/daily_news/data/data_source/local/DAO/article_dao.dart';
import 'package:flutter_news/feature/daily_news/data/models/article.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase {
  ArticleModelDAO get articleModelDAO;
}
