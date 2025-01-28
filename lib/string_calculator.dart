class StringCalculator {
  int _calledCount = 0;

  int add(String numbers) {
    _calledCount++;
    if (numbers.isEmpty) return 0;
    return _addWithDelimiter(numbers, ' ');
  }

  int _addWithDelimiter(String numbers, String delimeter) {
    var cleanString = _getCleanString(numbers);
    var list = cleanString.split(delimeter).map((e) => int.parse(e)).toList();
    final negatives = list.where((num) => num < 0).toList();
    if(negatives.isNotEmpty) throw Exception('negatives not allowed: ${negatives.join(', ')}');
    var sum = 0;
    list.where((element) => element<=1000).toList().forEach((element) => sum+=element);
    return sum;
  }

  String _getCleanString(String numbers) {
    return numbers
        .replaceAll( RegExp(r'[^-\d]'), ' ').replaceAll(RegExp(r"\s+"), " ").trim();
  }
  int getCalledCount() {
    return _calledCount;
  }
}
