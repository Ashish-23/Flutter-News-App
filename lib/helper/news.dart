import 'package:news_app/model/artical_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class News{
  List<ArticleModel> news = [];
  Future<void> getNews() async{
    String url='https://newsapi.org/v2/top-headlines?country=in&apiKey=09bfce6459d04d3c9bb7a512eeaf1737';
    //String url='http://newsapi.org/v2/everything?q=bitcoin&from=2020-12-05&sortBy=publishedAt&apiKey=09bfce6459d04d3c9bb7a512eeaf1737';

    var response= await http.get(url);
    var jsonData = jsonDecode(response.body);
    if(jsonData['status']== "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element['description']!=null){
          ArticleModel articalModel = ArticleModel(
             title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            //publishedAt: element["publishedAt"],
            content: element["content"],
          );
          
          news.add(articalModel);
        }
      });
    }
  }

}