import 'package:flutter/material.dart';
// ignore: must_be_immutable
class SelectLanguage extends StatefulWidget {
  int index;
  SelectLanguage({this.index});
  @override
  _SelectLanguageState createState() => _SelectLanguageState(index: index);
}

class _SelectLanguageState extends State<SelectLanguage> {
  int index;
  int tapIndex;
  _SelectLanguageState({this.index});
  _selectedVal(int indx){
    if(index==null){
      setState(() {
        tapIndex=0;
      });
    }else if(index>=0){
      setState(() {
        tapIndex =index;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _selectedVal(tapIndex);
  }
  List _langList =[
    "English",
  ];
  Map<String,dynamic> _map={};
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
                      start: 0,
                      end: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("Select Language",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'medium',
                            color: Theme.of(context).textTheme.headline1.color,
                          ),),
                      ),
                    ),
                    //
                    Positioned.directional(
                      textDirection: Directionality.of(context),
                      end: 10,
                      top: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context,_map);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          child: Text("Done",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'medium',
                              color: Theme.of(context).textTheme.headline1.color,
                            ),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    child: Column(
                      children: List.generate(_langList.length, (i){
                        return InkWell(
                          onTap: (){
                            setState(() {
                              tapIndex  = i;
                              _map={
                                "langVal":_langList[i],
                                "index":i,
                              };
                            });
                          },
                          child: Container(
                            height: 55,
                            padding: EdgeInsets.symmetric(horizontal: 18,),
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
                                  child: Text(_langList[i],
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "medium",
                                      color: Theme.of(context).textTheme.headline1.color,
                                    ),),
                                ),
                                //
                                Container(
                                  child: tapIndex==i? Image.asset("assets/newIcons/ic_black_tick.png",
                                    scale: 4.2,
                                    color: Theme.of(context).textTheme.headline1.color,
                                  ):null,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
