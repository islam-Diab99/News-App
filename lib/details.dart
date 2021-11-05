
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class Details extends StatefulWidget {
 final  String? Url;
   Details({Key? key, this.Url}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff2B2E44),
        title: Row(children: [


          Text('Flutter',style: TextStyle(color: Colors.white,fontSize: 25),),
          Text('News',style: TextStyle(color: Colors.yellow,fontSize: 25,fontWeight: FontWeight.bold),),

        ],
        ),
      ),
      body: SafeArea(
        child: WebviewScaffold(url: widget.Url!,
      scrollBar: true,


        initialChild:Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      )
          ,
      ),
    );
  }
}
