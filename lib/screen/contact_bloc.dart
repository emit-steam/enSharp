import 'dart:convert' as convert;

import 'package:ensharp/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactBloc extends ChangeNotifier {
  final _notifiers = <ValueNotifier>[];
  final contactListNotifier = ValueNotifier<List<ContactModel>>([]); // 주소록 정보 리스트
  final screenStateNotifier = ValueNotifier<ScreenStateType>(ScreenStateType.placeholder); // api state 여부
  final yearListNotifier = ValueNotifier<List<String>>([]); // 기수 리스트
  final selectYearNotifier = ValueNotifier<String>(''); // 배고픔 호소 선택한 기수

  ContactBloc() {
    _notifiers
      ..addAll([
        contactListNotifier,
        screenStateNotifier,
        yearListNotifier,
        selectYearNotifier,
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

        yearListNotifier.value = value
            .map(
              (e) {
                return e.year;
              },
            )
            .toSet()
            .toList();

        ///// 전체를 default select year로 한다
        yearListNotifier.value.insert(0, '전체');
        setSelectYear(selectYear: yearListNotifier.value[0]);

        screenStateNotifier.value = ScreenStateType.success;
      },
    );
  }

  void setSelectYear({String selectYear}) {
    selectYearNotifier.value = selectYear;
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
