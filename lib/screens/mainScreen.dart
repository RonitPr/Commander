import 'package:commander/Command.dart';
import 'package:commander/widget/CommandView.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final List<Command> commands;

  const MainScreen({Key? key, required this.commands}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        child: commands.isNotEmpty
            ? ListView.builder(
                itemCount: commands.length,
                itemBuilder: (context, index) => CommandView(commands[index]),
              )
            : Container(
                child: Text('No commands'),
              ),
      ),
    );
  }
}
