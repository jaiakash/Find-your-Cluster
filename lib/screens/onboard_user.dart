import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_your_cluster/constants/routing_constants.dart';
import 'package:find_your_cluster/styles/text_field_decorator.dart';
import 'package:find_your_cluster/styles/text_style.dart';
import 'package:flutter/material.dart';

class OnboardUser extends StatefulWidget {
  const OnboardUser({super.key});
  @override
  State<OnboardUser> createState() => _OnboardUserState();
}

class _OnboardUserState extends State<OnboardUser> {
  final _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {

  // TextEditingControllers
      final TextEditingController nameController = TextEditingController();
      final TextEditingController emailController = TextEditingController();
      final TextEditingController githubController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50, right: 20, left: 20),
                  child: Text(
                    'Tell us about yourself',
                    textAlign: TextAlign.center,
                    style: headingStyle(),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: nameController,
                              decoration: textFieldDecorator(label: "Username")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: emailController,
                              decoration:
                                  textFieldDecorator(label: "Email Address")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: githubController,
                              decoration: textFieldDecorator(label: "Github")),
                        ),
                      ],
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {

                      final user = <String, dynamic>{
                        "username": nameController.text,
                        "email": emailController.text,
                        "github": githubController.text,
                      };

                      db.collection("user").add(user).then((DocumentReference doc) =>
                          print('DocumentSnapshot added with ID: ${doc.id}'))
                          .catchError((error) => print("Error adding document: $error"));

                      //Navigator.of(context).pushNamed(userPreferencesRoute);
                    }
                  },
                  child: Text(
                    'Create Profile !',
                    style: buttonTextStyle(),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
