import 'package:flutter/material.dart';

Widget buildDateRangeInput(
  BuildContext context,
  fromDateController,
  untilDateController,
  showDialogDatePicker,
  from,
  until,
) {
  if (from != null && until != null) {
    fromDateController.text = from;
    untilDateController.text = until;
  }

  return Padding(
    padding: const EdgeInsets.only(right: 16, bottom: 0, left: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildDateRangeInputColumn(
          'From',
          () {
            showDialogDatePicker(context, fromDateController);
          },
          fromDateController,
        ),
        buildDateRangeInputColumn(
          'Until',
          () {
            showDialogDatePicker(context, untilDateController);
          },
          untilDateController,
        ),
      ],
    ),
  );
}

Widget buildDateRangeInputColumn(
    String labelText, VoidCallback onTap, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const SizedBox(height: 25),
      Text(
        labelText,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0x7C0D1904),
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 5),
      SizedBox(
        height: 40,
        width: 150,
        child: TextFormField(
          onTap: onTap,
          readOnly: true,
          controller: controller,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            overflow: TextOverflow.ellipsis,
          ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(
              left: 12,
            ),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
