import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class OTPScreen extends StatefulWidget {
  String senderText;
  OTPScreen({this.senderText});
  @override
  _OTPScreenState createState() => _OTPScreenState(senderText: senderText);
}

class _OTPScreenState extends State<OTPScreen> {
  String senderText;
  _OTPScreenState({this.senderText});
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();

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
                        focusColor: Colors.transparent,
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
                        child: Text("Verification Code",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'medium',
                            color:  Theme.of(context).textTheme.headline1.color,
                          ),),
                      ),
                    ),
                  ],
                ),
              ),
              //
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: ListView(
                    children: [
                      //Space
                      SizedBox(height: 60,),
                      //Verify phone number Text Widget
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter Verification Code",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "medium",
                            color:  Theme.of(context).textTheme.headline1.color,
                          ),
                        ),
                      ),
                      //Sign in Text Widget
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          senderText,
                          style: TextStyle(
                            color:  Theme.of(context).textTheme.headline3.color,
                            fontSize: 13,
                            fontFamily: 'medium',
                          ),
                        ),
                      ),
                      //Space
                      SizedBox(height: 15,),
                      //InPut fields
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //1st field
                            Expanded(
                              child: PinNumber(
                                textEditingController: _controller1,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            //2nd field
                            Expanded(
                              child: PinNumber(
                                textEditingController: _controller2,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            //3rd field
                            Expanded(
                              child: PinNumber(
                                textEditingController: _controller3,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            //4 field
                            Expanded(
                              child: PinNumber(
                                textEditingController: _controller4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Verify Code Button
                      Container(
                        padding: EdgeInsets.only(top: 14),
                        child: Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                height: 44,
                                onPressed: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  Navigator.popUntil(context, ModalRoute.withName("/profile"));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2)
                                ),
                                color:  Theme.of(context).accentTextTheme.headline1.color,
                                focusColor: Colors.transparent,
                                elevation: 0,
                                focusElevation: 0,
                                highlightElevation: 0,
                                child: Text(
                                  "Verify Code",
                                  style: TextStyle(
                                      color:  Theme.of(context).accentTextTheme.bodyText2.color,
                                      fontSize: 14,
                                      fontFamily: 'medium'
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
class PinNumber extends StatelessWidget {
  final TextEditingController  textEditingController;
  PinNumber({this.textEditingController});
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 100,
      child: TextFormField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        controller: textEditingController,
        maxLength: 1,
        keyboardType: TextInputType.number,
        onChanged: (_) {
          if(textEditingController.text.length==1){
            FocusScope.of(context).nextFocus();
          }
        },
        decoration:  InputDecoration(
            contentPadding: EdgeInsets.only(left: 10, right: 8, bottom: 45,top: 65),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: Color(0xFFFAFAFA)
                ),
                borderRadius: BorderRadius.circular(4)
            ),
            enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: Color(0xFFC2C2C2),
                ),
                borderRadius: BorderRadius.circular(4)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                  width: 1, color:  Theme.of(context).accentTextTheme.headline1.color,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Color(0xFFC2C2C2)
                ),
                borderRadius: BorderRadius.circular(4)
            ),
            errorBorder:  OutlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Color(0xFFC2C2C2)
                ),
                borderRadius: BorderRadius.circular(4)
            ),
            disabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Color(0xFFC2C2C2)
                ),
                borderRadius: BorderRadius.circular(4)
            ),
            isDense: true,
            helperStyle: TextStyle(color: Colors.transparent)
        ),
        style: TextStyle(fontSize: 28, fontFamily: 'bold',
            color:  Theme.of(context).textTheme.headline1.color,),
      ),
    );
  }
}