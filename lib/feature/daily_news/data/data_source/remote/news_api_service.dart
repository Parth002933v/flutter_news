import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_news/core/constant/constant.dart';
import 'package:flutter_news/feature/daily_news/data/models/article.dart';
import 'package:retrofit/retrofit.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: AppConstant.baseUrl)
abstract class NewsAPIService {
  factory NewsAPIService(Dio dio, {String baseUrl}) = _NewsAPIService;

  @GET("/top-headlines")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
    'x-api-key': AppConstant.apiKey,
  })
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query('country') String? country,
  });
}
