// import 'package:dibu/models/client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultBar with ChangeNotifier {

  String _currentBar = 'AppBar';
  bool _showSelect = false;
  int _counter = 0;
  final List<int> _selected = [];

  void setCurrentBar(String currentBar) {
    currentBar == 'AppBar' ? _currentBar = 'AppBar': _currentBar = 'SelectBar';
    notifyListeners();
  }

  String get getCurrentBar => _currentBar;

  void increment() {
    _counter += 1;
    notifyListeners();
  }

  void decrement() {
    _counter -= 1;
    notifyListeners();
  }

  String get getCounter => _counter.toString();

  void toggleShowSelect() {
    _showSelect = !_showSelect;
    notifyListeners();
  }

  bool get showSelect => _showSelect;

  void addToSelected(int index) {
    _selected.add(index);
    increment();
  }

  void removeFromSelected(int index) {
    int position = _selected.indexOf(index);
    _selected.removeAt(position);
    if (_selected.isEmpty) {
      _counter = 0;
      notifyListeners();
    } else decrement();
  }

  void clearSelected() {
    _selected.clear();
    _counter = 0;
    toggleShowSelect();
  }

  List<int> get getSelected => _selected;
}
