import 'package:flutter/material.dart';

class UserInputScreen extends StatefulWidget {
  const UserInputScreen({super.key});

  @override
  State<UserInputScreen> createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  List<String> names = ["Ahmed", "mohamed", "Abdo", "Hassan", "Omar"];
  List<String> filteredNames = [];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              onChanged: (value){
                setState((){
                  filteredNames = names.where((element) => element.toLowerCase().contains(value)).toList();
                });
              },
              //keyboardType: TextInputType.phone,
              obscureText: false,
              decoration: InputDecoration(
                //hintText: 'email'
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.green,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.green
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.green
                  )
                ),
                //errorBorder: ,
                //focusedErrorBorder: ,
              ),
            ),
            Text("Suggestions"),
            SizedBox(height: 10,),
            for(String name in filteredNames)
              Column(children: [
                Text(name),
                SizedBox(height: 10,),
              ],),
            TextButton(
              onPressed: (){
                print(controller);
              }, 
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}