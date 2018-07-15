class Message {
  final String username;
  final String content;

  Message(this.username, this.content)
      : assert(username != null),
        assert(content != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          content == other.content;

  @override
  int get hashCode => username.hashCode ^ content.hashCode;
}
