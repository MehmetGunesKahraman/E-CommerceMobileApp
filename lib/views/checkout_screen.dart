import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum PaymentType { cash, installment }

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (var i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(digitsOnly[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (var i = 0; i < digitsOnly.length; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(digitsOnly[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  PaymentType _paymentType = PaymentType.cash;
  int _installments = 3;

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _fullNameController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Checkout", style: TextStyle(color: Colors.black)),
        leadingWidth: 20,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              "Payment method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<PaymentType>(
                    value: PaymentType.cash,
                    groupValue: _paymentType,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _paymentType = value;
                      });
                    },
                    title: Text("Cash"),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: RadioListTile<PaymentType>(
                    value: PaymentType.installment,
                    groupValue: _paymentType,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _paymentType = value;
                      });
                    },
                    title: Text("Installment"),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
            if (_paymentType == PaymentType.installment) ...[
              SizedBox(height: 12),
              Text(
                "Installments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: Text("3"),
                    selected: _installments == 3,
                    onSelected: (_) {
                      setState(() {
                        _installments = 3;
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text("6"),
                    selected: _installments == 6,
                    onSelected: (_) {
                      setState(() {
                        _installments = 6;
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text("9"),
                    selected: _installments == 9,
                    onSelected: (_) {
                      setState(() {
                        _installments = 9;
                      });
                    },
                  ),
                ],
              ),
            ],
            SizedBox(height: 16),
            Text(
              "Card details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: "Full name",
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _cardNumberController,
              decoration: InputDecoration(
                labelText: "Card number",
                hintText: "1234 5678 9012 3456",
                border: OutlineInputBorder(),
                isDense: true,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                CardNumberInputFormatter(),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expiryController,
                    decoration: InputDecoration(
                      labelText: "Expiration date",
                      hintText: "MM/YY",
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      ExpiryDateInputFormatter(),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _cvvController,
                    decoration: InputDecoration(
                      labelText: "CVV",
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Mock payment submitted"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Pay now", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
