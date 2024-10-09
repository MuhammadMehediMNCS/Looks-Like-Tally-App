import 'package:get/get.dart';
import 'dart:math';

class CalculatorController extends GetxController {
  var output = "0".obs;
  var result = 0.0.obs;
  var memory = 0.0.obs;
  var operation = RxnString();
  var history = <String>[].obs;
  var historyIndex = (-1).obs;
  var resultList = <double>[].obs;
  var showGT = false.obs;

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      output.value = "0";
      result.value = 0.0;
      operation.value = null;
    } else if (buttonText == "AC") {
      output.value = "0";
      result.value = 0.0;
      operation.value = null;
      history.clear();
      historyIndex.value = -1;
      resultList.clear();
      showGT.value = false;
    } else if (buttonText == "←  Check") {
      if (historyIndex.value > 0) {
        historyIndex.value--;
        output.value = history[historyIndex.value].toString();
      }
    } else if (buttonText == "Check  →") {
      if (historyIndex.value < history.length - 1) {
        historyIndex.value++;
        output.value = history[historyIndex.value].toString();
      }
    } else if (buttonText == "⌫") {
      if (output.value.length > 1) {
        output.value = output.value.substring(0, output.value.length - 1);
      } else {
        output.value = "0";
      }
    } else if (buttonText == "GT") {
      double sum = resultList.fold(0.0, (acc, val) => acc + val);
      output.value = sum.toString();
    } else if (buttonText == "M+") {
      memory.value += double.tryParse(output.value) ?? 0.0;
      output.value = "0";
      result.value = 0;
    } else if (buttonText == "M-") {
      memory.value -= double.tryParse(output.value) ?? 0.0;
      output.value = "0";
      result.value = 0;
    } else if (buttonText == "MRC") {
      output.value = memory.toString();
      memory.value = 0;
    } else if (buttonText == "%") {
      if (operation.value != null) {
        result.value = _calculate(result.value, double.tryParse(output.value) ?? 0.0, operation.value!);
        operation.value = null;
        output.value = result.toString();
      }
      result.value = (double.tryParse(output.value) ?? 0.0) / 100;
      output.value = result.toString();
    } else if (buttonText == "√") {
      result.value = sqrt(double.tryParse(output.value) ?? 0.0);
      output.value = result.toString();
    } else if (buttonText == "=") {
      if (operation.value != null) {
        result.value = _calculate(result.value, double.tryParse(output.value) ?? 0.0, operation.value!);
        operation.value = null;
        output.value = result.toString();
      }
      resultList.add(result.value);
      _addToHistory(output.value);
      showGT.value = true;
    } else if (["+", "-", "×", "÷"].contains(buttonText)) {
      if (operation.value != null) {
        result.value = _calculate(result.value, double.tryParse(output.value) ?? 0.0, operation.value!);
        operation.value = null;
        output.value = result.toString();
      }
      _addToHistory(output.value);
      result.value = double.tryParse(output.value) ?? 0.0;
      operation.value = buttonText;
      output.value = "0";
      showGT.value = false;
    } else {
      if (output.value == "0") {
        output.value = buttonText;
      } else if (output.value.length < 15) {
        output.value += buttonText;
      }
    }
  }

  void _addToHistory(String value) {
    if (value.isNotEmpty) {
      if (historyIndex.value == history.length - 1) {
        history.add(value);
      } else {
        history[historyIndex.value + 1] = value;
        history.removeRange(historyIndex.value + 2, history.length);
      }
      historyIndex.value = history.length - 1;
    }
  }

  double _calculate(double num1, double num2, String operation) {
    switch (operation) {
      case "+":
        return num1 + num2;
      case "-":
        return num1 - num2;
      case "×":
        return num1 * num2;
      case "÷":
        return num1 / num2;
      default:
        return num2;
    }
  }
}