import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hand_signature/signature.dart';
class AddSignature extends StatefulWidget {
  @override
  _AddSignatureState createState() => _AddSignatureState();
}

class _AddSignatureState extends State<AddSignature> {
  HandSignatureControl control = new HandSignatureControl(
    threshold: 5.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  ValueNotifier<String> svg = ValueNotifier<String>(null);

  ValueNotifier<ByteData> rawImage = ValueNotifier<ByteData>(null);
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
                        child: Text("Add Signature",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'medium',
                            color: Theme.of(context).textTheme.headline1.color,
                          ),),
                      ),
                    ),
                  ],
                ),
              ),
              //
              Expanded(
                child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Stack(
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints.expand(),
                            color: Theme.of(context).accentTextTheme.bodyText2.color,
                            child: HandSignaturePainterView(
                              control: control,
                              width: 5,
                              type: SignatureDrawType.shape,
                                ),
                              ),
                            CustomPaint(
                              painter: DebugSignaturePainterCP(
                                control: control,
                                cp: false,
                                cpStart: false,
                                cpEnd: false,
                          ),
                        ),
                  ]
                )
               ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Container(
                  height: 115,
                  child: Column(
                    children: [
                      //Text field
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Theme.of(context).primaryTextTheme.headline3.color,
                            )
                          )
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder:InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              errorBorder:  InputBorder.none,
                              disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 12),
                            hintText: "Who signed for the delivery?",
                            hintStyle: TextStyle(
                              color: Theme.of(context).textTheme.headline3.color,
                              fontSize: 13,
                              fontFamily: "medium"
                            )
                          ),
                          style: TextStyle(
                              color: Theme.of(context).textTheme.headline1.color,
                              fontSize: 13,
                              fontFamily: "medium"
                          ),
                        ),
                      ),
                      Container(
                        height: 65,
                        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Reset
                            ButtonTheme(
                              height: 42,
                              minWidth: 100,
                              // ignore: deprecated_member_use
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    control.clear();
                                  });
                                },
                                elevation: 0,
                                highlightElevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  side: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).accentTextTheme.headline1.color,
                                  ),
                                ),
                               child: Text("Reset",
                               style: TextStyle(
                                 color: Theme.of(context).accentTextTheme.headline1.color,
                                 fontSize: 12,
                                 fontFamily: 'medium'
                               ),),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                                child: MaterialButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    height: 44,
                                  color: Theme.of(context).accentTextTheme.headline1.color,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2)
                                  ),
                                  elevation: 0,
                                  highlightElevation: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text("Submit",
                                        style: TextStyle(
                                          color: Theme.of(context).accentTextTheme.bodyText2.color,
                                          fontSize: 12,
                                          fontFamily: 'medium'
                                        ),),
                                      ),
                                      SizedBox(width: 5,),
                                      Image.asset("assets/newIcons/ic_forward.png",
                                        scale: 8,
                                        color: Theme.of(context).accentTextTheme.bodyText2.color,)
                                    ],
                                  ),
                                )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
