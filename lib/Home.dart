import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'CalendarClient.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  CalendarClient calendarClient = CalendarClient();
  DateTime startTime = DateTime.now();

  DateTime endTime = DateTime.now().add(Duration(days: 1));
  TextEditingController _eventName = TextEditingController();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
    );
  }

  body(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context, showTitleActions: true, minTime: DateTime.now(), maxTime: DateTime(2222, 6, 7), onChanged: (date) {
                        print('start time ${dateFormat.format(date)}');
                      }, onConfirm: (date) {
                        setState(() {
                          this.startTime = date;
                          print('start time ${dateFormat.format(date)}');
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Text(
                      'Event Start Time',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                Text(
                  '${dateFormat.format(startTime)}',
                  style: TextStyle(color: Colors.redAccent, fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context, showTitleActions: true, minTime: DateTime(2019, 3, 5), maxTime: DateTime(2200, 6, 7),
                          onChanged: (date) {
                            print('end time ${dateFormat.format(date)}');
                      }, onConfirm: (date) {
                        setState(() {
                          this.endTime = date;
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Text(
                      'Event End Time',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                Text(
                  '${dateFormat.format(endTime)}',
                  style: TextStyle(color: Colors.redAccent, fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)), border: Border.all(width: 3, color: Colors.redAccent, style: BorderStyle.solid)),
              padding: EdgeInsets.all(5.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.send,
                controller: _eventName,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  prefixIcon: Icon(
                    Icons.event,
                    color: Colors.redAccent,
                  ),
                  hintText: 'Enter Event title',
                  hintStyle: TextStyle(color: Colors.redAccent, fontSize: 18),
                ),
                cursorColor: Colors.redAccent,
                cursorRadius: Radius.circular(16.0),
                cursorWidth: 16.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                child: Text(
                  'Insert Event',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                color: Colors.redAccent,
                onPressed: () {
                  calendarClient.insert(
                    _eventName.text,
                    startTime,
                    endTime,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
