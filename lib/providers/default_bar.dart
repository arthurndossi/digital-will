// import 'package:dibu/models/client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultBar with ChangeNotifier {

  String _currentBar = 'AppBar';
  bool _showSelect = false;
  int _counter = 0;
  final List<Map<String, int>> _selected = [];

  void setCurrentBar(String currentBar) {
    currentBar == 'AppBar' ? _currentBar = 'AppBar': _currentBar = 'SelectBar';
    // notifyListeners();
  }

  String get getCurrentBar => _currentBar;

  void increment() {
    _counter += 1;
    // notifyListeners();
  }

  void decrement() {
    _counter -= 1;
    // notifyListeners();
  }

  String get getCounter => _counter.toString();

  void toggleShowSelect() {
    _showSelect = !_showSelect;
    // notifyListeners();
  }

  bool get showSelect => _showSelect;

  void addToSelected(int row, int pos) {
    var keyPair = {
      'Key': row,
      'value': pos,
    };
    _selected.add(keyPair);
    increment();
    update();
  }

  void removeFromSelected(int row, int pos) {
    var index = _selected.indexWhere((pair) =>
    pair['Key'] == row && pair['value'] == pos);
    _selected.removeAt(index);
    if (_selected.isEmpty) {
      clearSelected();
      setCurrentBar('AppBar');
      update();
      // notifyListeners();
    } else {
      decrement();
      update();
    }
  }

  void clearSelected() {
    _selected.clear();
    _counter = 0;
    toggleShowSelect();
  }

  bool isItemSelected(int row, int pos) {
    for (var map in _selected) {
      if (map.containsKey('Key')) {
        if (map['Key'] == row && map['value'] == pos) {
          return true;
        }
      }
    }
    return false;
  }

  void update() {
    notifyListeners();
  }

  List<Map<String, int>> get getSelected => _selected;
}
