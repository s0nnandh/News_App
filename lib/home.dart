import 'package:flutter/material.dart';
import 'package:news_app/Article.dart';
import 'package:news_app/Webviewer.dart';
import 'package:news_app/news.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool ok = false;
  List<Article> articles = [];

  @override
  void initState(){
    super.initState();
    getNews();
  }

  getNews() async {
    News news = new News();
    await news.getNews();
    articles = news.news;
    setState(() {
      ok = true;
    });
  }
  // url means Image url here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('News',style: TextStyle(color: Colors.blue),),
            Text('App'),
          ],
        ),
      ),
      body: !ok ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: articles.length,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context,index){
                  return Card(title: articles[index].title, url: articles[index].urlToImage, data: articles[index].description,link: articles[index].url,);
              }),
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String title,url,data,link;
  Card({required this.title,required this.url,required this.data,required this.link});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => NewsView(
              webUrl: link,
            )
        ));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.network(url),
            ),
            SizedBox(height: 8,),
            Text(title,style: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),),
            SizedBox(height: 8,),
            Text(data,style: TextStyle(
              color: Colors.grey[600],
            ),),
          ],
        ),
      ),
    );
  }
}

