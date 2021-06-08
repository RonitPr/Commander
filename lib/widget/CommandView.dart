import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

class CommandView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    'כותרת של פקודה',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RoundedProgressBar(
                  percent: 50,
                  paddingChildLeft: EdgeInsets.symmetric(horizontal: 10),
                  childLeft: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black38,
                    ),
                    child: Text(
                      '4/6',
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
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
                color: Colors.green,
              ),
              child: Center(
                child: Icon(
                  Icons.expand_more,
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
