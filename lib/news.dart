import 'package:flutter/material.dart';
import 'package:news_app/Article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class News{


    List<Article> news = [];

    Future<void> getNews() async{
        String newsApi = "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=7c07df0406db445e91dd1679d964a5b8";
        var response = await http.get(Uri.parse(newsApi));
        var data = jsonDecode(response.body);
        if(data['status'] == "ok"){
            print('ok');
            data["articles"].forEach((x){
                if(x['description'] != null && x['urlToImage'] != null && x['url'] != null && x['title'] != null && x['content'] != null){
                    Article article = new Article(title: x['title'], url: x['url'], description: x['description'], urlToImage: x['urlToImage'], content: x['content']);
                    news.add(article);
                }
            });

            print('Hello');
        }
    }

}