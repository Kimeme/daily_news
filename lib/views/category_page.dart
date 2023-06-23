import 'package:daily_news/views/home.dart';
import 'package:flutter/material.dart';
import 'package:daily_news/helper/news_data.dart';
import 'package:flutter/material.dart';

import '../helper/category_data.dart';
import '../model/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/news_model.dart';

 class CategoryFragment extends StatefulWidget {
   String categories;
    CategoryFragment({required this.categories});

   @override
   State<CategoryFragment> createState() => _CategoryFragmentState();
 }

 class _CategoryFragmentState extends State<CategoryFragment> {

   List<ArticleModel> article=[];

   getNews() async{
     CategoryNews newsClass= CategoryNews();
     await newsClass.getNews(widget.categories);
     article= newsClass.news;
   }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
             Text("News" , style: TextStyle(
                 color: Colors.blue
             ),),
             Text("App", style: TextStyle(
                 color: Colors.grey
             ),)
           ],
         ),
       ),
       body: SingleChildScrollView(
         child: Container(
                 child:ListView.builder(
                     itemCount: article.length,
                     physics: ClampingScrollPhysics(),
                     shrinkWrap: true,
                     itemBuilder: (context, index){
                       return BlogTile(
                           title: article[index].title,
                           description: article[index].description,
                           urlToImage: article[index].urlToImage
                       );

                     }
                 ) ,
               ),

           ),
         );
   }
 }

class BlogTile extends StatelessWidget {
  final String title, description , urlToImage;
  BlogTile({required this.title,required this.description, required this.urlToImage});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[

          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(imageUrl: urlToImage, width: 380, height: 200, fit: BoxFit.cover,)),
          SizedBox(height: 0,),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),),
          //for description
          SizedBox(height: 0,),
          Text(description, style: TextStyle( fontSize: 15.0, color: Colors.grey[800]),)
        ],
      ),
    );
  }
}
