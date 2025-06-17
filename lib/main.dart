import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = '0';
  String _output = '0';
  double num1 = 0;
  double num2 = 0;
  String operand = '';

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '0';
        num1 = 0;
        num2 = 0;
        operand = '';
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '/' ||
          buttonText == '*') {
        num1 = double.parse(_output);
        operand = buttonText;
        _output = '0';
      } else if (buttonText == '.') {
        if (!_output.contains('.')) {
          _output += '.';
        }
      } else if (buttonText == '=') {
        num2 = double.parse(_output);

        if (operand == '+') {
          _output = (num1 + num2).toString();
        } else if (operand == '-') {
          _output = (num1 - num2).toString();
        } else if (operand == '*') {
          _output = (num1 * num2).toString();
        } else if (operand == '/') {
          _output = num2 != 0 ? (num1 / num2).toString() : 'Error';
        }

        num1 = 0;
        num2 = 0;
        operand = '';
      } else {
        if (_output == '0') {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }

      output = _output;
    });
  }

  Widget buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: const EdgeInsets.all(22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Calculator', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[850],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              output,
              style: const TextStyle(color: Colors.white, fontSize: 48),
            ),
          ),
          const Divider(color: Colors.grey),
          Column(
            children: [
              Row(
                children: [
                  buildButton('7', Colors.grey[800]!),
                  buildButton('8', Colors.grey[800]!),
                  buildButton('9', Colors.grey[800]!),
                  buildButton('/', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('4', Colors.grey[800]!),
                  buildButton('5', Colors.grey[800]!),
                  buildButton('6', Colors.grey[800]!),
                  buildButton('*', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('1', Colors.grey[800]!),
                  buildButton('2', Colors.grey[800]!),
                  buildButton('3', Colors.grey[800]!),
                  buildButton('-', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('C', Colors.red),
                  buildButton('0', Colors.grey[800]!),
                  buildButton('.', Colors.grey[800]!),
                  buildButton('+', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('=', Colors.green),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
