import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  @override
  Widget build(BuildContext context) {
     return  SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              //Appbar
              Container(
                height: 50,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    //back btn
                    Positioned.directional(
                      textDirection: Directionality.of(context),
                      start: 4,
                      top: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset("assets/newIcons/ic_back.png",width: 15,
                            color: Theme.of(context).iconTheme.color,),
                        ),
                      ),
                    ),
                    //Center Widget
                    Positioned.directional(
                      textDirection: Directionality.of(context),
                      top: 0,
                      bottom: 0,
                      start: 0,
                      end: 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("Jack Dorsey",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'medium',
                            color:  Theme.of(context).textTheme.headline1.color
                          ),),
                      ),
                    ),
                  ],
                ),
              ),
              //
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: ListView(
                    children: [
                      //resive
                      _buildResiver(context,"Hello I am John... I wanted to enwuire about a "
                          "product name Nivea Cream 3 lbs. is it available on your store.?",
                          "Sent : Oct 12, 2015"),
                      //Send
                     _buildSender(context, "Sorry it is unavailable at the moment\n\n\nCheers",
                         "Sent : Oct 12, 2015"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

     bottomNavigationBar: BottomAppBar(
       elevation: 0,
       child:  SingleChildScrollView(
         reverse: true,
         child: Column(
           children: [
             Container(
               height: 60,
               padding: EdgeInsets.symmetric(horizontal: 18.0),
               decoration: BoxDecoration(
                   border: Border(
                       top: BorderSide(
                           width: 1,
                           color: Theme.of(context).primaryTextTheme.headline3.color
                       )
                   )
               ),
               child: Row(
                 children: [
                   Expanded(
                     child: Container(
                         child: TextFormField(
                           decoration: InputDecoration(
                               border: InputBorder.none,
                               enabledBorder: InputBorder.none,
                               focusedBorder:InputBorder.none,
                               focusedErrorBorder: InputBorder.none,
                               errorBorder:  InputBorder.none,
                               disabledBorder: InputBorder.none,
                               hintText: "Write a message",
                               hintStyle: TextStyle(
                                 color: Theme.of(context).textTheme.headline3.color,
                                 fontFamily: "medium",
                                 fontSize: 14,
                               ),
                           ),
                           style:  TextStyle(
                             color: Theme.of(context).textTheme.headline1.color,
                             fontFamily: "medium",
                             fontSize: 14,
                           ),
                         )
                     ),
                   ),
                   Container(
                     child: Text("Send",
                       style: TextStyle(
                           fontSize: 14,
                           fontFamily: "medium",
                           color:  Theme.of(context).accentTextTheme.headline1.color
                       ),),
                   )
                 ],
               ),
             ),
             Padding(
                 padding: EdgeInsets.only(
                     bottom: MediaQuery.of(context).viewInsets.bottom
                 )
             )
           ],
         ),
       ),
     ),
      ),
    );
  }

}

Widget _buildSender(context,String sendText,String timeindicator) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //dp
        Container(
          child: CircleAvatar(
            radius: 22.0,
            backgroundImage: AssetImage("assets/images/jack.jpg",),
          ),
        ),
        SizedBox(width: 10.0,),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 16.0,right: 16.0,top: 10),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryTextTheme.headline5.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(sendText,
                    softWrap: true,
                    style: TextStyle(
                      color: Theme.of(context).accentTextTheme.bodyText1.color,
                      fontSize: 12,
                      fontFamily: "medium",
                    ),),
                ),
                //
                Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: Text(timeindicator,
                    style: TextStyle(
                      color:Theme.of(context).textTheme.headline3.color,
                      fontSize: 11,
                      fontFamily: "medium",
                    ),),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildResiver(context,sendText,String timeindicator) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16.0,right: 16.0,top: 10),
              decoration: BoxDecoration(
                  color:Theme.of(context).accentTextTheme.headline1.color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(sendText,
                      softWrap: true,
                      style: TextStyle(
                        color: Theme.of(context).accentTextTheme.bodyText2.color,
                        fontSize: 12,
                        fontFamily: "medium",
                      ),),
                  ),
                  //
                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(timeindicator,
                      style: TextStyle(
                        color: Theme.of(context).accentTextTheme.bodyText2.color.withOpacity(0.7),
                        fontSize: 11,
                        fontFamily: "medium",
                      ),),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.0,),
          //dp
          Container(
            child: CircleAvatar(
              radius: 22.0,
              backgroundImage: AssetImage("assets/images/john.jpg",),
            ),
          )
        ],
      ),
    );
}
