import 'package:crud_app/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void login() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      final String email = emailController.text;
      final String password = passwordController.text;

      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        final DocumentSnapshot snapshot =
            await db.collection("users").doc(user.user!.uid).get();
        final data = snapshot.data();
        Navigator.of(context).pushNamed("./home");
      } catch (e) {
        
        showDialog(context: context, builder: (context)=>
         AlertDialog(content: Text(e.toString()),)
         );

        print(e);
        
      }
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            // backgroundColor: Colors.black12,
            appBar: AppBar(
              elevation: 5,
              shadowColor: Colors.black87,
              backgroundColor: Colors.indigoAccent,
              leading: Icon(Icons.person_add),
              title: Text(
                'Sign In',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(children: [
                  SizedBox(
                    height: 160,
                  ),
                  Container(
                    width: 320,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        suffixIcon: Icon(
                          Icons.email,
                          color: Colors.indigo,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 320,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: Colors.indigo,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Container(
                      height: 50.0,
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: login,
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigoAccent,
                            padding: EdgeInsets.all(8),
                            fixedSize: Size(220, 90),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                      )),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.indigoAccent,
                      onSurface: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: const Text('Sign Up'),
                  )
                ]),
              ),
            )));
  }
}
