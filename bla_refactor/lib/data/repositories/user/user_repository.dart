import '../../../model/user/user.dart';

abstract class UserRepository {
  List<User> getAllUsers();
}