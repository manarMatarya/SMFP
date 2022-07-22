import 'package:flutter/material.dart';
import 'package:smfp/view/widgets/scroll_text.dart';
import 'package:smfp/view/widgets/text_utils.dart';

class WhoScreen extends StatelessWidget {
  const WhoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    TextUtils(
                      text: " من نحن",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ScrollText(
                      text: 'حيث ال حياة بدوف عمؿ وحيث أف الفرد يقضي ثمث حياتو في العمؿ والثمثيف اآلخريف مرتبطاف بالثمث'
                              'حيث ال حياة بدوف عمؿ وحيث أف الفرد يقضي ثمث حياتو في العمؿ والثمثيف اآلخريف مرتبطاف بالثمث' +
                          'حيث ال حياة بدوف عمؿ وحيث أف الفرد يقضي ثمث حياتو في العمؿ والثمثيف اآلخريف مرتبطاف بالثمث' +
                          'حيث ال حياة بدوف عمؿ وحيث أف الفرد يقضي ثمث حياتو في العمؿ والثمثيف اآلخريف مرتبطاف بالثمث' +
                          'حيث ال حياة بدوف عمؿ وحيث أف الفرد يقضي ثمث حياتو في العمؿ والثمثيف اآلخريف مرتبطاف بالثمث' +
                          'حيث ال حياة بدوف عمؿ وحيث أف الفرد يقضي ثمث حياتو في العمؿ والثمثيف اآلخريف مرتبطاف بالثمث' +
                          'حيث ال حياة بدوف عمؿ وحيث أف الفرد يقضي ثمث حياتو في العمؿ والثمثيف اآلخريف مرتبطاف بالثمث' +
                          'حيث ال حياة بدوف عمؿ وحيث أف الفرد يقضي ثمث حياتو في العمؿ والثمثيف اآلخريف مرتبطاف بالثمث',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
