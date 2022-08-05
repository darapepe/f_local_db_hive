import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';

import '../../../domain/entities/random_user.dart';
import '../../models/random_user_model.dart';
import '../../models/userdb.dart';

class UserLocalDataSourceHive {
  addUser(RandomUser user) {
    Hive.box('users').add(UserDB(
        gender: user.gender,
        name: user.name,
        country: user.city,
        email: user.email,
        picture: user.picture));
    // aquí se debe llamar Hive box (con el nombre de la caja) add con una instancia de UserDB
  }

  Future<List<RandomUser>> getAllUsers() async {
    return Hive.box('users').values.map((e) {
      return RandomUser(
          id: e.key,
          name: e.name,
          city: e.country,
          email: e.email,
          picture: e.picture,
          gender: e.gender);
    }).toList();
  }

  deleteAll() async {
    logInfo("Deleting all from database");
    return Hive.box('users').clear();
    // aquí se debe llamar Hive box (con el nombre de la caja) clear
  }

  deleteUser(index) async {
    return Hive.box('users').deleteAt(index);
    // aquí se debe llamar Hive box (con el nombre de la caja) deleteAt usando el indice
  }

  updateUser(RandomUser user) async {
    logInfo("Updating entry $user");
    return Hive.box('users').putAt(
        user.id!,
        UserDB(
            gender: user.gender,
            name: user.name,
            country: user.city,
            email: user.email,
            picture: user.picture));
    // aquí se debe llamar Hive box (con el nombre de la caja) putAt usando el id como referencia y mandando un UserDB
  }
}
