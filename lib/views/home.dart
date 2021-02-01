import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/model/artical_model.dart';
import 'package:news_app/model/categoryModel.dart';

import 'artical_views.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: deprecated_member_use
  List<CategoryModel> categories=new List<CategoryModel>();
  // ignore: deprecated_member_use
  List<ArticleModel> articles =new List<ArticleModel>();
  bool loading=true;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    categories=getCategories();
   getNews();
  }
  getNews()async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("World"),
            Text("News",style: TextStyle(color: Colors.blue),)
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: loading?Container(
        child: Center(child: CircularProgressIndicator()),
      ):SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [

              /// Categories
              Container(

                  height: 70,
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                  shrinkWrap: true,
                  itemBuilder:(context,index){
                  return CategoryTile(
                    imageUrl: categories[index].imageUrl,
                    categoryName: categories[index].categoryName,
                  );
                  }
              )),
              ///Blog
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: articles.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return BlogTile(imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                         url: articles[index].url,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children:<Widget> [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl,width: 120,height: 60,
              fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height:60,width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black45,
              ),

                child: Text(categoryName,style: TextStyle(color: Colors.white,fontSize:16,
                fontWeight: FontWeight.w500,
                ),)),
          ],
        ),
      ),
    );
  }
}
class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc, @required this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
           GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(blogUrl: url,)));
             },
             child: ClipRRect(
                 borderRadius: BorderRadius.circular(6),
                 child: Image.network(imageUrl)),
           ),
          SizedBox(height: 8,),
          Text(title,style: TextStyle(color: Colors.black87,fontSize: 17,fontWeight: FontWeight.w600),),
          SizedBox(height: 8,),
          Text(desc,style: TextStyle(color: Colors.black54,),),
        ],
      ),
    );
  }
}
