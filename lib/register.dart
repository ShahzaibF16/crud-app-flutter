import 'package:crud_app/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void register() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      final String username = usernameController.text;
      final String email = emailController.text;
      final String password = passwordController.text;

      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        var collectionPath = "users";
        await db
            .collection(collectionPath)
            .doc(user.user!.uid)
            .set({"email": email, "username": username});
        Navigator.of(context).pushNamed("./login");
        print("User is Registered");
      } catch (e) {
        print("Error");
      }
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            // backgroundColor: Colors.pinkAccent[100],
            appBar: AppBar(
              elevation: 5,
              shadowColor: Colors.pinkAccent,
              backgroundColor: Colors.pinkAccent,
              leading: Icon(Icons.person_add),
              title: Text(
                'Sign Up',
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
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        suffixIcon: Icon(
                          Icons.alternate_email,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 320,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        suffixIcon: Icon(
                          Icons.email,
                          color: Colors.green,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
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
                          color: Colors.purpleAccent,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Container(
                      height: 50.0,
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: register,
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pinkAccent,
                            padding: EdgeInsets.all(8),
                            fixedSize: Size(220, 90),
                            shadowColor: Colors.deepPurpleAccent,
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
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: const Text('Sign In'),
                  )
                ]),
              ),
            )));
  }
}
