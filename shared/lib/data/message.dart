class Message {
  final String username;
  final String content;

  Message(this.username, this.content)
      : assert(username != null),
        assert(content != null);
}
