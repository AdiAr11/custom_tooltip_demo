import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FloatingSupportButton()
    );
  }
}

class FloatingSupportButton extends StatefulWidget {
  const FloatingSupportButton({Key? key}) : super(key: key);

  @override
  State<FloatingSupportButton> createState() => _FloatingSupportButtonState();
}

class _FloatingSupportButtonState extends State<FloatingSupportButton> {
  // final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
  final tooltipkey = GlobalKey<State<Tooltip>>();

  @override
  void initState() {
    super.initState();
    showAndCloseTooltip();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Tooltip(
          message: "Hello",
          triggerMode: TooltipTriggerMode.manual,
          key: tooltipkey,
          preferBelow: false,
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFFc60c0c),
            onPressed: () {
              showAndCloseTooltip();
            },
          ),
        ),
      ),
    );
  }

  Future showAndCloseTooltip() async {
    await Future.delayed(const Duration(milliseconds: 10));
    // tooltipkey.currentState.ensureTooltipVisible();
    final dynamic tooltip = tooltipkey.currentState;
    tooltip?.ensureTooltipVisible();
    await Future.delayed(const Duration(seconds: 4));
    // tooltipkey.currentState.deactivate();
    tooltip?.deactivate();
  }
}

