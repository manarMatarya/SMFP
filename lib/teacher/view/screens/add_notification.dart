import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

class PushNotification {
  PushNotification._();

  static final PushNotification instance = PushNotification._();

  ///todo you will need change Authorization :key= key from cloud messaging in firebase console
  var headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'key=AAAAdbEHMmA:APA91bFLgQfi-NiJOOSC9YhuA39kT9llxZV6xXXhgjDvnrZSx9mULzVJ6CvwrHK1X2lA2eDhYI2R_gN3FyWXz03s6c7bn7f2XyhMfW2EdTyHS51jIxJtkUUI6Lsf6mppF-Q1HTndlSCL'
  };

  ///todo you will need change [title ,body ,to=FCM user Token , data//data you need to send]
  ///todo you must add it in method from parameter sendNotification("","","","")

  sendNotification({var title, var body, var to, var mapData}) async {
    print(headers.toString());
    try {
      var request = http.Request(
          'POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
      request.body = json.encode({
        "notification": {
          "title": "$title", //?? "you have recieved a message from user X",
          "body": "$body", //?? "testing body from post man",
          "sound": "default"
        },
        "android": {
          "priority": "HIGH",
          "notification": {
            "notification_priority": "PRIORITY_MAX",
            "sound": "default",
            "default_sound": true,
            "default_vibrate_timings": true,
            "default_light_settings": true
          }
        },
        "to":
            "$to", //?? "e9Ws0ldNrUCHjWHIhPg56q:APA91bGKQ42_dglUX5NyoFBLmnfCkwBLuoBQ_Rv59kh3KNO8M33Q-t_IfJgRB70ovEp6jQlbfSrqU-n8fGylZW9-m78QhfPeOGZfJpkdiJjJbWb46opI8aoFX_XhD7L9wN58kV3QxMxk",
        "priority": "high",
        "data": mapData ??
            {
              "type": "order",
              "id": "87",
              "click_action": "FLUTTER_NOTIFICATION_CLICK"
            }
      });
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        //todo success
        Logger().d("success push success");
        Logger().d("push ff ${response.body}");
      } else {
        //todo faile
        Logger().d("push faile ${response.body}");
      }
    } on Exception catch (e) {
      // TODO
      Logger().d(" $e");
    }
  }
}
