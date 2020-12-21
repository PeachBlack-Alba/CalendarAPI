import 'dart:developer';
import 'package:flutter/material.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarClient {
  static const _scopes = const [CalendarApi.CalendarScope];
  Map<String, String> eventData;


  insert(title, startTime, endTime) {
    var _clientID =  ClientId("495439237591-ihee1pohe1illj40d57folq9b4mlnm19.apps.googleusercontent.com", "");
    clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
      var calendar = CalendarApi(client);
      calendar.calendarList.list().then((value) => print("val $value"));

      String calendarId = "primary";
      Event event = Event();

      event.summary = title;

      EventDateTime start =  EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+01:00";
      event.start = start;

      EventDateTime end =  EventDateTime();
      end.timeZone = "GMT+01:00";
      end.dateTime = endTime;
      event.end = end;
      // ADDS THE EVENT
      try {
        calendar.events.insert(event, calendarId).then((value) {
          print("added${value.status}");
          if (value.status == "confirmed") {
            String eventId;
            eventId = value.id;


            eventData = {'id': eventId};

            print('Event added to Google Calendar');
          } else {
            log("Unable to link event in google calendar");
          }
        });
      } catch (e) {
        log('Error creating event $e');
      }
    });
    return eventData;
  }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}