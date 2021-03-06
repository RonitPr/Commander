import 'dart:math';

import 'package:commander/Command.dart';
import 'package:commander/User.dart';
import 'package:commander/server/command.dart';
import 'package:commander/server/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

class CommandView extends StatefulWidget {
  final Command command;
  final User user;
  const CommandView(
    this.command,
    this.user, {
    Key? key,
  }) : super(key: key);
  @override
  _CommandViewState createState() => _CommandViewState();
}

class _CommandViewState extends State<CommandView> {
  bool expanded = false;
  List<User> users = [];
  late double progress;
  @override
  void initState() {
    super.initState();

    getAllUsers().then((value) {
      setState(() {
        this.users = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool approved = false;
    bool author = false;
    bool watcher = false;
    progress = max(
        (widget.command.accepted.length / widget.command.require.length) * 100,
        0);
    print(widget.command.accepted);
    // Check if author
    if (widget.user.userKey == widget.command.author) author = true;

    /// if Not author
    if (!author) {
      // If user in accepted
      (widget.command.accepted).forEach((element) {
        if (element == widget.user.userKey) {
          approved = true;
        }
      });
      // if user in watcher
      (widget.command.watch).forEach((element) {
        if (element == widget.user.userKey) {
          watcher = true;
        }
      });
    }

    if ((!author && !approved && !watcher))
      widget.command.require.forEach((element) {
        if (element == widget.user.userKey) approved = false;
      });
    List<dynamic> requireAndWatch =
        widget.command.require + widget.command.watch;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(2, 2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.command.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      !author
                          ? !approved && !watcher
                              ? TextButton(
                                  onPressed: () {
                                    widget.command.accepted
                                        .add(widget.user.userKey);
                                    approveCommand(widget.user.userKey,
                                            widget.command.id)
                                        .then(
                                      (value) => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(value
                                              ? '?????????? ???????? ????????????'
                                              : '????????.. ???????? ???????????? ????????'),
                                        ),
                                      ),
                                    );
                                    setState(() {});
                                  },
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.green,
                                  ),
                                  child: Text(' ?????? ?????????? '),
                                )
                              : Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.green,
                                )
                          : Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text('????????????',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ),
                    ],
                  ),
                ),
                RoundedProgressBar(
                  percent: this.progress,
                  paddingChildLeft: EdgeInsets.symmetric(horizontal: 10),
                  childLeft: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black38,
                    ),
                    child: Text(
                      '${widget.command.accepted.length}/${widget.command.require.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  style: RoundedProgressBarStyle(
                    colorProgress: Colors.lightGreen,
                    colorProgressDark: Colors.lightGreen.shade800,
                    borderWidth: 0,
                  ),
                  height: 30,
                  borderRadius: BorderRadius.circular(15),
                ),
              ],
            ),
          ),
          this.expanded
              ? TextButton(
                  onPressed: () {
                    // TODO :: Download file of command.
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('???????? ???????? ??????????',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                )
              : Container(),
          this.expanded
              ? Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  height: 200,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ListView.builder(
                    itemCount: requireAndWatch.length,
                    itemBuilder: (BuildContext context, int index) {
                      String userName = '';
                      users.forEach((element) {
                        if (element.userKey == requireAndWatch[index]) {
                          userName = element.username;
                        }
                      });
                      String status = '';
                      widget.command.accepted.forEach((element) {
                        if (element == requireAndWatch[index])
                          status = 'accepted';
                      });
                      if (status == '')
                        widget.command.require.forEach((element) {
                          if (element == requireAndWatch[index])
                            status = 'require';
                        });
                      if (status == '') status = 'watcher';
                      return ListTile(
                        trailing: status != "watcher"
                            ? Icon(
                                Icons.verified,
                                color: status == "accepted"
                                    ? Colors.green
                                    : Colors.grey,
                              )
                            : Icon(Icons.remove_red_eye_outlined),
                        title: Text(
                          userName,
                          textDirection: TextDirection.rtl,
                        ),
                      );
                    },
                  ),
                )
              : Container(),
          InkWell(
            onTap: () {
              setState(() {
                this.expanded = !this.expanded;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
                color: Colors.green[400],
              ),
              child: Center(
                child: Icon(
                  this.expanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
