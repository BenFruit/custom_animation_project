import 'package:flutter/material.dart';

class CircleCheckBox extends StatefulWidget {
  const CircleCheckBox(
      {Key? key,
      this.outlineColor = Colors.green,
      this.fillColor = Colors.white,
      this.tickColor = Colors.white,
      required this.duration,
      required this.value,
      required this.groupValue,
      required this.onValueChanged})
      : super(key: key);
  final Color outlineColor;
  final Color tickColor;
  final Color fillColor;
  final String value;
  final String groupValue;
  final int duration;
  final ValueChanged<String> onValueChanged;
  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CircleCheckBox>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> iconAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    animation = Tween<double>(begin: 14, end: 0).animate(animationController);
    iconAnimation =
        Tween<double>(begin: 0, end: 2).animate(animationController);
    super.initState();
  }

  void changeValue() {
    widget.onValueChanged(widget.value);
  }

  void checkValue() {
    if (widget.value == widget.groupValue) {
      animationController.forward();
    } else if (widget.value != widget.groupValue) {
      animationController.reverse();
    }
    if (widget.groupValue == '') {}
    animationController.addListener(() {
      print(animationController.value);
    });
    animationController.duration = Duration(milliseconds: widget.duration);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkValue();
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        changeValue();
      },
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, animWidget) => CustomPaint(
          child: SizedBox(
            height: 30,
            width: 30,
          ),
          painter: _RoundCheckBoxPainter(
            outlineColor: widget.outlineColor,
            fillColor: widget.fillColor,
            radius: animation.value,
            animValue: animationController.value,
          ),
        ),
      ),
    );
  }
}

class _RoundCheckBoxPainter extends CustomPainter {
  final Color outlineColor;
  final double radius;
  final Color fillColor;
  final double animValue;

  _RoundCheckBoxPainter({
    required this.outlineColor,
    required this.radius,
    required this.fillColor,
    required this.animValue,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var bigCircle = Paint()
      ..color = outlineColor
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    var smallCircle = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    var iconPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2 * animValue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(15, 15);
    Offset centerForIcon = Offset(13, 19);

    canvas.drawCircle(center, 15, bigCircle);
    canvas.drawCircle(center, radius, smallCircle);
    var path1 = Path();

    Offset startPoint = Offset(centerForIcon.dx - 3.5, centerForIcon.dy - 3.5);
    path1.moveTo(startPoint.dx, startPoint.dy);
    path1.lineTo(centerForIcon.dx, centerForIcon.dy);
    path1.lineTo(centerForIcon.dx + 8, centerForIcon.dy - 8);
    //path1.close();
    canvas.drawPath(path1, iconPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
