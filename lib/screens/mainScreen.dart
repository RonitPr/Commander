import 'package:commander/Command.dart';
import 'package:commander/widget/CommandView.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  List<Command> commands = [];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        child: ListView.builder(
          itemBuilder: (context, index) => CommandView(commands[index]),
        ),
      ),
    );
  }
}
