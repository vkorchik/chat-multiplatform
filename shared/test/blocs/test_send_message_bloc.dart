import 'package:chat_shared/blocs/send_message_bloc.dart';
import 'package:chat_shared/services/message_service.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class _MockMessageService extends Mock implements MessageService {}

void main() {
  group(
    'SendMessageBlocImpl ',
    () {
      test(
        'should do not call service when empty messages are send',
        () {
          var service = new _MockMessageService();
          var bloc = new SendMessageBlocImpl(service);
          bloc.messages.add(null);
          bloc.messages.add("");
          verifyZeroInteractions(service);
        },
      );
      test(
        'should pass message to the service',
        () async {
          var service = new _MockMessageService();
          var bloc = new SendMessageBlocImpl(service);
          bloc.messages.add("new message");
          await untilCalled(service.send(any, any))
              .timeout(new Duration(milliseconds: 100));
          verify(service.send(any, "new message"));
          verifyNoMoreInteractions(service);
        },
      );
      test("should send clear input after sending message", () {
        var service = new _MockMessageService();
        var bloc = new SendMessageBlocImpl(service);
        expect(
          bloc.clearFieldEvents,
          emitsInOrder([
            true,
            true,
          ]),
        );
        bloc.messages.add("not empty");
        bloc.messages.add("another not empty");
      });
    },
  );
}
