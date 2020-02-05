import 'dart:async';

class MandatoryValidator {
  final StreamTransformer<String, String> validateMandatory =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.isEmpty) {
      sink.addError('required');
    } else {
      sink.add(value);
    }
  });
}
