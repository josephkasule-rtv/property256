abstract final class CurrencyFormatter {
  static String ugxPerMonth({required final int amount}) {
    final String formatted = _formatWholeNumber(value: amount);
    return 'UGX $formatted / month';
  }

  static String _formatWholeNumber({required final int value}) {
    final String digits = value.toString();
    final StringBuffer buffer = StringBuffer();
    int counter = 0;

    for (int index = digits.length - 1; index >= 0; index--) {
      buffer.write(digits[index]);
      counter++;
      if (counter % 3 == 0 && index != 0) {
        buffer.write(',');
      }
    }

    return buffer.toString().split('').reversed.join();
  }
}
