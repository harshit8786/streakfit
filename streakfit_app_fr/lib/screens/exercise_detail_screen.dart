import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise ex;

  const ExerciseDetailScreen({super.key, required this.ex});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  final ApiService _api = ApiService();
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _isRunning = false;
  bool _isCompleting = false;
  bool _isMarkedComplete = false;
  bool _warmUpDone = false;
  int _setsDone = 0;

  int get _recommendedSeconds => widget.ex.duration * 60;

  double get _progress {
    if (_recommendedSeconds <= 0) {
      return 0;
    }

    final value = _elapsed.inSeconds / _recommendedSeconds;
    return value.clamp(0, 1).toDouble();
  }

  String _formatDuration(Duration value) {
    final hours = value.inHours.toString().padLeft(2, '0');
    final minutes = (value.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (value.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  int get _estimatedCalories {
    final minutes = _elapsed.inMinutes > 0 ? _elapsed.inMinutes : widget.ex.duration;
    return (minutes * 6).clamp(12, 600);
  }

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
      });
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _elapsed += const Duration(seconds: 1);
      });
    });

    setState(() {
      _isRunning = true;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _elapsed = Duration.zero;
      _setsDone = 0;
      _warmUpDone = false;
    });
  }

  Future<void> _markComplete() async {
    final auth = context.read<AuthProvider>();
    if (auth.user == null || _isCompleting || _isMarkedComplete) {
      return;
    }

    setState(() {
      _isCompleting = true;
    });

    try {
      final response = await _api.markComplete(auth.user!.token, widget.ex.id);
      if (!mounted) {
        return;
      }
      setState(() {
        _isMarkedComplete = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Marked complete')),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isCompleting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.ex.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.ex.id,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.ex.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoChip(icon: Icons.access_time, label: '${widget.ex.duration} min'),
                _InfoChip(icon: Icons.fitness_center, label: widget.ex.target),
                _InfoChip(icon: Icons.calendar_today, label: widget.ex.day),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.ex.description,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Workout Stopwatch',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        _formatDuration(_elapsed),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: _progress,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Recommended duration: ${widget.ex.duration} min',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _toggleTimer,
                            icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                            label: Text(_isRunning ? 'Pause' : 'Start'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _resetTimer,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reset'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Calories',
                    value: '$_estimatedCalories kcal',
                    icon: Icons.local_fire_department,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Sets Done',
                    value: '$_setsDone',
                    icon: Icons.repeat,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quick Actions',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Warm-up completed'),
                      subtitle: const Text('Use this before you begin the exercise'),
                      value: _warmUpDone,
                      onChanged: (value) {
                        setState(() {
                          _warmUpDone = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add completed sets',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [1, 2, 3].map((count) {
                        return ActionChip(
                          label: Text('+${count} set${count > 1 ? 's' : ''}'),
                          onPressed: () {
                            setState(() {
                              _setsDone += count;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Workout Tips',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('Maintain controlled form instead of rushing reps.'),
                    SizedBox(height: 6),
                    Text('Rest 30-60 seconds between light sets and longer after hard sets.'),
                    SizedBox(height: 6),
                    Text('Hydrate and stop immediately if you feel sharp pain.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _markComplete,
                icon: _isCompleting
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(_isMarkedComplete ? Icons.check_circle : Icons.check),
                label: Text(_isMarkedComplete ? 'Completed' : 'Mark Complete'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
