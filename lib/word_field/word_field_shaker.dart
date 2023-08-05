part of 'word_field.dart';

abstract interface class WordFieldShaker {
  void shake(List<LetterFieldController> controllers);
}

class DefaultWordFieldShaker implements WordFieldShaker {
  @override
  void shake(List<LetterFieldController> controllers) {
    for (final controller in controllers) {
      controller.shake();
    }
  }
}
