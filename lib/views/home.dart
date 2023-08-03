import 'package:daily_news/helper/news_data.dart';
import 'package:daily_news/views/category_page.dart';
import 'package:flutter/material.dart';

import '../helper/category_data.dart';
import '../model/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/news_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // get our categories list
  List<CategoryModel> category=[];

  // get our newlist first
  List<ArticleModel> article=[];
  bool _loading = true;

  getNews() async{
    News newsClass= News();
    await newsClass.getNews();
    article= newsClass.news;
    setState(() {
      _loading= false;
    });
  }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = getCategories();
    getNews();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Text("My" , style: TextStyle(
              color: Colors.blue
            ),),
            Text("NewsApp", style: TextStyle(
              color: Colors.black
            ),)
          ],
        ),
      ),
      body: _loading? Center(
        child: CircularProgressIndicator(

        ),
      )
        : SingleChildScrollView(
          child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children:<Widget> [
              /// Category model
                Container(
                  height: 70.0,
                  padding: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                    itemCount: category.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context, index){
                           return CategoryTile(
                               imageUrl: category[index].imageUrl,
                               categoryName: category[index].categoryName,
                           );
                      } ,
                  ),
                ),
                /// Blogmodel
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child:ListView.builder(
                    itemCount: article.length,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                         return BlogTile(
                              imageUrl: article[index].urlToImage,
                             title: article[index].title,
                             description: article[index].description,
                             //url: article[index].url

                         );

                      }
                  ) ,
                ),

              ],

            ),
          ),
        ),
      );
  }
}
class CategoryTile extends StatelessWidget {
  final String categoryName, imageUrl;
  const CategoryTile({required this.categoryName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) =>CategoryFragment(
                categories: categoryName.toLowerCase()) ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        child: Stack(
          children:<Widget> [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(imageUrl: imageUrl, width: 160, height: 90, fit: BoxFit.cover, )),
            Container(
              width: 160,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(categoryName, style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18
              ),),

            ),
          ],
        ),
      ),
    );
  }
}

// creating blog tile for news
  class BlogTile extends StatelessWidget {
  final String imageUrl, title, description   /*url*/;
    BlogTile({required this.imageUrl,required this.title,required this.description, /*required this.url*/});


    @override
    Widget build(BuildContext context) {
      return GestureDetector(

        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children: <Widget>[

              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 380,
                    height: 150,
                    fit: BoxFit.cover,
                  )),
           //for title
              SizedBox(height: 8,),
              Text(title, style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  color: Colors.black87
              ),),
            //for description
             SizedBox(height: 8,),
              Text(description, style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54),)
            ],
          ),
        ),
      );
    }
  }





