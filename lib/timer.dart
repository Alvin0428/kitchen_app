import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final Function incrementCompletedTimers;

  TimerWidget({required this.incrementCompletedTimers});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<TimerEntry> timers = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();

  void _addTimer(String name, Duration duration) {
    final timerEntry = TimerEntry(name: name, initialDuration: duration);
    setState(() {
      timers.add(timerEntry);
    });
  }

  void _startTimer(TimerEntry timerEntry) {
    timerEntry.timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timerEntry.remainingDuration > Duration(seconds: 0)) {
          timerEntry.remainingDuration -= Duration(seconds: 1);
        } else {
          t.cancel();
          _showTimerCompleted(timerEntry.name);
        }
      });
    });
  }

  void _stopTimer(TimerEntry timerEntry) {
    timerEntry.timer?.cancel();
  }

  void _resetTimer(TimerEntry timerEntry) {
    _stopTimer(timerEntry);
    setState(() {
      timerEntry.remainingDuration = timerEntry.initialDuration;
    });
  }

  void _showTimerCompleted(String timerName) {
    widget.incrementCompletedTimers();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$timerName is done!'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _deleteTimer(TimerEntry timerEntry) {
    _stopTimer(timerEntry);
    setState(() {
      timers.remove(timerEntry);
    });
  }

  Duration _getDuration() {
    final hours = int.tryParse(_hoursController.text) ?? 0;
    final minutes = int.tryParse(_minutesController.text) ?? 0;
    final seconds = int.tryParse(_secondsController.text) ?? 0;
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Timer'),
        backgroundColor: Colors.teal[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: timers.length,
                itemBuilder: (context, index) {
                  final timerEntry = timers[index];
                  return Card(
                    child: ListTile(
                      title: Text(timerEntry.name),
                      subtitle: Text(_formatDuration(timerEntry.remainingDuration)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.play_arrow),
                            onPressed: () => _startTimer(timerEntry),
                          ),
                          IconButton(
                            icon: Icon(Icons.stop),
                            onPressed: () => _stopTimer(timerEntry),
                          ),
                          IconButton(
                            icon: Icon(Icons.replay),
                            onPressed: () => _resetTimer(timerEntry),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteTimer(timerEntry),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Timer Name'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _hoursController,
                    decoration: InputDecoration(labelText: 'Hours'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _minutesController,
                    decoration: InputDecoration(labelText: 'Minutes'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _secondsController,
                    decoration: InputDecoration(labelText: 'Seconds'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final duration = _getDuration();
                _addTimer(name, duration);
                _nameController.clear();
                _hoursController.clear();
                _minutesController.clear();
                _secondsController.clear();
              },
              child: Text('Add Timer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[600],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

class TimerEntry {
  String name;
  Duration initialDuration;
  Duration remainingDuration;
  Timer? timer;

  TimerEntry({required this.name, required Duration initialDuration})
      : this.initialDuration = initialDuration,
        this.remainingDuration = initialDuration;
}
