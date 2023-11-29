import 'package:code_academy_2/constants.dart';
import 'package:code_academy_2/local/my_database.dart';
import 'package:code_academy_2/models/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  User user = User();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onSaved: (value){
                user.email = value;
              },
              validator: (value){
                if(value!.isEmpty){
                  return 'Enter your email';
                }
                else if(!value.contains('@')){
                  return 'Not valid email';
                }
                else{
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: 'email',
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              onSaved: (value){
                user.pass = value;
              },
              validator: (value){
                if(value!.isEmpty){
                  return 'Enter your password';
                }
                else if(value.length < 8){
                  return 'Weak password';
                }
                else{
                  return null;
                }
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'password',
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: screenSize.width * 0.75,
              child: ElevatedButton(
                onPressed: () async{
                  bool valid = formKey.currentState!.validate();
                  if(valid){
                    formKey.currentState!.save();
                    // Box box = Hive.box('users');
                    // await box.add(user.toMap());
                    MyDatabase myDB = MyDatabase();
                    await myDB.addUser(user);
                    formKey.currentState!.reset();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Added succesfully..."), backgroundColor: Colors.green,),
                    );
                    //Navigator.pushReplacementNamed(context, homePath);
                  }
                }, 
                child: Text("Login"),
              ),
            ),
          ],
              ),
        ),
      ),
    );
  }
}