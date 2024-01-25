import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/Injection_container.dart';
import 'package:flutter_news/feature/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_news/feature/daily_news/presentation/pages/article_detail/article_detail.dart';

class SavedArticles extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const SavedArticles());

  const SavedArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalArticleBloc>(
      create: (_) => sl()..add(GetSavedArticleEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_border),
            )
          ],
          centerTitle: true,
        ),
        body: BlocBuilder<LocalArticleBloc, LocalArticleState>(
          builder: (_, state) {
            if (state is LocalArticleLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LocalArticleDone) {
              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemCount: state.articleEntity!.length,
                itemBuilder: (context, index) {
                  final article = state.articleEntity![index];

                  return ListTile(
                    onTap: () => Navigator.of(context).push(
                      ArticleDetail.route(article),
                    ),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            key: UniqueKey(),
                            height: 180,
                            width: 120,
                            imageUrl: article.urlToImage ?? '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title!,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: 0,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                article.content ?? '',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  height: 0,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.auto_graph),
                                  Text(
                                    article.publishedAt!,
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
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        context
                            .read<LocalArticleBloc>()
                            .add(LocalArticleSavedButtonClickedEvent(article));
                      },
                      icon: const Icon(Icons.minimize),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
