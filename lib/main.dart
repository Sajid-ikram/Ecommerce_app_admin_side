
import 'package:ecommerce_app_for_admin/categoryScreens/addNewProduct.dart';
import 'package:ecommerce_app_for_admin/helperProvider/drawerProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'LogIn/Authentication.dart';
import 'LogIn/SignIn.dart';
import 'LogIn/warningHelper.dart';
import 'helperProvider/screenProvider.dart';
import 'layouts/layout.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent,));
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => Warning()),
        ChangeNotifierProvider(create: (_) => DrawerProvider()),
        ChangeNotifierProvider(create: (_) => ScreenProvider()),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme:GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,

          ),
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color(0xff28292E),
        ),
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Exception(
                massage: "Error",
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return MiddleOfHomeAndSignIn();
            }

            return Exception(
              massage: "Loading",
            );
          },
        ),
        routes: {

          "addNewProduct": (ctx) => AddNewProduct(),

        },
      ),

    );

  }
}

class Exception extends StatelessWidget {
  const Exception({Key? key, required this.massage}) : super(key: key);
  final String massage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: massage == "Error"
            ? Text("An error occur")
            : CircularProgressIndicator(),
      ),
    );
  }
}

class MiddleOfHomeAndSignIn extends StatefulWidget {
  const MiddleOfHomeAndSignIn({Key? key}) : super(key: key);

  @override
  _MiddleOfHomeAndSignInState createState() => _MiddleOfHomeAndSignInState();
}

class _MiddleOfHomeAndSignInState extends State<MiddleOfHomeAndSignIn> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Provider.of<Authentication>(context).authStateChange,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(color: Color(0xffFCCFA8)),
          );
        }
        return snapshot.data == null ? SignIn() : SiteLayout();
      },
    );
  }
}
