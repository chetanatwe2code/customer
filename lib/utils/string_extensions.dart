import 'dart:math';

import 'package:intl/intl.dart';

extension StringExtensions on String {

  String toTransactionId() {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < (int.tryParse(this)??16); i++) {
      final randomIndex = random.nextInt(chars.length);
      buffer.write(chars[randomIndex]);
    }

    return buffer.toString();
  }

  String toCapitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    final trimmedString = trim();
    final firstNonSpaceIndex = trimmedString.indexOf(RegExp(r'\S'));
    if (firstNonSpaceIndex == -1) {
      // The string contains only spaces
      return this;
    }
    return substring(0, firstNonSpaceIndex) +
        trimmedString[firstNonSpaceIndex].toUpperCase() +
        trimmedString.substring(firstNonSpaceIndex + 1);
  }
  String toDateDMMMY(){
    try{
      return DateFormat('d MMM, y').format(DateTime.parse(this));
    }catch (e){
      return this;
    }
  }

  String toDateDMMMYY(){
    try{
      return DateFormat('d MMM, yy').format(DateTime.parse(this));
    }catch (e){
      return this;
    }
  }
}
