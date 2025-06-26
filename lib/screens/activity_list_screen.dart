import 'package:flutter/material.dart';
import '../data/activities.dart';
import 'congrats_screen.dart';
import 'activity_view_screen.dart';




class ActivityListScreen extends StatefulWidget {
  final int group;

  const ActivityListScreen({super.key, required this.group});

  @override
  State<ActivityListScreen> createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends State<ActivityListScreen> {
  @override
  Widget build(BuildContext context) {
    final activities = activityGroups[widget.group];

    return Scaffold(
      appBar: AppBar(
        title: Text("Actividades del Grupo ${widget.group + 1}"),
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          final enabled = index == 0 || activities[index - 1].isCompleted;

          return ListTile(
            title: Text(activity.title),
            subtitle: Text(activity.description),
            trailing: Icon(
              enabled
                  ? (activity.isCompleted ? Icons.check_circle : Icons.lock_open)
                  : Icons.lock,
            ),
            onTap: enabled
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ActivityViewScreen(
                          activity: activity,
                          onComplete: () {
                            setState(() {
                              activity.isCompleted = true;

                              final allCompleted =
                                  activities.every((a) => a.isCompleted);

                              if (allCompleted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CongratsScreen(),
                                  ),
                                );
                              } else {
                                Navigator.pop(context);
                              }
                            });
                          },
                        ),
                      ),
                    );
                  }
                : null,
          );
        },
      ),
    );
  }
}
