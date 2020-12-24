import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:canteen_food_ordering_app/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:provider/provider.dart';
//import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/screen_navigation.dart';
//import '../helpers/style.dart';
import '../providers/user.dart';
import '../screens/registration.dart';
//import '../widgets/custom_text.dart';
//import '../widgets/loading.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  //User _user = new User();
  bool isSignedIn = false, showPassword = true;

  /* @override
  void initState() {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier, context);
    super.initState();
  }*/

  void toast(String data) {
    Fluttertoast.showToast(
        msg: data,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white);
  }

  /*void _submitForm() {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();
    final authProvider = Provider.of<UserProvider>(context);
    //AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    RegExp regExp = new RegExp(
        r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
    if (!regExp.hasMatch(_user.email)) {
      toast("Enter a valid Email ID");
    } else if (authProvider.password.length < 6) {
      toast("Password must have atleast 8 characters");
    } else {
      print("Success");
      //login(_user, authNotifier, context);
    }
  }*/

  Widget _buildLoginForm() {
    final authProvider = Provider.of<UserProvider>(context);
    return Column(
      children: <Widget>[
        SizedBox(
          height: 120,
        ),
        // Email Text Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: TextFormField(
            controller: authProvider.email,
            keyboardType: TextInputType.emailAddress,
            validator: (String value) {
              return null;
            },
            onSaved: (String value) {
              //_user.email = value;
            },
            cursorColor: Color.fromRGBO(255, 63, 111, 1),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Email',
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 63, 111, 1),
              ),
              icon: Icon(
                Icons.email,
                color: Color.fromRGBO(255, 63, 111, 1),
              ),
            ),
          ),
        ), //EMAIL TEXT FIELD
        SizedBox(
          height: 20,
        ),
        // Password Text Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: TextFormField(
            controller: authProvider.password,
            obscureText: showPassword,
            validator: (String value) {
              return null;
            },
            onSaved: (String value) {
              //_user.password = value;
            },
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Color.fromRGBO(255, 63, 111, 1),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    (showPassword) ? Icons.visibility_off : Icons.visibility,
                    color: Color.fromRGBO(255, 63, 111, 1),
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  }),
              border: InputBorder.none,
              hintText: 'Password',
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 63, 111, 1),
              ),
              icon: Icon(
                Icons.lock,
                color: Color.fromRGBO(255, 63, 111, 1),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Forgot Password Line
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            /*GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ForgotPasswordPage();
                  },
                ));
              },
              child: Container(
                child: Text(
                  'Reset here',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),*/
          ],
        ),
        SizedBox(
          height: 50,
        ),
        //LOGIN BUTTON
        GestureDetector(
          onTap: () async {
            if (!await authProvider.signIn()) {
              _key.currentState
                  .showSnackBar(SnackBar(content: Text("Login failed!")));
              return;
            }
            authProvider.clearController();
            changeScreenReplacement(context, MyHomePage());
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Log In",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(255, 63, 111, 1),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        // SignUp Line
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Not a registered user?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return RegistrationScreen(); //SignupPage();
                  },
                ));
              },
              child: Container(
                child: Text(
                  'Sign Up here',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 138, 120, 1),
              Color.fromRGBO(255, 114, 117, 1),
              Color.fromRGBO(255, 63, 111, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formkey,
          autovalidate: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(top: 60),
                    child: Text(
                      'Ready Wheels',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'MuseoModerno',
                      ),
                    ),
                  ),
                ),
                Text(
                  '',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 17,
                    color: Color.fromRGBO(252, 188, 126, 1),
                  ),
                ),
                _buildLoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
