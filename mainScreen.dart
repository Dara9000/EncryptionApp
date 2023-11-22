import 'package:encr/control/lightMode.dart';
import 'package:encr/model/eyeShape.dart';
import 'package:encr/model/pickAFileButton.dart';
import 'package:encr/model/switchBut.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const defaultPadding = EdgeInsets.all(8.0);

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: const [
          SimpleSwitchDarkMode(),
        ],
        title: FittedBox(
          fit: BoxFit.contain,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(
                Icons.lock_outlined,
                color: Colors.green,
              ),
              Text(' Encryption & Decryption ',
                  style: TextStyle(color: Colors.green)),
            ],
          ),
        ),
      ),
      //=================[BODY]========[BODY]======================
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: PickAFileButton(context),
        ),
      ),
    );
  }
}

class SimpleSwitchDarkMode extends StatelessWidget {
  const SimpleSwitchDarkMode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Padding(
        padding: defaultPadding,
        child: EyeShape(
          child: SimpleSwitch(
            value: true,
            onChanged: (value) async {
              Provider.of<LightMode>(context, listen: false).toggleTheme();
            },
          ),
        ),
      ),
    );
  }
}
