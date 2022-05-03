import 'package:flutter/material.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';

import 'UploadDocuments.dart';
class RequiredDocuments extends StatefulWidget {
  @override
  _RequiredDocumentsState createState() => _RequiredDocumentsState();
}

class _RequiredDocumentsState extends State<RequiredDocuments> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              //Appbar
              Container(
                height: 50,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
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
                    )
                  ],
                ),
              ),
              //Document Image
              Container(
                height: 130,
                child: Center(
                    child: Image.asset("assets/newIcons/ic_document_id.png",scale: 1,)
                ),
              ),
            //Upload Documents Text Widget
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    //Upload Documents Text Widget
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Upload Documents",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "medium",
                          color: Theme.of(context).textTheme.headline1.color,
                        ),
                      ),
                    ),
                    //We need to see your name.............
                    Container(
                      padding: EdgeInsets.only(top: 4),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "We need to see your name clearly printed\non an official document.",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline3.color,
                          fontSize: 12,
                          fontFamily: 'regular',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),
              //Driving License
              InkWell(
                onTap: (){
                  Navigator.of(context).push(SlidePageRoute(page: UploadDocuments()));
                },
                child: Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 18,right: 18),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1,
                            color: Theme.of(context).primaryTextTheme.headline3.color,
                          )
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Driving License",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'medium',
                            color: Theme.of(context).textTheme.headline1.color,
                          ),),
                      ),
                      Image.asset("assets/newIcons/ic_forward.png",scale: 5.3,)
                    ],
                  ),
                ),
              ),
              //Vehicle Insurance
              InkWell(
                onTap: (){
                  Navigator.of(context).push(SlidePageRoute(page: UploadDocuments()));
                },
                child: Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 18,right: 18),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1,
                            color: Theme.of(context).primaryTextTheme.headline3.color,
                          )
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Vehicle Insurance",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'medium',
                            color: Theme.of(context).textTheme.headline1.color,
                          ),),
                      ),
                      Image.asset("assets/newIcons/ic_forward.png",scale: 5.3,)
                    ],
                  ),
                ),
              ),
              //Vehicle Registration
              InkWell(
                onTap: (){
                  Navigator.of(context).push(SlidePageRoute(page: UploadDocuments()));
                },
                child: Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 18,right: 18),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1,
                            color: Theme.of(context).primaryTextTheme.headline3.color,
                          )
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Vehicle Registration",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'medium',
                            color: Theme.of(context).textTheme.headline1.color,
                          ),),
                      ),
                      Image.asset("assets/newIcons/ic_forward.png",scale: 5.3,)
                    ],
                  ),
                ),
              ),
              //Nation ID/Passport
              InkWell(
                onTap: (){
                  Navigator.of(context).push(SlidePageRoute(page: UploadDocuments()));
                },
                child: Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 18,right: 18),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1,
                            color: Theme.of(context).primaryTextTheme.headline3.color,
                          )
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("National ID/Passport",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'medium',
                            color: Theme.of(context).textTheme.headline1.color,
                          ),),
                      ),
                      Image.asset("assets/newIcons/ic_forward.png",scale: 5.3,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
