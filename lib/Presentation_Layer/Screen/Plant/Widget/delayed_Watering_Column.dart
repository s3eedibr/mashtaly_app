import 'package:flutter/material.dart';
import 'package:mashtaly_app/Constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class DelayedWateringColumn extends StatefulWidget {
  final int? days;
  final int? hours;
  final int? minutes;

  const DelayedWateringColumn({
    super.key,
    this.days,
    this.hours,
    this.minutes,
  });
  @override
  State<DelayedWateringColumn> createState() => _DelayedWateringColumnState();
}

class _DelayedWateringColumnState extends State<DelayedWateringColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 40,
            width: 170,
            decoration: const BoxDecoration(
              color: Color(0xffD2D8CF),
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            child: Container(
              height: 40,
              width: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: Center(
                child: Text(
                  '${widget.days} days ${widget.hours}hr ${widget.minutes}min',
                  style: const TextStyle(
                    color: tPrimaryTextColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            )),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

Widget buildShimmerDelayedWatering() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!, // Change this to your desired base color
        highlightColor:
            Colors.grey[100]!, // Change this to your desired highlight color
        child: Container(
          height: 40,
          width: 170,
          decoration: const BoxDecoration(
            color: Color(0xffD2D8CF),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: Container(
            height: 40,
            width: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            child: const Center(
              child: Text(
                '',
                style: TextStyle(
                  color: tPrimaryTextColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
    ],
  );
}
