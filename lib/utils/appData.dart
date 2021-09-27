import 'package:authers/models/postsPagination.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  PostPagination postPagination;

  int currentPage = 1;

  void updatePagination(PostPagination postPaginations) {
    postPagination = postPaginations;
    notifyListeners();
  }

  void updatePage(int nb) {
    currentPage = nb;
    notifyListeners();
  }
}
