import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseTile extends StatelessWidget{
  final Exercise ex;
  final VoidCallback onTap;
  ExerciseTile({required this.ex, required this.onTap});
  @override
  Widget build(BuildContext context){
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.symmetric(vertical:6, horizontal:8),
      child: ListTile(
        title: Text(ex.title),
        subtitle: Text('${ex.target} • ${ex.duration} min'),
        trailing: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: scheme.secondaryContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(Icons.fitness_center, color: scheme.secondary),
        ),
        onTap: onTap,
      ),
    );
  }
}
