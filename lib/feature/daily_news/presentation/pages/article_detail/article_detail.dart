import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/Injection_container.dart';
import 'package:flutter_news/feature/daily_news/domain/entities/article.dart';
import 'package:flutter_news/feature/daily_news/presentation/bloc/article/local/local_article_bloc.dart';

class ArticleDetail extends StatelessWidget {
  static route(ArticleEntity articleEntity) =>
      MaterialPageRoute(builder: (context) => ArticleDetail(articleEntity));

  final ArticleEntity _articleEntity;

  const ArticleDetail(this._articleEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Text(
                  _articleEntity.title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 0,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.watch_later_outlined),
                    const SizedBox(width: 10),
                    Text(
                      _articleEntity.publishedAt! ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        // fontWeight: FontWeight.bold,
                        // height: 0,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          CachedNetworkImage(
            height: 250,
            width: double.maxFinite,
            imageUrl: _articleEntity.urlToImage ?? '',
            fit: BoxFit.contain,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              _articleEntity.content ?? '',
              style: const TextStyle(
                // fontWeight: FontWeight.bold,
                height: 0,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<LocalArticleBloc, LocalArticleState>(
        builder: (_, state) {
          if (state is LocalArticleDone) {
            return FloatingActionButton(
              onPressed: () {
                context
                    .read<LocalArticleBloc>()
                    .add(LocalArticleSavedButtonClickedEvent(_articleEntity));
              },
              child: state.articleEntity!.contains(_articleEntity)
                  ? Icon(
                      Icons.bookmark_added_rounded,
                      size: 30,
                    )
                  : Icon(
                      Icons.bookmark_add_outlined,
                      size: 30,
                    ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
