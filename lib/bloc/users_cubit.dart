import 'package:code_academy_2/bloc/users_state.dart';
import 'package:code_academy_2/local/my_database.dart';
import 'package:code_academy_2/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<UsersState>{
  List<User> users = [];

  UsersCubit() : super(InitUserSate());

  void getUsers() async{
    MyDatabase myDB = MyDatabase();
    emit(LoadingUserSate());
    await Future.delayed(Duration(seconds: 3), () async{
      users = await myDB.getUsers();
    });
    emit(SuccessUserSate());
    await Future.delayed(Duration(seconds: 1), () async{});
    emit(GetUserSate());
  }

}