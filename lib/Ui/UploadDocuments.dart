import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
class UploadDocuments extends StatefulWidget {
  @override
  _UploadDocumentsState createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  File imageFile;
  var img;
  bool isSelectImg=false;
  openGallery() async{
    var imgePicker = new ImagePicker();
    var picture = await imgePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = picture as File;
      img = imageFile.path;
      isSelectImg=true;
    });
  }

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

          Expanded(
            child: ListView(
              children: [
                //Upload Document Image
                Container(
                  height: 130,
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  child: Center(
                      child: Image.asset("assets/newIcons/ic_upload_document.png",scale: 3.8,)
                  ),
                ),
                //Upload Documents Text Widget
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
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
                        padding: EdgeInsets.only(top: 4.5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Follow the instrucations you have received in\n"
                              "the email and upload it securely from here.",
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
                SizedBox(height: 14,),
                  //Add a File
                InkWell(
                  onTap: (){
                    openGallery();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: DottedBorder(
                      color: Theme.of(context).primaryTextTheme.headline3.color,
                      strokeWidth: 0.8,
                      dashPattern: [4, 3,],
                      borderType: BorderType.RRect,
                      radius: Radius.circular(5),
                      //padding: EdgeInsets.all(6),
                      child: Container(
                        height: 56,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/newIcons/ic_add_file.png",scale: 6,),
                            Container(
                              child: Text(" Add a file",
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.headline3.color,
                                  fontSize: 12,
                                  fontFamily: 'regular',
                                ),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                //
                ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount:1,
                    itemBuilder: (context,index){
                      return Visibility(
                        visible: isSelectImg,
                        child: Container(
                          height: 35,
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  //Image.asset("assets/newIcons/ic_select.png",width: 18,),
                                  SizedBox(width: 8,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.8-10,
                                    child: Text(img==null?"":img,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "medium",
                                          color: Theme.of(context).textTheme.headline1.color,
                                      ),),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    isSelectImg=false;
                                  });
                                },
                                  child: Image.asset("assets/newIcons/ic_delete.png",width: 18,)),
                            ],
                          ),
                        ),
                      );
                    }),

              ],
            ),
          )
          ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child://Submit for Review
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18,vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    height: 44,
                    onPressed: () {
                     Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)
                    ),
                    color: Theme.of(context).accentTextTheme.headline1.color,
                    elevation: 0,
                    highlightElevation: 0,
                    child: Text(
                      "Submit for Review",
                      style: TextStyle(
                          color: Theme.of(context).accentTextTheme.bodyText2.color,
                          fontSize: 14,
                          fontFamily: 'medium'
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
