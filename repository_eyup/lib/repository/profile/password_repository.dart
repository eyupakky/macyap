abstract class IPasswordRepository{
  Future<bool> updatePassword();
}
class PasswordRepository extends IPasswordRepository{
  @override
  Future<bool> updatePassword() {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

}