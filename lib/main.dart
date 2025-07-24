import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  static const _operators = ['÷', '×', '-', '+'];
  static const _specialButtons = ['C', '+/-', '%'];

  String _currentInput = '';
  String _fullExpression = '';
  String _result = '';
  String? _currentOperation;
  double? _firstNumber;
  bool _showResult = false;

  @override
  Widget build(BuildContext context) {
    final buttonSize = MediaQuery.of(context).size.width / 4.5;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [_buildDisplay(), _buildButtonGrid(buttonSize)],
        ),
      ),
    );
  }

  Widget _buildDisplay() {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (_fullExpression.isNotEmpty)
              Container(
                alignment: Alignment.topRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    _fullExpression,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                _showResult
                    ? _result
                    : _currentInput.isEmpty
                    ? '0'
                    : _currentInput,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _showResult ? 48 : 64,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonGrid(double buttonSize) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildButtonRow(['C', '+/-', '%', '÷'], buttonSize),
            _buildButtonRow(['7', '8', '9', '×'], buttonSize),
            _buildButtonRow(['4', '5', '6', '-'], buttonSize),
            _buildButtonRow(['1', '2', '3', '+'], buttonSize),
            _buildBottomRow(buttonSize),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons, double buttonSize) {
    return Expanded(
      child: Row(
        children: buttons
            .map((button) => _buildButton(button, buttonSize))
            .toList(),
      ),
    );
  }

  Widget _buildBottomRow(double buttonSize) {
    return Expanded(
      child: Row(
        children: [
          _buildWideButton('0', buttonSize),
          _buildButton('.', buttonSize),
          _buildButton('=', buttonSize),
        ],
      ),
    );
  }

  Widget _buildButton(String text, double buttonSize) {
    final buttonColor = _getButtonColor(text);
    final textColor = Colors.white;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          color: buttonColor,
          borderRadius: BorderRadius.circular(buttonSize / 2),
          child: InkWell(
            onTap: () => _handleButtonPress(text),
            borderRadius: BorderRadius.circular(buttonSize / 2),
            child: Container(
              height: buttonSize,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: buttonSize * 0.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWideButton(String text, double buttonSize) {
    final buttonColor = _getButtonColor(text);
    final textColor = Colors.white;

    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          color: buttonColor,
          borderRadius: BorderRadius.circular(buttonSize / 2),
          child: InkWell(
            onTap: () => _handleButtonPress(text),
            borderRadius: BorderRadius.circular(buttonSize / 2),
            child: Container(
              height: buttonSize,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: buttonSize * 0.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(String text) {
    if (_operators.contains(text)) return Colors.orange;
    if (_specialButtons.contains(text)) return Colors.grey[700]!;
    if (text == '=') return Colors.orange;
    return Colors.grey[800]!;
  }

  void _handleButtonPress(String buttonText) {
    setState(() {
      try {
        if (buttonText == 'C') {
          _resetCalculator();
        } else if (buttonText == '+/-') {
          _toggleSign();
        } else if (buttonText == '%') {
          _calculatePercentage();
        } else if (buttonText == '.') {
          _addDecimal();
        } else if (_operators.contains(buttonText)) {
          _setOperation(buttonText);
        } else if (buttonText == '=') {
          _calculateResult();
        } else {
          _appendNumber(buttonText);
        }
      } catch (e) {
        _result = 'Error';
        _showResult = true;
        _firstNumber = null;
        _currentOperation = null;
      }
    });
  }

  void _resetCalculator() {
    _currentInput = '';
    _fullExpression = '';
    _result = '';
    _currentOperation = null;
    _firstNumber = null;
    _showResult = false;
  }

  void _toggleSign() {
    if (_currentInput.isNotEmpty && _currentInput != '0') {
      _currentInput = _currentInput.startsWith('-')
          ? _currentInput.substring(1)
          : '-$_currentInput';
    }
  }

  void _calculatePercentage() {
    if (_currentInput.isEmpty) return;
    final value = double.parse(_currentInput);
    _currentInput = (value / 100).toString();
    _cleanUpCurrentInput();
  }

  void _addDecimal() {
    if (!_currentInput.contains('.')) {
      _currentInput = _currentInput.isEmpty ? '0.' : '$_currentInput.';
    }
  }

  void _setOperation(String operation) {
    if (_currentInput.isEmpty) {
      if (_fullExpression.isNotEmpty) {
        _currentOperation = operation;
        _fullExpression = '$_fullExpression$operation';
      }
      return;
    }

    if (_firstNumber == null) {
      _firstNumber = double.parse(_currentInput);
      _fullExpression = _currentInput;
    } else if (!_showResult) {
      _calculateResult();
    }

    _currentOperation = operation;
    _fullExpression = '$_fullExpression$operation';
    _currentInput = '';
    _showResult = false;
  }

  void _calculateResult() {
    if (_currentOperation == null || _firstNumber == null) return;

    if (_currentInput.isEmpty) {
      _currentInput = _firstNumber.toString();
    }

    final secondNumber = double.parse(_currentInput);
    double result;

    switch (_currentOperation) {
      case '+':
        result = _firstNumber! + secondNumber;
        break;
      case '-':
        result = _firstNumber! - secondNumber;
        break;
      case '×':
        result = _firstNumber! * secondNumber;
        break;
      case '÷':
        if (secondNumber == 0) {
          throw Exception('Division by zero');
        }
        result = _firstNumber! / secondNumber;
        break;
      default:
        result = secondNumber;
    }

    _result = result.toString();
    _cleanUpResult();
    _fullExpression = '$_fullExpression$_currentInput';
    _currentInput = _result;
    _firstNumber = result;
    _showResult = true;
  }

  void _appendNumber(String number) {
    if (_showResult) {
      _resetCalculator();
    }
    _currentInput = _currentInput == '0' ? number : '$_currentInput$number';
  }

  void _cleanUpCurrentInput() {
    if (_currentInput.endsWith('.0')) {
      _currentInput = _currentInput.substring(0, _currentInput.length - 2);
    } else if (_currentInput.contains('.')) {
      final parts = _currentInput.split('.');
      if (parts[1].length > 5) {
        _currentInput = parts[0] + '.' + parts[1].substring(0, 5);
      }
    }
  }

  void _cleanUpResult() {
    if (_result.endsWith('.0')) {
      _result = _result.substring(0, _result.length - 2);
    } else if (_result.contains('.')) {
      final parts = _result.split('.');
      if (parts[1].length > 5) {
        _result = parts[0] + '.' + parts[1].substring(0, 5);
      }
    }
  }
}
