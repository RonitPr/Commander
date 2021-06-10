class Command {
  String author;
  String title;
  String id;
  List<dynamic> require;
  List<dynamic> accepted;
  List<dynamic> watch;

  Command(
    this.author,
    this.title,
    this.id,
    this.require,
    this.accepted,
    this.watch,
  );
}
