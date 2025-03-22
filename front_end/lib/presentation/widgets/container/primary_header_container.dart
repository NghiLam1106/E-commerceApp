import 'package:flutter/material.dart';
import 'package:front_end/core/constants/colors.dart';
import 'package:front_end/presentation/widgets/container/circular_container.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
        child: SizedBox(
      height: 400,
      child: Container(
        color: AppColors.primary,
        child: Stack(
          children: [
            Positioned(
                top: -150,
                right: -250,
                child: AppCircularContainer(
                    backgroundColor: AppColors.textWhite.withOpacity(0.1))),
            Positioned(
                top: 100,
                right: 300,
                child: AppCircularContainer(
                    backgroundColor: AppColors.textWhite.withOpacity(0.1))),
            child
          ],
        ),
      ),
    ));
  }
}

class CurvedEdgeWidget extends StatelessWidget {
  const CurvedEdgeWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdges(),
      child: child,
    );
  }
}

class CustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(0, size.height - 20);
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondfirstCurve = Offset(0, size.height - 20);
    final secondlastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondfirstCurve.dx, secondfirstCurve.dy,
        secondlastCurve.dx, secondlastCurve.dy);

    final thirdfirstCurve = Offset(size.width, size.height - 20);
    final thirdlastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdfirstCurve.dx, thirdfirstCurve.dy,
        thirdlastCurve.dx, thirdlastCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    throw path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw true;
  }
}
