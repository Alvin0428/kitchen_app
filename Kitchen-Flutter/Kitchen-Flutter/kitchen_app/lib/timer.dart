import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  final List<TimerItem> _timers = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();

  void _addTimer() {
    final name = _nameController.text;
    final hours = int.tryParse(_hoursController.text) ?? 0;
    final minutes = int.tryParse(_minutesController.text) ?? 0;
    final seconds = int.tryParse(_secondsController.text) ?? 0;
    final totalTime = hours * 3600 + minutes * 60 + seconds;

    if (name.isNotEmpty && totalTime > 0) {
      setState(() {
        _timers.add(TimerItem(name: name, totalTime: totalTime));
        _nameController.clear();
        _hoursController.clear();
        _minutesController.clear();
        _secondsController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Timer name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _hoursController,
                decoration: InputDecoration(
                  labelText: 'HH',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _minutesController,
                decoration: InputDecoration(
                  labelText: 'MM',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _secondsController,
                decoration: InputDecoration(
                  labelText: 'SS',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _addTimer,
          child: Text('Add Timer'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal[600],
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _timers.length,
          itemBuilder: (context, index) {
            return _timers[index];
          },
        ),
      ],
    );
  }
}

class TimerItem extends StatefulWidget {
  final String name;
  final int totalTime;

  TimerItem({required this.name, required this.totalTime});

  @override
  _TimerItemState createState() => _TimerItemState();
}

class _TimerItemState extends State<TimerItem> {
  Timer? _timer;
  late int _remainingTime;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.totalTime;
  }

  void _startTimer() {
    if (_isRunning) return;
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _showNotification();
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    if (!_isRunning) return;
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
  }

  void _resetTimer() {
    setState(() {
      _remainingTime = widget.totalTime;
      _isRunning = false;
    });
    _timer?.cancel();
  }

  void _showNotification() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Timer Done'),
        content: Text('${widget.name} is done!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hours = (_remainingTime ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_remainingTime % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime % 60).toString().padLeft(2, '0');

    return ListTile(
      title: Text(widget.name),
      subtitle: Text('$hours:$minutes:$seconds'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
            onPressed: _isRunning ? _stopTimer : _startTimer,
          ),
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: _resetTimer,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _timer?.cancel();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
