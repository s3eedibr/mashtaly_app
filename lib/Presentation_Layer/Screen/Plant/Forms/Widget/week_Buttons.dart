import 'package:flutter/material.dart';
import '../../../../../Constants/colors.dart';

class WeekButtonsWidget extends StatefulWidget {
  const WeekButtonsWidget({Key? key}) : super(key: key);

  @override
  _WeekButtonsWidgetState createState() => _WeekButtonsWidgetState();
}

class _WeekButtonsWidgetState extends State<WeekButtonsWidget> {
  int selectedWeek = 1;
  void selectWeek(int weekNumber) {
    setState(() {
      selectedWeek = weekNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 16),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final List<String> weekNum = [
              'Week 1',
              'Week 2',
              'Week 3',
              'Week 4'
            ];
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedWeek = index + 1;
                    selectWeek(selectedWeek);
                  });
                },
                child: Container(
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: selectedWeek == index + 1
                        ? tPrimaryActionColor
                        : tBgColor,
                    border: selectedWeek == index + 1
                        ? Border.all(color: Colors.transparent)
                        : Border.all(width: 1, color: tSearchIconColor),
                  ),
                  child: Center(
                    child: Text(
                      weekNum[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: selectedWeek == index + 1
                            ? FontWeight.w800
                            : FontWeight.w600,
                        color: selectedWeek == index + 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
