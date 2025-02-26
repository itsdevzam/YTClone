
import 'package:flutter/cupertino.dart';

class HomePageModel extends ChangeNotifier{
  bool _isHover=false;
  int _isHoverIndex=0;
  bool get isHover => _isHover;
  int get isHoverIndex => _isHoverIndex;
  void isHoverT(int i){
    _isHover=true;
    _isHoverIndex=i;
    notifyListeners();
  }
  void isHoverF(){
  _isHover=false;
  notifyListeners();
  }
}