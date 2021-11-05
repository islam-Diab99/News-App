

import 'package:flutter/material.dart';
import 'package:newsapp/Components/Category.dart';
import 'package:newsapp/Models.dart';
import 'package:newsapp/Service.dart';
import 'package:newsapp/details.dart';
Future<News>?futureArticle;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List photos=['images/Sports.png','images/general.jpg','images/markus-winkler-IrRbSND5EUc-unsplash.jpg','images/entertainment.png','images/health.jpg','images/science.jpg','images/tech.jpg'];
String countryCode='eg';
bool isVisible=false;


void initState() {
    // TODO: implement initState
    super.initState();
    NewsApi newsApi =NewsApi(category: 'Sports', country: 'eg');

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffff2B2E44),

      body:SafeArea(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(height: 10,),
            Row(

              children: [

              SizedBox(width: 20,),

              Text('Flutter',style: TextStyle(color: Colors.white,fontSize: 25),),
              Text('News',style: TextStyle(
                  color: Colors.yellow,fontSize: 25,fontWeight: FontWeight.bold,
              ),

              ),
              Spacer(),
              IconButton(onPressed:(){
                setState(() {
                  isVisible=!isVisible;
                  print('$isVisible');
                });
              }, icon: Icon(Icons.edit_location_rounded,
              color: Colors.white,
              size: 30,))

            ],
            ),
            Container(
              margin: EdgeInsets.only(right: 10,left: 10,top: 20),
              padding: EdgeInsets.symmetric(horizontal: 20,),
              width: 170,

              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.circular(50)
              ),

              child:
              DropdownButton<String>(


               dropdownColor: Colors.white,
                iconSize: 25,
                icon: Icon(Icons.keyboard_arrow_down_rounded,),
                underline: SizedBox(),

                hint: Text('Select Country'),

                items: <String>['Egypt', 'Brazil', 'France', 'Australia'].map((String value) {
                  return DropdownMenuItem<String>(

                    value: value,

                    child: Text(value),
                  );
                }).toList(),
                onChanged: (selectedCounty) {
                 setState(() {

                   countryCode=selectedCounty!.toLowerCase().substring(0,2);

                 });
                },



              ),
            ),

            // Container(
            //   margin: EdgeInsets.only(right: 10,left: 10,top: 20),
            //   padding: EdgeInsets.symmetric(horizontal: 20,),
            //
            //   decoration: BoxDecoration(
            //       color: Colors.white,
            //     borderRadius: BorderRadius.circular(50)
            //   ),
            //
            //   child: TextField(
            //
            //     textAlign: TextAlign.left,
            //     cursorColor: Color(0xffff2B2E44),
            //     style: TextStyle(fontSize: 20),
            //
            //     decoration: InputDecoration(
            //
            //       border: InputBorder.none,
            //       hintText: 'Country Code',
            //       hintStyle: TextStyle(fontSize: 20),
            //   ),
            // ),
            // ),
          Container(
            height: 120,
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: photos.length,
                  itemBuilder:(context,index)

                  {
                    return
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              selected=index;
                              chosenindex=index;
                            });

                          },
                          child: Column(
                            children: [

                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 32,
                                    backgroundImage: AssetImage(photos[index]),
                                  ),

                                  Container(
                                    width: 65,
                                    height: 65,


                                    decoration: BoxDecoration(
                                        color: selected==index?Colors.black54:Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: selected==index?Colors.pink:Colors.transparent,
                                            width: 2
                                        )



                                    ),

                                  )
                                ],
                              ),
                              SizedBox(height: 8,),
                              Text(categories[index],style: TextStyle(color: Colors.white,fontWeight:
                              selected==index?FontWeight.w900:FontWeight.normal ,
                                  fontSize: 15))
                            ],
                          ),
                        ),
                      );
                  }
              ),
            ),
          ),
            FutureBuilder(
              future:NewsApi(country:countryCode ,category:categories[chosenindex] ).fetchArticles() ,
              builder: (context,AsyncSnapshot<News> snapshot) {
               if(snapshot.connectionState==ConnectionState.done) {
                  if (snapshot.hasData) {

                    return Expanded(
                      flex: 5,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                snapshot.data!.articles![index].urlToImage ==
                                        null
                                    ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Details(
                                              Url: snapshot
                                                  .data!
                                                  .articles![index]
                                                  .url,
                                            )));
                                  },
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(7),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(13)),
                                            height: 200,
                                            width: double.infinity,
                                            child: Image(
                                                height: 200,
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                    'images/undraw_Asset_selection_re_k5fj.png')),
                                          ),
                                        ),
                                    )
                                    : InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Details(
                                                        Url: snapshot
                                                            .data!
                                                            .articles![index]
                                                            .url,
                                                      )));
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          child: Container(
                                              height: 200,
                                              width: double.infinity,
                                              child: Image(
                                                height: 200,
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  "${snapshot.data!.articles![index].urlToImage}",
                                                ),
                                              )),
                                        ),
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${snapshot.data!.articles![index].title}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: snapshot.data!.articles!.length,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                }

              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,

                ),
              );
            },

            ),
          ],
        ),
      ) ,




    );
  }
}
