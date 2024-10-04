import 'package:finance_app/src/deposits_page.dart';
import 'package:finance_app/src/insurance_page.dart';
import 'package:finance_app/widgets/gradient_appbar.dart';
import 'package:finance_app/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppbar(title: 'Dashboard', leading: false),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100),
              GradientButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InsurancePage(),
                    ),
                  );
                },
                text: 'Insurance',
                fixedSize: const Size(600, 60),
              ),
              const SizedBox(height: 140),
              GradientButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DepositsPage(),
                    )
                  );
                },
                text: 'Deposits',
                fixedSize: const Size(600, 60),
              ),
            ],
          ),
        ),
      ),
    );
  }
}