import 'package:dio/dio.dart';
import 'package:news_app/models/ArticleModel.dart';
class NewsService {
  final Dio dio;
  NewsService(this.dio);
//return future string as api takes time can't save in respose object
  Future <List<ArticleModel>> getNews( String category)async{
    Response response =await dio.get('https://newsapi.org/v2/top-headlines?country=us&apiKey=d0d301119898410ab8767c0460afb6b9&category=$category');
    Map<String,dynamic> jsonData = response.data;
    List<dynamic> articles = jsonData['articles'];
    List<ArticleModel> articlesList =[];
    for(var a in articles) {
      ArticleModel articleModel = ArticleModel(
          image: a['urlToImage'] ,
          title: a['title'],
          subTitle: a['description'],
      );
      articlesList.add(articleModel);
    }
return articlesList;
  }


}