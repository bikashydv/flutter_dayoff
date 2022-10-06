import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dayoff/logic/auth.dart';
import 'package:dayoff/screens/dashboard/dash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController textController =
      TextEditingController(text: 'bikash@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: '1234567');

  AuthProvider auth = AuthProvider(FirebaseFirestore.instance);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(builder: (context, authprovider, _) {    
        if (authprovider.isLogedin == true) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            // Future.delayed(Duration(seconds: 2, )).then((value) {

            // Navigator.push(context, MaterialPageRoute(builder: (context) => DashPage()));
            if (authprovider.userModel != null &&
                authprovider.userModel?.company_id != null)
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          DashPage(authprovider.userModel!.company_id)),
                  (route) => false);

            // });
          });
        }
        if (authprovider.errorMessage != null) {
          final snackbar = SnackBar(content: Text(authprovider.errorMessage!));
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          });
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: TextFormField(
                  controller: textController,
                  //enaim
                  decoration: InputDecoration(
                    hintText: "email",
                    labelText: 'email',
                  ),
                ),
              ),
              Container(
                child: TextFormField(
                  controller: passwordController,
                  //password
                  decoration: InputDecoration(
                    hintText: "password",
                    labelText: 'password',
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    ///[Bikash]
                    ///login with email and password
                    ///email should come from email textformfield
                    ///password should come from password text field
                    ///
                    Provider.of<AuthProvider>(context, listen: false).logIn(
                      textController.text,
                      passwordController.text,
                    );

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => DashPage()))
                  },
                  child: Text('login')),
            ],
          ),
        );
      }),
    );
  }
}
