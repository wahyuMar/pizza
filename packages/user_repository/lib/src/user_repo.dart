import 'package:user_repository/user_repository.dart';

abstract class UserRepository {
  Stream<MyUser?> get user;
  
  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> setUserData (MyUser myUser);

  Future<void> signIn(String email, String password);
  
  Future<void> logOut();
}