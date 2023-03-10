import 'package:nappy_mobile/common/exceptions/value_exceptions.dart';
import 'package:nappy_mobile/common/util/validator.dart';
import 'package:nappy_mobile/common/value/value.dart';

class EmailAddressValue extends Value<String> {
  factory EmailAddressValue(String? raw) {
    if (raw == null || raw.isEmpty) {
      throw const RequiredValueException();
    } else if (!Validator.validateEmail(raw)) {
      throw IllegalValueException(raw);
    } else {
      return EmailAddressValue._(raw);
    }
  }

  const EmailAddressValue._(super.value);
}
