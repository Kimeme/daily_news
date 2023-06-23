import 'dart:convert';

import 'package:http/http.dart';

import '../model/news_model.dart';
/// save json data inside thi
class News{
  List<ArticleModel> news=[];


  Future<void> getNews() async {
    var response = await get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e298abae11994dd1adafc915b850dc32'));

    var jsonData = jsonDecode(response.body);

    if(jsonData['status']== 'ok') {

      jsonData['articles'].forEach((element){

        if (element['urlToImage'] != null && element['description'] !=null) {

          ArticleModel articleModel=ArticleModel(
             // author: element['author'],
              title: element['title'],
              description: element['description'],
             // url: element['url'],
              urlToImage: element['urlToImage'],
             // publishedAt: element['publishedAt'],
             // content: element['content']
          );
          news.add(articleModel);
        }
      });
    }
  }
}
/// fetching news by categories
class CategoryNews{
  List<ArticleModel> news=[];


  Future<void> getNews(String categories) async {


    var response = await get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=$categories&apiKey=e298abae11994dd1adafc915b850dc32'));

    var jsonData = jsonDecode(response.body);

    if(jsonData['status']== 'ok') {

      jsonData['articles'].forEach((element){

        if (element['urlToImage'] != null && element['description'] !=null) {

          ArticleModel articleModel=ArticleModel(
             // author: element['author'],
              title: element['title'],
              description: element['description'],
              //url: element['url'],
              urlToImage: element['urlToImage'],
             // publishedAt: element['publishedAt'],
             // content: element['content']
          );
          news.add(articleModel);
        }
      });
    }
  }
}