import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/feature/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_news/feature/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:flutter_news/feature/daily_news/presentation/pages/saved_articles/saved_articles.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(SavedArticles.route());
            },
            icon: const Icon(Icons.bookmark_outlined),
          )
        ],
        centerTitle: true,
      ),
      body: BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (_, state) {
          if (state is RemoteArticleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RemoteArticleDone) {
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              itemCount: state.article!.length,
              itemBuilder: (context, index) {
                final article = state.article![index];

                return ListTile(
                  onTap: () => Navigator.of(context).push(
                    ArticleDetail.route(article),
                  ),
                  // leading: SizedBox(

                  //   // height: 200,
                  //   width: 100,
                  //   child: ,
                  // ),

                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          key: UniqueKey(),
                          height: 180,
                          width: 150,
                          imageUrl: article.urlToImage ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(width: 10),
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
                                  article.publishedAt! ?? '',
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
                );
              },
            );
          } else if (state is RemoteArticleError) {
            return Center(
              child: Column(
                children: [
                  Text(state.error!.response!.statusMessage!),
                  const Icon(Icons.refresh),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
