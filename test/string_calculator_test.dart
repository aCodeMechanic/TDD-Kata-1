import 'package:flutter_test/flutter_test.dart';
import 'package:string_calculator/string_calculator.dart';

void main() {
  group('StringCalculator', () {
    // 1. Test for an empty string
    test('should return 0 for an empty string', () {
      final calculator = StringCalculator();
      expect(calculator.add(''), equals(0));
    });
    // 1. Test for single numbers
    test('should return the number itself for a single number', () {
      final calculator = StringCalculator();
      expect(calculator.add('1'), equals(1));
      expect(calculator.add('2'), equals(2));
    });
    // 1. Test for two numbers
    test('should return the sum of two numbers', () {
      final calculator = StringCalculator();
      expect(calculator.add('1,2'), equals(3));
    });
    // 2. Test for unknown amount of numbers
    test('should handle unknown amount of numbers', () {
      final calculator = StringCalculator();
      expect(calculator.add('1,2,3,4'), equals(10));
    });
    // 3. Test for new lines between numbers
    test('should handle new lines between numbers', () {
      final calculator = StringCalculator();
      expect(calculator.add('1\n\n\n2,3\n\n'), equals(6));
    });
    // 4. Support different delimiters
    test('should support custom delimiters', () {
      final calculator = StringCalculator();
      expect(calculator.add('//;\n1;2'), equals(3));
      expect(calculator.add('//;\n1;2'), equals(3));
      expect(calculator.add('//[***]\n1***2***3'), equals(6));
      expect(calculator.add('//[*][%]\n1*2%3'), equals(6));
      expect(calculator.add('//[**][%%]\n1**2%%3'), equals(6));
    });
    // 5 & 6. Handle negative numbers and throw exception
    test('should throw exception for negative numbers', () {
      final calculator = StringCalculator();
      expect(() => calculator.add('-1,2'), throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('negatives not allowed: -1'))));
      expect(() => calculator.add('-1,-2,3'), throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('negatives not allowed: -1, -2'))));
    });
    // 7. Count how many times Add has been called
    test('should count how many times Add has been called', () {
      final calculator = StringCalculator();
      calculator.add('1,2');
      calculator.add('2,2');
      expect(calculator.getCalledCount(), equals(2));
    });
    // 9. Ignore numbers larger than 1000
    test('should ignore numbers larger than 1000', () {
      final calculator = StringCalculator();
      expect(calculator.add('2,1001,4'), equals(6));
      expect(calculator.add('1001,2000'), equals(0));
      expect(calculator.add('1000,2000'), equals(1000));
    });
    // 10. Handle delimiters of any length
    test('should handle delimiters of any length', () {
      final calculator = StringCalculator();
      expect(calculator.add('//[***]\n1***2***3'), equals(6));
    });
    // 11 & 12. Handle multiple delimiters with length longer than one char
    test('should handle multiple delimiters with length longer than one char', () {
      final calculator = StringCalculator();
      expect(calculator.add('//[**][%%]\n1**2%%3'), equals(6));
    });
  });
}
