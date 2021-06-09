class Command {
  String title;
  String id;
  String url;
  List<String> required;
  List<String> accepted;
  List<String> watch;

  Command(
    this.title,
    this.id,
    this.url,
    this.required,
    this.accepted,
    this.watch,
  );
}
