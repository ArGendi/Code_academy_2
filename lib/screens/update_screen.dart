import 'package:code_academy_2/constants.dart';
import 'package:code_academy_2/local/my_database.dart';
import 'package:code_academy_2/models/user.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UpdateScreen extends StatefulWidget {
  final User editUser;
  const UpdateScreen({super.key, required this.editUser,});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
   User user = User();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isHidden = true;

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
              initialValue: widget.editUser.email,
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
              initialValue: widget.editUser.pass,
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
              obscureText: isHidden,
              decoration: InputDecoration(
                labelText: 'password',
                suffixIcon: IconButton(
                  icon:  Icon(isHidden ? Icons.visibility_off : Icons.visibility),
                  onPressed: (){
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                )
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
                    // await box.put(widget.editUser.key, user.toMap());
                    MyDatabase myDB = MyDatabase();
                    myDB.updateUser(widget.editUser, user);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("updated succesfully..."), backgroundColor: Colors.green,),
                    );
                    Navigator.pop(context);
                  }
                }, 
                child: Text("Edit"),
              ),
            ),
          ],
              ),
        ),
      ),
    );
  }
}