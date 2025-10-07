import 'package:flutter/material.dart';
import '../models/date_model.dart';

class CheckSlotsViewModel extends ChangeNotifier {
  final DateModel _dateModel = DateModel();

  String selectedType = 'Year';
  int selectedIndex = 1;

  List<String> get currentList {
    switch (selectedType) {
      case 'Month':
        return _dateModel.months;
      case 'Day':
        return _dateModel.days;
      default:
        return _dateModel.years;
    }
  }

  String get selectedYear =>
      selectedType == 'Year' ? currentList[selectedIndex] : _selectedYear;
  String get selectedMonth =>
      selectedType == 'Month' ? currentList[selectedIndex] : _selectedMonth;
  String get selectedDay =>
      selectedType == 'Day' ? currentList[selectedIndex] : _selectedDay;

  String _selectedYear = '2024';
  String _selectedMonth = 'JAN';
  String _selectedDay = '01';

  List<bool> selectedSlots = List.generate(5, (_) => false);
  final List<String> slots = [
    '04.00 pm - 05.00pm',
    '05.00 pm - 06.00pm',
    '06.00 pm - 07.00pm',
    '07.00 pm - 08.00pm',
    '08.00 pm - 09.00pm',
  ];

  void changeTab(String type) {
    selectedType = type;
    selectedIndex = 0;

    if (selectedType == 'Year') {
      _selectedYear = '2024';
    } else if (selectedType == 'Month') {
      _selectedMonth = 'JAN';
      selectedIndex = 0;
    } else {
      _selectedDay = '01';
    }

    if (selectedType == 'Month' && selectedIndex >= _dateModel.months.length) {
      selectedIndex = 0;
    }

    notifyListeners();
  }

  void selectItem(int index) {
    selectedIndex = index;

    if (selectedType == 'Year') {
      _selectedYear = currentList[index];
      selectedType = 'Month';
      selectedIndex = 0;
    } else if (selectedType == 'Month') {
      _selectedMonth = currentList[index];
      selectedType = 'Day';
    } else {
      _selectedDay = currentList[index];
    }

    notifyListeners();
  }

  void previousItem() {
    if (selectedIndex > 0) {
      selectedIndex--;
      notifyListeners();
    }
  }

  void nextItem() {
    if (selectedIndex < currentList.length - 1) {
      selectedIndex++;
      notifyListeners();
    }
  }

  String get formattedDate => '$selectedDay $selectedMonth $selectedYear';

  void selectSlot(int index, bool value) {
    selectedSlots[index] = value;
    notifyListeners();
  }
}
