import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:godelivery_rider/Ui/GetStarted.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'Theme/DarkThemeProvider.dart';
import 'Theme/ThemeStyle.dart';
import 'Ui/AddSignature.dart';
import 'Account/ChangeEmail.dart';
import 'Account/ChangeNumber.dart';
import 'Account/ChangePassword.dart';
import 'Ui/Chat.dart';
import 'Ui/CheckInternet.dart';
import 'Ui/Documents.dart';
import 'Ui/History.dart';
import 'Ui/Location.dart';
import 'Account/Login.dart';
import 'Ui/ManageVehicle.dart';
import 'package:http/http.dart' as http;
import 'Ui/MyDrawer.dart';
import 'Ui/MyOrders.dart';
import 'Ui/OrderDetails.dart';
import 'Ui/Profile.dart';
import 'Ui/RequiredDocuments.dart';
import 'Ui/SelectLanguage.dart';
import 'Ui/SelectVehicle.dart';
import 'Ui/Setting.dart';
import 'Ui/WebViewScreen.dart';
import 'Ui/UploadDocuments.dart';
import 'Account/OTPScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


const  MaterialColor myColor = const MaterialColor(
    0xFFF54D6E,
    const <int, Color>{
      50: const Color(0xFFF54D6E),
      100: const Color(0xFFF54D6E),
      200: const Color(0xFFF54D6E),
      300: const Color(0xFFF54D6E),
      400: const Color(0xFFF54D6E),
      500: const Color(0xFFF54D6E),
      600: const Color(0xFFF54D6E),
      700: const Color(0xFFF54D6E),
      800: const Color(0xFFF54D6E),
      900: const Color(0xFFF54D6E),
    }
);

 var tel;

//

void showNotification( v, flp) async {
  var android = AndroidNotificationDetails(
      'channel id', 'channel NAME',
      priority: Priority.high, importance: Importance.max);
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android: android, iOS: iOS);
  await flp.show(0, 'Virtual intelligent solution', '$v', platform,
      payload: 'VIS \n $v');
}


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Workmanager().initialize(callbackDispatcher, isInDebugMode: true); //to true if still in testing lev turn it to false whenever you are launching the app
  // String simplePeriodicTask;
  // await Workmanager().registerPeriodicTask("5", simplePeriodicTask,
  //     existingWorkPolicy: ExistingWorkPolicy.replace,
  //     frequency: Duration(minutes: 15),//when should it check the link
  //     initialDelay: Duration(seconds: 5),//duration before showing the notification
  //     constraints: Constraints(
  //       networkType: NetworkType.connected,
  //     ));
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  tel = sharedPreferences.get('tel');
  await Firebase.initializeApp();
  runApp(MyApp());
}



// void callbackDispatcher() {
//   Workmanager().executeTask((taskName, inputData) async {
//
//     FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
//     var android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     var iOS = IOSInitializationSettings();
//     var initSetttings = InitializationSettings(android: android, iOS: iOS);
//     flp.initialize(initSetttings);
//
//
//     var response= await http.post(Uri.parse('https://dev-cashdelivery.ventis.group/api/liste_livraison'));
//     print("here================");
//     print(response);
//     var convert = json.decode(response.body);
//     if (convert['status']  == true) {
//       showNotification(convert['msg'], flp,);
//     } else {
//       print("no messgae");
//     }
//
//     return Future.value(true);
//   });
// }

// This app is a stateful, it tracks the user's current choice.
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider(
      create: (_){
        return themeChangeProvider;
      },
      //builder: EasyLoading.init(),
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child){
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: value.darkTheme? Styles.dark : Styles.white,
            statusBarIconBrightness:value.darkTheme? Brightness.light : Brightness.dark,
            systemNavigationBarColor:value.darkTheme? Styles.dark : Styles.white,
            systemNavigationBarIconBrightness:value.darkTheme? Brightness.light : Brightness.dark,
          ));
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Cash Delivery",
            home: tel == null ? Login(): GetStarted(),
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            routes: <String, WidgetBuilder>{
              '/Login':    (BuildContext context)=>Login(),
              '/CheckInternet':    (BuildContext context)=>NoInternetScreen(),
              '/Location':    (BuildContext context)=>Location(),
              '/MyOrders':   (BuildContext context)=>MyOrders(),
              '/OrderDetails':    (BuildContext context)=>OrderDetails(),
              '/AddSignature':    (BuildContext context)=>AddSignature(),
              '/Chat':     (BuildContext context)=>Chat(),
              '/MyDrawer':    (BuildContext context)=>MyDrawer(),
              '/Profile':   (BuildContext context)=>Profile(),
              '/ChangeNumber':    (BuildContext context)=>ChangeNumber(),
              '/OTPScreen':    (BuildContext context)=>OTPScreen(),
              '/ChangeEmail':    (BuildContext context)=>ChangeEmail(),
              '/ManageVehicle':(BuildContext context)=>ManageVehicle(),
              '/SelectVehicle':(BuildContext context)=>SelectVehicle(),
              '/Documents':    (BuildContext context)=>Documents(),
              '/RequiredDocuments':    (BuildContext context)=>RequiredDocuments(),
              '/UploadDocuments':    (BuildContext context)=>UploadDocuments(),
              '/History':    (BuildContext context)=>History(),
              '/Setting':    (BuildContext context)=>Setting(),
              '/ChangePassword':    (BuildContext context)=>ChangePassword(),
              '/WebViewScreen':    (BuildContext context)=>WebViewScreen(),
              '/SelectLanguage':    (BuildContext context)=>SelectLanguage(),
            },
          );
        },
      ),
    );
  }

}
