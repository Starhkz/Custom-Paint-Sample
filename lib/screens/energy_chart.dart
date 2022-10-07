import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class EnergyChart extends StatefulWidget {
  const EnergyChart({Key? key}) : super(key: key);

  @override
  State<EnergyChart> createState() => _EnergyChartState();
}

class _EnergyChartState extends State<EnergyChart> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double halfsize = size.width / 4;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text(size.toString())),
          Transform.translate(
            offset: Offset(-halfsize + 20, 0),
            child: CustomPaint(
              painter: Chart(50, true),
            ),
          ),
        ],
      ),
    );
  }
}

class Chart extends CustomPainter {
  final double radius;
  final bool isLocked;

  Chart(this.radius, this.isLocked);
  @override
  void paint(Canvas canvas, Size size) {
    Color gridColor, solarColor, percentColor, homeColor;
    gridColor = const Color.fromARGB(255, 2, 2, 32);
    solarColor = const Color.fromARGB(255, 228, 141, 11);
    percentColor = const Color.fromARGB(255, 11, 228, 109);
    homeColor = const Color.fromARGB(255, 49, 17, 161);
    Offset origin,
        solarOffset,
        percentageOffset,
        homeOffset,
        gridHomeOA,
        gridHomeEndA,
        gridHomeOB,
        gridHomeEndB,
        gridPerOA,
        gridPerEndA,
        gridPerOB,
        gridPerEndB,
        solarHomeOA,
        solarHomeEndA,
        solarHomeOB,
        solarHomeEndB,
        solarPerOA,
        solarPerEndA,
        solarPerOB,
        solarPerEndB;
    double xOffset,
        circleThickness,
        lineThickness,
        smallDiameter,
        dist1,
        dist2,
        dist3,
        gap;

    smallDiameter = radius * 1.5;
    circleThickness = 10;
    lineThickness = circleThickness / 2;
    gap = 10;
    xOffset = radius;
    dist1 = radius * 3;
    dist2 = radius * 4;
    dist3 = (radius);
    origin = Offset(xOffset + 20, xOffset + 20);
    solarOffset = origin + Offset(origin.dx + dist1, 0);
    percentageOffset =
        origin + Offset(origin.dx + dist3 - (circleThickness), dist1);
    homeOffset = percentageOffset + Offset(0, dist2);

    gridHomeOA = origin + Offset(0 - (gap), radius);
    gridHomeEndA = gridHomeOA + Offset(0, (radius * 6) - smallDiameter / 2);

    gridHomeOB = gridHomeEndA + Offset(smallDiameter / 2, smallDiameter / 2);
    gridHomeEndB = homeOffset - Offset(radius, 0);

    gridPerOA = origin + Offset(0, radius);
    gridPerEndA = gridPerOA + Offset(0, (radius * 2) - smallDiameter / 2);

    gridPerOB = gridPerEndA + Offset(smallDiameter / 2, smallDiameter / 2);
    gridPerEndB = percentageOffset - Offset(radius, 0);

    solarPerOA = origin + Offset(origin.dx + dist1, radius);
    solarPerEndA = solarPerOA + Offset(0, (radius * 2) - smallDiameter / 2);

    solarPerOB = solarPerEndA + Offset(-smallDiameter / 2, smallDiameter / 2);
    solarPerEndB = percentageOffset - Offset(-radius, 0);

    solarHomeOA = origin + Offset(origin.dx + dist1 + gap, radius);
    solarHomeEndA = solarHomeOA + Offset(0, (radius * 6) - smallDiameter / 2);

    solarHomeOB = solarHomeEndA + Offset(-smallDiameter / 2, smallDiameter / 2);
    solarHomeEndB = homeOffset - Offset(-radius, 0);

    Rect arcgridHomeRect = gridHomeEndA + Offset(0, -smallDiameter / 2) &
        Size(smallDiameter, smallDiameter);
    Rect arcGridPerRect = gridPerEndA + Offset(0, -smallDiameter / 2) &
        Size(smallDiameter, smallDiameter);
    Rect arcSolarPerRect =
        solarPerEndA + Offset(-smallDiameter, -smallDiameter / 2) &
            Size(smallDiameter, smallDiameter);
    Rect arcSolarHomeRect =
        solarHomeEndA + Offset(-smallDiameter, -smallDiameter / 2) &
            Size(smallDiameter, smallDiameter);

    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = (isLocked ? gridColor : Colors.teal)
      ..strokeWidth = circleThickness;

    final gridLine = Paint()
      ..style = PaintingStyle.stroke
      ..color = (isLocked ? gridColor : Colors.teal)
      ..strokeWidth = lineThickness;

    final solarLine = Paint()
      ..style = PaintingStyle.stroke
      ..color = (isLocked ? solarColor : Colors.teal)
      ..strokeWidth = lineThickness;
    final perLine = Paint()
      ..style = PaintingStyle.stroke
      ..color = (isLocked ? percentColor : Colors.teal)
      ..strokeWidth = lineThickness;
    final homeLine = Paint()
      ..style = PaintingStyle.stroke
      ..color = (isLocked ? homeColor : Colors.teal)
      ..strokeWidth = lineThickness;

    final solarPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color =
          (isLocked ? const Color.fromARGB(255, 228, 141, 11) : Colors.teal)
      ..strokeWidth = circleThickness;

    final percentPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = (isLocked ? percentColor : Colors.teal)
      ..strokeWidth = circleThickness;

    final homePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = (isLocked ? homeColor : Colors.teal)
      ..strokeWidth = circleThickness;

    final pointPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color =
          (isLocked ? const Color.fromARGB(255, 53, 188, 229) : Colors.teal)
      ..strokeWidth = 20;

    canvas.drawCircle(origin, radius, gridPaint);
    canvas.drawPoints(PointMode.points, [origin], pointPaint);

    canvas.drawCircle(solarOffset, radius, solarPaint);
    canvas.drawPoints(PointMode.points, [solarOffset], pointPaint);

    canvas.drawCircle(percentageOffset, radius, percentPaint);
    canvas.drawPoints(PointMode.points, [percentageOffset], pointPaint);

    canvas.drawCircle(homeOffset, radius, homePaint);
    canvas.drawPoints(PointMode.points, [homeOffset], pointPaint);

    canvas.drawLine(gridHomeOA, gridHomeEndA, gridLine);
    canvas.drawArc(
        arcgridHomeRect, toRadian(90), toRadian(90), false, gridLine);

    canvas.drawLine(gridHomeOB, gridHomeEndB, homeLine);

    canvas.drawLine(gridPerOA, gridPerEndA, gridLine);
    canvas.drawArc(arcGridPerRect, toRadian(90), toRadian(90), false, gridLine);

    canvas.drawLine(gridPerOB, gridPerEndB, perLine);

    canvas.drawLine(solarPerOA, solarPerEndA, solarLine);
    canvas.drawArc(
        arcSolarPerRect, toRadian(90), toRadian(-90), false, solarLine);

    canvas.drawLine(solarPerOB, solarPerEndB, perLine);

    canvas.drawLine(solarHomeOA, solarHomeEndA, solarLine);
    canvas.drawArc(
        arcSolarHomeRect, toRadian(90), toRadian(-90), false, solarLine);

    canvas.drawLine(solarHomeOB, solarHomeEndB, homeLine);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

double toRadian(double angle) {
  double rad = angle * (pi / 180);
  return rad;
}
