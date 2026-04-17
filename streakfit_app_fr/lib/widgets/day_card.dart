import 'package:flutter/material.dart';

class DayCard extends StatelessWidget {
  final String day;
  final int streakDays;
  final VoidCallback onTap;
  DayCard({required this.day, required this.streakDays, required this.onTap});

  bool get isRestDay => day == 'Sunday';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: EdgeInsets.symmetric(vertical:8),
      decoration: BoxDecoration(
        color: isRestDay ? const Color(0xFFFFF2E8) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: const Color(0x14000000), blurRadius: 14, offset: Offset(0,6))],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isRestDay ? const Color(0xFFFFD2B8) : scheme.primaryContainer,
          child: Text(day.substring(0,1)),
        ),
        title: Text(day, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(isRestDay ? 'Rest and recovery day' : '$streakDays day streak'),
        trailing: Icon(isRestDay ? Icons.spa : Icons.arrow_forward_ios, color: isRestDay ? scheme.secondary : scheme.primary),
        onTap: onTap,
      ),
    );
  }
}
