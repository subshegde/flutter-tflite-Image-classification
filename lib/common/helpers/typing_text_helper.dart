// typing_text_helper.dart
import 'dart:async';
import 'package:flutter/material.dart';

class TypingTextHelper {
  final ValueNotifier<String> textNotifier = ValueNotifier('');
  Timer? _timer;
  int _textIndex = 0;
  String _fullText = '';

  void startTyping(String fullText, {Duration speed = const Duration(milliseconds: 15)}) {
    _textIndex = 0;
    _fullText = fullText;
    textNotifier.value = '';
    _timer?.cancel();

    _timer = Timer.periodic(speed, (timer) {
      if (_textIndex < _fullText.length) {
        textNotifier.value += _fullText[_textIndex];
        _textIndex++;
      } else {
        timer.cancel();
      }
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
