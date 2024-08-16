abstract class IPasswordRepository {
  Future<bool> updatePassword();
}

class PasswordRepository extends IPasswordRepository {
  @override
  Future<bool> updatePassword() {
    throw UnimplementedError();
  }
}
