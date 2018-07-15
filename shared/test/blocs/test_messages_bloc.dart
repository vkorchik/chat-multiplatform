import 'package:chat_shared/blocs/messages_bloc.dart';
import 'package:chat_shared/data/message.dart';
import 'package:chat_shared/services/message_service.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class _MockMessageService extends Mock implements MessageService {}

void main() {
  group('MessagesBlocImpl ', () {
    test('should start with empty list', () {
      var service = new _MockMessageService();
      var bloc = new MessagesBlocImpl(service);
      bloc.messages.listen(expectAsync1(
        (list) {
          expect(list, isEmpty);
        },
      ));
    });
    test('should register and unregister messages callback', () {
      var service = new _MockMessageService();
      var bloc = new MessagesBlocImpl(service);
      verify(service.setOnMessagesUpdatedCallback(argThat(isNotNull)));
      bloc.dispose();
      verify(service.setOnMessagesUpdatedCallback(argThat(isNull)));
      verifyNoMoreInteractions(service);
    });
    test('should send lists received from service to stream', () {
      var service = new _MockMessageService();

      var bloc = new MessagesBlocImpl(service);
      var message = new Message(
        "username",
        "content",
      );
      var captureCallback =
          verify(service.setOnMessagesUpdatedCallback(captureThat(isNotNull)))
              .captured
              .first;
      expect(
        bloc.messages,
        emitsInOrder([
          [],
          [message],
        ]),
      );
      captureCallback([message]);
    });
  });
}
