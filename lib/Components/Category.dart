
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Service.dart';
int chosenindex=0;

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}
List categories=['Sports','general','business','entertainment','health','science','technology'];
int selected=0;
class _CategoryState extends State<Category> {
  List photos=['images/Sports.png','images/general.jpg','images/markus-winkler-IrRbSND5EUc-unsplash.jpg','images/entertainment.png','images/health.jpg','images/science.jpg','images/tech.jpg'];




  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
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
    );
  }
}
