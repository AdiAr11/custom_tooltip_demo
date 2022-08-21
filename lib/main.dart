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
  bool isToolTipPaintVisible = true;

  @override
  void initState() {
    super.initState();
    showAndCloseTooltip();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                  visible: isToolTipPaintVisible,
                  child: CustomPaint(painter: Triangle(Colors.black))
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Tooltip(
                  message: "Custom Tooltip by me Aditya Arora",
                  triggerMode: TooltipTriggerMode.manual,
                  key: tooltipkey,
                  preferBelow: false,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: Color(0xff000000),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  margin: const EdgeInsets.only(right: 62, bottom: 6),
                  child: FloatingActionButton(
                    child: const Icon(Icons.abc),
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      showAndCloseTooltip();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future showAndCloseTooltip() async {
    await Future.delayed(Duration(milliseconds: 10));
    // tooltipkey.currentState.ensureTooltipVisible();
    final dynamic tooltip = tooltipkey.currentState;
    tooltip?.ensureTooltipVisible();
    setState(() {
      isToolTipPaintVisible = true;
    });
    await Future.delayed(Duration(seconds: 4));
    // tooltipkey.currentState.deactivate();
    tooltip?.deactivate();
    setState(() {
      isToolTipPaintVisible = false;
    });

  }
}

class Triangle extends CustomPainter {
  final Color backgroundColor;
  Triangle(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = backgroundColor;

    var path = Path();
    path.lineTo(-20, -2);
    path.lineTo(-8, -22);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
