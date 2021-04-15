import 'dart:convert' as convert;

import 'package:ensharp/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactBloc extends ChangeNotifier {
  final _notifiers = <ValueNotifier>[];
  final contactListNotifier = ValueNotifier<List<ContactModel>>([]);
  final screenStateNotifier = ValueNotifier<ScreenStateType>(ScreenStateType.placeholder);

  ContactBloc() {
    _notifiers
      ..addAll([
        contactListNotifier,
        screenStateNotifier,
      ])
      ..forEach(
        (element) {
          element.addListener(notifyListeners);
        },
      );
  }

  void fetch() {
    screenStateNotifier.value = ScreenStateType.placeholder;
    getContactList().then(
      (value) {
        contactListNotifier.value = value;
        screenStateNotifier.value = ScreenStateType.success;
      },
    );
  }

  Future<List<ContactModel>> getContactList() async {
    final getContactScriptUrl =
        'https://script.googleusercontent.com/macros/echo?user_content_key=96pD7OJcds6gruUEN-1w0rK_m5jE5Vow1xq7GsFfb-AHNPnn2WOxaOahSuy8D3x4z7COskVqiiixdm-1l-CpSFoL3QIqnSiBm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnOk3RihwAWOVThTIysa_Sd1vA04VKe6pp96VzrcpF6zlRDA_CHkWlKCMZPfSHi6FAvwAFlvOoB_b2BkV-iuUljLQ3Q0368bgLQ&lib=MsUxA45QMlXc6tH11sHtJwOFJXrUdl8zT';

    return await http.get(getContactScriptUrl).then(
      (json) {
        var jsonContact = convert.jsonDecode(json.body) as List;
        return jsonContact.map((json) => ContactModel.fromJson(json)).toList();
      },
    ).catchError(
      (error) {
        screenStateNotifier.value = ScreenStateType.error;
      },
    );
  }

  @override
  void dispose() {
    _notifiers.forEach(
      (element) {
        element.removeListener(notifyListeners);
        element.dispose();
      },
    );
    super.dispose();
  }
}

enum ScreenStateType {
  placeholder,
  success,
  error,
}
