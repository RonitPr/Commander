import 'package:commander/Command.dart';
import 'package:commander/widget/CommandView.dart';
import 'package:flutter/material.dart';

import '../User.dart';

class MainScreen extends StatelessWidget {
  final List<Command> commands;
  final User user;

  const MainScreen({
    Key? key,
    required this.commands,
    required this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        child: commands.isNotEmpty
            ? ListView.builder(
                itemCount: commands.length,
                itemBuilder: (context, index) => CommandView(
                  commands[index],
                  user,
                ),
              )
            : Container(
                child: Center(child: Text('No commands')),
              ),
      ),
    );
  }
}
