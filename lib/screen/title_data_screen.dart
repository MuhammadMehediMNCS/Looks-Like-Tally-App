import 'package:book_balance/controller/title_controller.dart';
import 'package:book_balance/widget/button_widget.dart';
import 'package:book_balance/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class TitleDataScreen extends StatefulWidget {
  const TitleDataScreen({super.key});

  @override
  State<TitleDataScreen> createState() => _TitleDataScreenState();
}

class _TitleDataScreenState extends State<TitleDataScreen> {
  final TextEditingController textController = TextEditingController();
  final TitleController title = Get.put(TitleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Your Institute Name',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFieldWidget(
              title: 'Institute Name',
              controller: textController
            ),
            ButtonWidget(
              title: 'Submit',
              onPressed: () {
                title.setText(textController.text);
                Get.back();
              }
            )
            
          ],
        ),
      ),
    );
  }
}