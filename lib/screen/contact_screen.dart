import 'dart:math';

import 'package:ensharp/screen/contact_bloc.dart';
import 'package:ensharp/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContactBloc>(
      create: (context) {
        return ContactBloc()..fetch();
      },
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'En#',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.white,
              actions: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext innerContext) {
                        return AlertDialog(
                          title: Text('배고프신가요?'),
                          content: SingleChildScrollView(
                            child: Text(
                              '누구에게 전화를 걸어야 할 지 모르겠다구요? 제게 맡겨주세요!',
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: new Text('맡겨본다'),
                              onPressed: () {
                                Navigator.pop(innerContext);
                                final contactList = context.read<ContactBloc>().contactListNotifier.value;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                      contactModel: contactList[Random().nextInt(contactList.length)],
                                    ),
                                  ),
                                );
                              },
                            ),
                            FlatButton(
                              child: new Text(
                                'Close',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/fishing.svg',
                    width: 30,
                    height: 30,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            body: Builder(
              builder: (context) {
                final contactList = context.watch<ContactBloc>().contactListNotifier.value;
                return SafeArea(
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),

                          ///// api 에러 여부
                          child: BGConditionalChild(
                            condition: context.select(
                              (ContactBloc bloc) {
                                return bloc.screenStateNotifier.value == ScreenStateType.error;
                              },
                            ),

                            ///// 에러났다면
                            whenTrue: Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<ContactBloc>().fetch();
                                    },
                                    child: SvgPicture.asset(
                                      'assets/refresh.svg',
                                      width: 25,
                                      height: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    '에러가 발생했어요. 계속 지속된다면 개발자에게 문의..해..줘..요...',
                                  ),
                                ],
                              ),
                            ),

                            ///// 에러가 아니라면 >> placeholder 여부
                            whenFalse: BGConditionalChild(
                              condition: context.select(
                                (ContactBloc bloc) {
                                  return bloc.screenStateNotifier.value == ScreenStateType.placeholder;
                                },
                              ),

                              ///// placeholder 상태라면
                              whenTrue: SizedBox(
                                width: constraints.maxWidth,
                                height: constraints.maxHeight,
                                child: Center(child: CircularProgressIndicator()),
                              ),

                              ///// api를 성공적으로 가져왔다면
                              whenFalse: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),

                                  ////// 총 인원
                                  Text(
                                    '총 인원 ${contactList.length}',
                                    style: TextStyle(
                                      color: Color(0xff666666),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  ///// 사람 리스트
                                  ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: contactList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => ProfileScreen(
                                                contactModel: contactList[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: SizedBox(
                                          height: 48,
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              ///// 프로필 이미지
                                              SvgPicture.asset(
                                                'assets/user.svg',
                                                width: 35,
                                                height: 35,
                                              ),

                                              SizedBox(
                                                width: 10,
                                              ),

                                              ///// 이름
                                              Text(
                                                '${contactList[index].year} ${contactList[index].name}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),

                                              SizedBox(
                                                width: 10,
                                              ),

                                              ///// 기술
                                              Flexible(
                                                child: Text(
                                                  '${contactList[index].skill.extendEllipsis()}',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff999999),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class BGConditionalChild extends StatelessWidget {
  final bool condition;
  final Widget whenTrue;
  final Widget whenFalse;

  const BGConditionalChild({
    @required this.condition,
    @required this.whenTrue,
    @required this.whenFalse,
  })  : assert(condition != null),
        assert(whenTrue != null || whenFalse != null);

  @override
  Widget build(BuildContext context) {
    return condition ? whenTrue : whenFalse;
  }
}
