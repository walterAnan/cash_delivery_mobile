
import 'package:flutter/material.dart';
class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscureOldPassword = true;
  void _toggleOldPassword() {
    setState(() {
      _obscureOldPassword = !_obscureOldPassword;
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  //
  bool _obscureNewPassword = true;
  void _toggleNewPassword() {
    setState(() {
      _obscureNewPassword = !_obscureNewPassword;
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  //
  bool _obscureConfirmPassword = true;
  void _toggleConfirmPassword() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  TextEditingController oldPassword = new TextEditingController();
  TextEditingController newPassword = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();

  //Form Validation
  var _formKey = GlobalKey<FormState>();
  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
     Navigator.pop(context);
  }

  String validateOldPassword(String value) {
    final RegExp _passwordRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );
    print(value);
    if (value.isEmpty) {
      return 'Invalid password';
    } else if (value.length < 8) {
      return "Password should be between 8-20 characters";
    } else {
      if (!_passwordRegExp.hasMatch(value))
        return 'Use 8-20 characters from at least 2 categories:\nletters, numbers, special characters';
      else
        return null;
    }
  }

  String validateNewPassword(String value) {
    final RegExp _passwordRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );
    print(value);
    if (value.isEmpty) {
      return 'Invalid password';
    } else if (value.length < 8) {
      return "Password should be between 8-20 characters";
    } else {
      if (!_passwordRegExp.hasMatch(value))
        return 'Use 8-20 characters from at least 2 categories:\nletters, numbers, special characters';
      else
        return null;
    }
  }
  //
  String validateConfirmPassword(String value) {
    final RegExp _passwordRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );
    print(value);
    if (value.isEmpty) {
      return 'Invalid password';
    } else if (value.length < 8) {
      return "Password should be between 8-20 characters";
    } else if (!_passwordRegExp.hasMatch(value)) {
      return 'Use 8-20 characters from at least 2 categories:\nletters, numbers, special characters';
    }else {
      if(value != newPassword.text) {
        return 'Not Match';
      }
      else
        return null;
    }
  }

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
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
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
                          child: Text("Change Password",
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

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18,),
                    child: ListView(
                      children: [
                        SizedBox(height: 53,),
                        //Change your password
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Change your password",
                            style: TextStyle(
                              fontSize: 13.5,
                              fontFamily: "medium",
                              color: Theme.of(context).textTheme.headline1.color,
                            ),
                          ),
                        ),

                        SizedBox(height: 22,),

                        //Old Password Text Field
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Stack(
                            children: [
                              Positioned.directional(
                                  textDirection: Directionality.of(context),
                                start: 0,
                                  top: 0,
                                  child: Container(
                                  child: Text("Old Password",
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontFamily: 'medium',
                                      color: Theme.of(context).textTheme.headline1.color,
                                  ),),
                                   )
                                 ),
                              TextFormField(
                                obscureText: _obscureOldPassword,
                                controller: oldPassword,
                                keyboardType: TextInputType.visiblePassword,
                                validator: validateOldPassword,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 22),
                                  border: InputBorder.none,
                                  hintText: "Old Password",
                                  hintStyle: TextStyle(
                                    fontSize: 13.5,
                                    fontFamily: "regular",
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontFamily: "medium",
                                  color: Theme.of(context).textTheme.headline1.color,
                                ),
                              ),
                              Positioned.directional(
                                textDirection: Directionality.of(context),
                                end: -8,
                                top:14,
                                child:  InkWell(
                                  onTap: (){
                                    _toggleOldPassword();
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: _obscureOldPassword? Image.asset("assets/newIcons/ic_hide.png",
                                        scale: 3.2,color: Theme.of(context).accentTextTheme.headline1.color,
                                      ):Image.asset("assets/newIcons/ic_show.png",
                                          scale: 3.2,color: Theme.of(context).accentTextTheme.headline1.color
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //New Password Text Field
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Stack(
                            children: [
                              Positioned.directional(
                                  textDirection: Directionality.of(context),
                                  start: 0,
                                  top: 0,
                                  child: Container(
                                    child: Text("New Password",
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          fontFamily: 'medium',
                                        color: Theme.of(context).textTheme.headline1.color,
                                      ),),
                                  )
                              ),
                              TextFormField(
                                obscureText: _obscureNewPassword,
                                controller: newPassword,
                                keyboardType: TextInputType.visiblePassword,
                                validator: validateNewPassword,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 22),
                                  border: InputBorder.none,
                                  hintText: "New Password",
                                  hintStyle: TextStyle(
                                    fontSize: 13.5,
                                    fontFamily: "regular",
                                  ),
                                ),
                                style: TextStyle(
                                 fontSize: 13.5,
                                  fontFamily: "medium",
                                  color: Theme.of(context).textTheme.headline1.color,
                                ),
                              ),
                              Positioned.directional(
                                textDirection: Directionality.of(context),
                                end: -8,
                                top:14,
                                child:  InkWell(
                                  onTap: (){
                                    _toggleNewPassword();
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: _obscureNewPassword? Image.asset("assets/newIcons/ic_hide.png",
                                        scale: 3.2,color: Theme.of(context).accentTextTheme.headline1.color,
                                      ):Image.asset("assets/newIcons/ic_show.png",
                                          scale: 3.2,color:Theme.of(context).accentTextTheme.headline1.color,
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //Confirm Password Text Field
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Stack(
                            children: [
                              Positioned.directional(
                                  textDirection: Directionality.of(context),
                                  start: 0,
                                  top: 0,
                                  child: Container(
                                    child: Text("Confirm Password",
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          fontFamily: 'medium',
                                        color: Theme.of(context).textTheme.headline1.color,
                                      ),),
                                  )
                              ),
                              TextFormField(
                                obscureText: _obscureConfirmPassword,
                                controller: confirmPassword,
                                keyboardType: TextInputType.visiblePassword,
                                validator: validateConfirmPassword,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 22),
                                  border: InputBorder.none,
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(
                                    fontSize: 13.5,
                                    fontFamily: "regular",
                                  ),
                                ),
                                style: TextStyle(
                                 fontSize: 13.5,
                                  fontFamily: "medium",
                                  color: Theme.of(context).textTheme.headline1.color,
                                ),
                              ),
                              Positioned.directional(
                                textDirection: Directionality.of(context),
                                end: -8,
                                top:14,
                                child:  InkWell(
                                  onTap: (){
                                    _toggleConfirmPassword();
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: _obscureConfirmPassword? Image.asset("assets/newIcons/ic_hide.png",
                                        scale: 3.2,color: Theme.of(context).accentTextTheme.headline1.color,
                                      ):Image.asset("assets/newIcons/ic_show.png",
                                        scale: 3.2,color:Theme.of(context).accentTextTheme.headline1.color,
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //Change Password Button
                        Container(
                          padding: EdgeInsets.only(top: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  height: 44,
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    _submit();
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2)
                                  ),
                                  color:  Theme.of(context).accentTextTheme.headline1.color,
                                  elevation: 0,
                                  highlightElevation: 0,
                                  child: Text(
                                    "Change Password",
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
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
