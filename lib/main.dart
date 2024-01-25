import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/Injection_container.dart';
import 'package:flutter_news/feature/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_news/feature/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_news/feature/daily_news/presentation/pages/home/daily_news.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialiseDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteArticleBloc>(
          create: (_) => sl()..add(GetArticleEvent()),
        ),
        BlocProvider<LocalArticleBloc>(
          create: (_) => sl(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter News',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DailyNews(),
      ),
    );
  }
}
