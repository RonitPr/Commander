import 'package:commander/Command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

class CommandView extends StatefulWidget {
  final Command command;
  const CommandView(this.command, {Key? key}) : super(key: key);
  @override
  _CommandViewState createState() => _CommandViewState();
}

class _CommandViewState extends State<CommandView> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
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
                  child: Text(
                    widget.command.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RoundedProgressBar(
                  percent: (widget.command.accepted.length /
                          widget.command.require.length) *
                      100,
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
                    child: Text('הורד קובץ פקודה',
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
                      String userName = requireAndWatch[index];
                      String status = "accepted";
                      if (!widget.command.require
                          .contains(requireAndWatch[index])) {
                        status = "require";
                      } else if (widget.command.watch
                          .contains(requireAndWatch[index])) {
                        status = 'watcher';
                      }

                      return ListTile(
                        trailing: status != "watcher"
                            ? Icon(
                                Icons.verified,
                                color: status == "accepted"
                                    ? Colors.green
                                    : Colors.grey,
                              )
                            : Container(),
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
