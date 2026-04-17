import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/exercise_tile.dart';
import '../models/exercise.dart';
import 'exercise_detail_screen.dart';

class DayScreen extends StatefulWidget{ final String day; DayScreen({required this.day}); @override _DayScreenState createState()=> _DayScreenState(); }
class _DayScreenState extends State<DayScreen>{
  late Future<List<Exercise>> _future;
  final api = ApiService();
  @override void initState(){ super.initState(); _future = api.fetchExercisesByDay(widget.day); }
  @override Widget build(BuildContext context){
    final scheme = Theme.of(context).colorScheme;
    if (widget.day == 'Sunday') {
      return Scaffold(
        appBar: AppBar(title: Text(widget.day)),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.spa, size: 72, color: scheme.secondary),
                SizedBox(height: 16),
                Text(
                  'Sunday is Rest Day',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  'Recover, stretch, hydrate, and get ready for the next training week.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('${widget.day}')), body: FutureBuilder<List<Exercise>>(future: _future, builder: (ctx,snap){
        if (snap.connectionState!=ConnectionState.done) return Center(child: CircularProgressIndicator());
        if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));
        final list = snap.data ?? [];
        if (list.isEmpty) return Center(child: Text('No exercises for ${widget.day}'));
        final Map<String, List<Exercise>> grouped = {};
        for (final exercise in list) {
          grouped.putIfAbsent(exercise.target, () => []).add(exercise);
        }

        final targets = grouped.keys.toList()..sort();

        return ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: targets.length,
          itemBuilder: (ctx, i) {
            final target = targets[i];
            final exercises = grouped[target]!;
            return Card(
              margin: EdgeInsets.only(bottom: 16),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        target,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: scheme.primary),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${exercises.length} exercises',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: 8),
                    ...exercises.map((e) => ExerciseTile(
                      ex: e,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ExerciseDetailScreen(ex: e)),
                      ),
                    )),
                  ],
                ),
              ),
            );
          },
        );
      })
    );
  }
}
