class Command {
  String title;
  String id;
  List<dynamic> require;
  List<dynamic> accepted;
  List<dynamic> watch;

  Command(
    this.title,
    this.id,
    this.require,
    this.accepted,
    this.watch,
  );
}
