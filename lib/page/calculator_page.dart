import 'package:book_balance/controller/calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final CalculatorController controller = Get.put(CalculatorController());

  double _getFontSize(String output) {
    return output.length > 8 ? 24.0 : 28.0;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Obx(() => Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          controller.output.value,
                          style: TextStyle(
                            fontSize: _getFontSize(controller.output.value),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(() => Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          controller.showGT.value ? "${controller.output.value} GT" : controller.result.value.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: buildButton(
                              buttonColor:  const Color(0xff448fc1),
                              size: const Size(80, 50),
                              textColor: Colors.white,
                              fontSize: 10,
                              buttonText: '←  Check',
                              isInitial: false
                            ),
                          ),
                          const SizedBox(width: 18),
                          Flexible(
                            child: buildButton(
                              buttonColor: const Color(0xff448fc1),
                              size: const Size(80, 50),
                              textColor: Colors.white,
                              fontSize: 10,
                              buttonText: 'Check  →',
                              isInitial: false
                            ),
                          )
                        ],
                      ),
                    ),
                    Obx(() => Flexible(
                      child: buildButton(
                          buttonColor: Colors.white,
                          size: const Size(42, 50),
                          borderColor: controller.output.value == "0" ? Colors.grey : const Color(0xff448fc1),
                          textColor: controller.output.value == "0" ? Colors.grey : const Color(0xff448fc1),
                          fontSize: 16,
                          buttonText: '⌫',
                          isInitial: false
                        ),
                    ))
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Colors.grey),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 8),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 12,
                            buttonText: 'AC'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.blue,
                            textColor: Colors.blue,
                            fontSize: 12,
                            buttonText: 'MRC'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.blue,
                            textColor: Colors.blue,
                            fontSize: 16,
                            buttonText: 'M+'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.blue,
                            textColor: Colors.blue,
                            fontSize: 16,
                            buttonText: 'M-'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.blue,
                            textColor: Colors.blue,
                            fontSize: 12,
                            buttonText: 'GT'
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: buildButton(
                            buttonColor: const Color(0xffaa6767),
                            textColor: Colors.white,
                            fontSize: 20,
                            buttonText: 'C'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.black45,
                            textColor: Colors.black,
                            fontSize: 20,
                            buttonText: '7'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.black45,
                            textColor: Colors.black,
                            fontSize: 20,
                            buttonText: '8'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.black45,
                            textColor: Colors.black,
                            fontSize: 20,
                            buttonText: '9'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.blue,
                            textColor: Colors.blue,
                            fontSize: 24,
                            buttonText: '÷'
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.black,
                            textColor: Colors.black,
                            fontSize: 20,
                            buttonText: '√'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.black45,
                            textColor: Colors.black,
                            fontSize: 20,
                            buttonText: '4'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.black45,
                            textColor: Colors.black,
                            fontSize: 20,
                            buttonText: '5'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.black45,
                            textColor: Colors.black,
                            fontSize: 20,
                            buttonText: '6'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.blue,
                            textColor: Colors.blue,
                            fontSize: 24,
                            buttonText: '×'
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.black,
                            textColor: Colors.black,
                            fontSize: 20,
                            buttonText: '%'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.black45,
                            textColor: Colors.black,
                            fontSize: 20,
                            buttonText: '1'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.black45,
                            textColor: Colors.black,
                            fontSize: 20,
                            buttonText: '2'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.black45,
                            textColor: Colors.black,
                            fontSize: 20,
                            buttonText: '3'
                          ),
                        ),
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.blue,
                            textColor: Colors.blue,
                            fontSize: 24,
                            buttonText: '-'
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: buildButton(
                            buttonColor: Colors.white,
                            borderColor: Colors.black45,
                            textColor: Colors.black,
                            fontSize: 24,
                            buttonText: '.'
                          ),
                        ),
                        buildButton(
                          buttonColor: Colors.white,
                          borderColor: Colors.black45,
                          textColor: Colors.black,
                          fontSize: 20,
                          buttonText: '0'
                        ),
                        buildButton(
                          buttonColor: Colors.white,
                          borderColor: Colors.black45,
                          textColor: Colors.black,
                          fontSize: 20,
                          buttonText: '00'
                        ),
                        buildButton(
                          buttonColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 24,
                          buttonText: '='
                        ),
                        buildButton(
                          buttonColor: Colors.white,
                          borderColor: Colors.blue,
                          textColor: Colors.blue,
                          fontSize: 24,
                          buttonText: '+'
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildButton({
  required Color buttonColor,
  Size? size,
  Color? borderColor,
  required Color textColor,
  required double fontSize,
  required String buttonText,
  bool isInitial = true
}) {
    return ElevatedButton(
      onPressed: () => controller.buttonPressed(buttonText),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        elevation: 0,
        minimumSize: size ?? const Size(48, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        side: BorderSide(color: borderColor ?? Colors.transparent)
      ),
      child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold
          ),
        )
    );
  }
}