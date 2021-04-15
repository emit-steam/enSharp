import 'package:ensharp/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  final ContactModel contactModel;

  ProfileScreen({
    @required this.contactModel,
  }) : assert(contactModel != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///// 분야
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        '${contactModel.field}'.extendEllipsis(),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    ///// 기술
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        '${contactModel.skill}'.extendEllipsis(),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    ///// 키워드
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        '${contactModel.keyword}'.extendEllipsis(),
                      ),
                    ),

                    SizedBox(
                      height: 100,
                    ),

                    ///// 프로필사진
                    SvgPicture.asset(
                      'assets/user.svg',
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    ///// 이름
                    Text(
                      '${contactModel.year} ${contactModel.name}',
                    ),
                    SizedBox(
                      height: 70,
                    ),

                    ///// 구분선
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: Color(0xffcccccc),
                    ),

                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ///// 보이스피싱
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/fishing.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('배고픔을 호소하기'),
                              ],
                            ),
                          ),

                          ///// 통화
                          GestureDetector(
                            onTap: () {
                              launch('tel://${contactModel.phoneNumber}');
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/call.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('통화하기'),
                                // '${NumberFormat('###,###.##').format(product.price)}원',
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

extension StringUtil on String {
  // https://github.com/flutter/flutter/issues/18761#issuecomment-662509293
  String extendEllipsis() {
    return replaceAll('', '\u{200B}');
  }
}
