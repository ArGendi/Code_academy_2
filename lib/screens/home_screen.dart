import 'package:code_academy_2/bloc/users_cubit.dart';
import 'package:code_academy_2/bloc/users_state.dart';
import 'package:code_academy_2/constants.dart';
import 'package:code_academy_2/local/my_database.dart';
import 'package:code_academy_2/models/user.dart';
import 'package:code_academy_2/screens/profile_screen.dart';
import 'package:code_academy_2/screens/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // void getUsers(){
  //   Box box = Hive.box('users');
  //   List keys = box.keys.toList(); // [0,1,2,3,4]
  //   List<User> tempUsers = [];
  //   for(var key in keys){
  //     Map map = box.get(key);
  //     tempUsers.add(User.fromMap(key, map));
  //   }
  //   setState(() {
  //     users = tempUsers;
  //   });
  // }

  // void getUserFromSQL() async{
  //   MyDatabase myDb = MyDatabase();
  //   List<User> tempUsers = await myDb.getUsers();
  //   setState(() {
  //     users = tempUsers;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getUsers();
    //getUserFromSQL();
    BlocProvider.of<UsersCubit>(context).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            var cubit = BlocProvider.of<UsersCubit>(context);
            if(state is LoadingUserSate){
              return Center(child: CircularProgressIndicator());
            }
            else if(state is SuccessUserSate){
              return Center(child: Icon(Icons.check_rounded, size: 60, color: Colors.green,),);
            }
            else return ListView.separated(
              itemBuilder: (context, i) {
                return Row(
                  children: [
                    Text('${cubit.users[i].email} , ${cubit.users[i].pass}'),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.update),
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen(editUser: users[i])));
                        //Navigator.pushNamed(context, updateScreenPath, arguments: users[i]);
                      },
                    ),
                  ],
                );
              },
              separatorBuilder: (context, i) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: cubit.users.length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, formPath);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
