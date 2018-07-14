import 'package:chat_shared/blocs/user_bloc.dart';
import 'package:chat_shared/data/username.dart' as user;
import 'package:test/test.dart';

void main() {
  group('UserBlocImpl usernameSet ', () {
    test('starts with false when username is not set', () {
      user.username = null;
      var userBlock = new UserBlocImpl();
      var isUsernameSetStream = userBlock.usernameSet;
      isUsernameSetStream.listen(
        expectAsync1((value) {
          expect(value, false);
        }, count: 1),
      );
    });
    test('starts with true when username is set', () {
      user.username = "some";
      var userBlock = new UserBlocImpl();
      var isUsernameSetStream = userBlock.usernameSet;
      isUsernameSetStream.listen(
        expectAsync1((value) {
          expect(value, true);
        }, count: 1),
      );
    });
  });
  group("UserBlockImpl username ", () {
    test("username update trigger the usernameSet event", () {
      user.username = null;
      var userBlock = new UserBlocImpl();
      var usernameSink = userBlock.username;
      expect(
          userBlock.usernameSet,
          emitsInOrder([
            false,
            true,
            true,
          ]));
      usernameSink.add("username");
      usernameSink.add("username2");
    });
  });
}
