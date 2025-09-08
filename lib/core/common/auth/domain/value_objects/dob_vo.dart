
class DobVo {
  final DateTime value;

  DobVo._(this.value);

  factory DobVo(DateTime dob) {
    final now = DateTime.now();
    final age = now.year - dob.year - ((now.month < dob.month || (now.month == dob.month && now.day < dob.day)) ? 1 : 0);
    if (age < 0 || age > 120) {
      throw ArgumentError('Invalid date of birth');
    }
    return DobVo._(dob);
  }

  static String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
}