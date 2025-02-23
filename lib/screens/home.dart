import 'package:care_bridge/res/color.dart';
import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> medications = [
    {"medicine": "Paracetamol", "time": "8:00 AM"},
    {"medicine": "Vitamin D", "time": "12:00 PM"},
    {"medicine": "Antibiotic", "time": "6:00 PM"},
  ];

  void _addReminder() {
    setState(() {
      medications.add({"medicine": "New Medicine", "time": "10:00 PM"});
    });
  }

  void _setAlarm(String time) async {
    List<String> timeParts = time.split(":");
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1].split(" ")[0]);

    if (time.contains("PM") && hour != 12) hour += 12;
    if (time.contains("AM") && hour == 12) hour = 0;

    final intent = AndroidIntent(
      action: 'android.intent.action.SET_ALARM',
      arguments: {
        'android.intent.extra.alarm.HOUR': hour,
        'android.intent.extra.alarm.MINUTES': minute,
        'android.intent.extra.alarm.MESSAGE': "Time to take your medicine!",
      },
    );
    await intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Welcome to CareBridge',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Therapist Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Dr. Sophia Williams",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Available: 3:00 PM - 6:00 PM",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle booking logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.selectedItem,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Book Therapist",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Medication Reminders Section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Medication Reminders",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: medications.length,
                itemBuilder: (context, index) {
                  return MedicationReminderCard(
                    medicineName: medications[index]["medicine"]!,
                    time: medications[index]["time"]!,
                    onSetAlarm: () => _setAlarm(medications[index]["time"]!),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button to Add Reminders
      floatingActionButton: FloatingActionButton(
        onPressed: _addReminder,
        backgroundColor: AppColors.selectedItem,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// Medication Reminder Card Widget
class MedicationReminderCard extends StatelessWidget {
  final String medicineName;
  final String time;
  final VoidCallback onSetAlarm;

  const MedicationReminderCard({
    super.key,
    required this.medicineName,
    required this.time,
    required this.onSetAlarm,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.medication, color: AppColors.selectedItem, size: 30),
        title: Text(
          medicineName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Time: $time",
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.alarm, color: Colors.red),
          onPressed: onSetAlarm,
        ),
      ),
    );
  }
}
