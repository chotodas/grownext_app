class DateModel {
  final List<String> days = List.generate(30, (i) => '${i + 1}');
  final List<String> months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];
  final List<String> years = List.generate(150, (i) => '${1900 + i}');
}
