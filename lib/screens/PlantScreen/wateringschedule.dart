import 'package:flutter/material.dart';
import 'wateringtime.dart';

class WateringSchedule extends StatefulWidget {
  const WateringSchedule({super.key});

  @override
  _WateringScheduleState createState() => _WateringScheduleState();
}

class _WateringScheduleState extends State<WateringSchedule> {
  List<WateringTime> wateringTimes = [];

  void addWateringTime() {
    setState(() {
      wateringTimes.add(WateringTime(time: '', plants: []));
    });
  }

  void editWateringTime(WateringTime wateringTime) {
    setState(() {
      wateringTimes.remove(wateringTime);
      wateringTimes.add(
          WateringTime(time: wateringTime.time, plants: wateringTime.plants));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watering Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: addWateringTime,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: wateringTimes.length,
        itemBuilder: (context, index) {
          return WateringTimeItem(
              wateringTime: wateringTimes[index], onEdit: editWateringTime);
        },
      ),
    );
  }
}

class WateringTimeItem extends StatefulWidget {
  final WateringTime wateringTime;
  final Function(WateringTime wateringTime) onEdit;

  const WateringTimeItem(
      {super.key, required this.wateringTime, required this.onEdit});

  @override
  _WateringTimeItemState createState() => _WateringTimeItemState();
}

class _WateringTimeItemState extends State<WateringTimeItem> {
  bool isEditing = false;

  void editWateringTime() {
    setState(() {
      isEditing = true;
    });
  }

  void saveWateringTime() {
    setState(() {
      isEditing = false;
      widget.onEdit(widget.wateringTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.wateringTime.time),
      subtitle: Text(widget.wateringTime.plants.join(', ')),
      trailing: isEditing
          ? IconButton(
              icon: const Icon(Icons.save),
              onPressed: saveWateringTime,
            )
          : IconButton(
              icon: const Icon(Icons.edit),
              onPressed: editWateringTime,
            ),
    );
  }
}
