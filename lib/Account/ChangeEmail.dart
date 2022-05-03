import 'package:flutter/material.dart';
import 'package:godelivery_rider/animation/SlidePageRoute.dart';
import 'package:godelivery_rider/Account/OTPScreen.dart';
class ChangeEmail extends StatefulWidget {
  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final _emailController = TextEditingController();
  //Form Validation
  var _formKey = GlobalKey<FormState>();
  void validate(email) {
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
  String email;
  String senderText;

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
                            child: Text("Change Email",
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
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18,),
                      child: ListView(
                        children: [
                          SizedBox(height: 65,),
                          //Enter Your Email Address
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Enter Your Email Address",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "medium",
                                color:  Theme.of(context).textTheme.headline1.color,
                              ),
                            ),
                          ),
                          //We'll send you verification code
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "We'll send you verification code",
                              style: TextStyle(
                                color:  Theme.of(context).textTheme.headline3.color,
                                fontSize: 13,
                                fontFamily: 'medium',
                              ),
                            ),
                          ),
                          SizedBox(height: 32,),
                          //Email field
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Stack(
                              children: [
                                Positioned.directional(
                                  textDirection: Directionality.of(context),
                                  start: 0,
                                  top: 0,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "medium",
                                        color:  Theme.of(context).textTheme.headline1.color,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (val) => RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(val.replaceAll(" ", "")) ? null :
                                    "Please input valid email",
                                    onChanged: (val){
                                     setState(() {
                                       email = val;
                                       senderText="Check your inbox we've sent you\n"
                                           "verification code at $email";
                                     });
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 15),
                                      border: InputBorder.none,
                                      hintText: "john@gmail.com",
                                      hintStyle: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "medium",
                                      ),

                                    ),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "medium",
                                      color:  Theme.of(context).textTheme.headline1.color,
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
                                        if(_emailController.text.isNotEmpty) {
                                        }
                                        validate(_emailController.text.replaceAll("", ""),);
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
