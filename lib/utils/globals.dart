import 'package:flutter/cupertino.dart';

import '../modals/person.dart';

class Globals extends ChangeNotifier {
  static List<Person> allContact = [];

  void addContacts(Person c) {
    allContact.add(c);
    notifyListeners();
  }
}
