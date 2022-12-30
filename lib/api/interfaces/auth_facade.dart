import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/error/auth_error.dart';
import 'package:nappy_mobile/common/value/email_address_value.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/common/value/password_value.dart';
import 'package:nappy_mobile/models/user.dart';

/// Represents an Authentication Repository.
abstract class IAuthRepositoryFacade {
  Future<Either<AuthError, Unit>> register({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<Either<AuthError, Unit>> signIn({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<Either<AuthError, Unit>> sendResetPasswordLink(EmailAddressValue email);

  Future<Either<AuthError, Unit>> signInWithGoogle();

  Stream<Option<Identifier>> onUserAuthUpdate();

  Option<Identifier> getUserIdentifier();

  Future<void> signOut();
}
