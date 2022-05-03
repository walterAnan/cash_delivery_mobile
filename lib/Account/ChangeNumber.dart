
import 'package:flutter/material.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'package:godelivery_rider/Account/OTPScreen.dart';
// ignore: must_be_immutable
class ChangeNumber extends StatefulWidget {
  var countryCode;
  ChangeNumber({this.countryCode});
  @override
  _ChangeNumberState createState() => _ChangeNumberState(countryCode);
}

class _ChangeNumberState extends State<ChangeNumber> {
  var countryCode;
  _ChangeNumberState(this.countryCode);
  final _numberController = TextEditingController();
  //Form Validation
  var _formKey = GlobalKey<FormState>();
  void validate(number) {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        //showProgressDialog();
      });
      print('Form is valid');
      //  doLogin(email, password);
      Navigator.push(context, SlidePageRoute(page: OTPScreen(senderText: senderText,)));

    } else {
      print('Form is invalid');
      setState(() {
        //dismissProgressDialog();
      });

    }
  }
  //Here, We have set 10 digits validation on mobile number.
  String validateMobile(String value) {
    if (value.length == 0) {
      return "Invalid phone no";
    }
    return null;
  }
  String senderText="Check your sms message we've sent you\n"
      "verification code at 3210000004";
  String phoneNumb;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Form(
            key: _formKey,
            child: Container(
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
                            child: Text("Change Number",
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
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18,),
                      child: ListView(
                        children: [
                          SizedBox(height: 65,),
                         //  What is your phone Number
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "What is your phone Number",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "medium",
                                  color:  Theme.of(context).textTheme.headline1.color
                              ),
                            ),
                          ),
                         //Please Confirm your country code........
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Please Confirm your country code and\nenter your phone number",
                              style: TextStyle(
                                color:  Theme.of(context).textTheme.headline3.color,
                                fontSize: 13,
                                fontFamily: 'medium',
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),

                          //Phone  Number
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 85,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color:  Theme.of(context).primaryTextTheme.headline3.color
                                          )
                                      )
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none, children: [
                                      Positioned.directional(
                                        textDirection: Directionality.of(context),
                                        start: 0,
                                        top: 0,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Country Code",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "medium",
                                                color:  Theme.of(context).textTheme.headline1.color
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned.directional(
                                          textDirection: Directionality.of(context),
                                        bottom: 7,
                                        child: Container(
                                          child: Text(countryCode==null?"":countryCode,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "medium",
                                                color:  Theme.of(context).textTheme.headline1.color
                                            ),),
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8,),
                                Expanded(
                                  child:  Container(
                                    child: Stack(
                                      children: [
                                        Positioned.directional(
                                          textDirection: Directionality.of(context),
                                          start: 0,
                                          top: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Mobile Number",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "medium",
                                                  color:  Theme.of(context).textTheme.headline1.color
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.phone,
                                          validator: validateMobile,
                                          onChanged: (val){
                                            setState(() {
                                              phoneNumb = val;
                                              senderText="Check your inbox we've sent you\n"
                                                  "verification code at $phoneNumb";
                                            });
                                          },
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(top: 10),
                                            border: InputBorder.none,
                                            hintText: "Enter Your Number",
                                            hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "medium",
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "medium",
                                              color:  Theme.of(context).textTheme.headline1.color
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Continue Button
                          Container(
                            padding: EdgeInsets.only(top: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    height: 44,
                                    onPressed: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      setState(() {
                                        if(_numberController.text.isNotEmpty) {
                                        }
                                        validate(_numberController.text.replaceAll("", ""),);
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2)
                                    ),
                                    color:  Theme.of(context).accentTextTheme.headline1.color,
                                    elevation: 0,
                                    highlightElevation: 0,
                                    child: Text(
                                      "Continue",
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
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
