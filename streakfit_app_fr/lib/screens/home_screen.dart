import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/day_card.dart';
import 'day_screen.dart';

class HomeScreen extends StatelessWidget{
  final days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
  @override Widget build(BuildContext context){
    final auth = Provider.of<AuthProvider>(context);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text('StreakFit'), actions:[ IconButton(icon: Icon(Icons.logout), onPressed: () => auth.logout()) ]),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(children:[
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [scheme.primary, const Color(0xFF39A78B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(children:[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello, ${auth.user?.name ?? ''}', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height:6),
                    Text('Stay consistent and complete your weekly split.', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0x26FFFFFF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(children:[ Text('Streak', style: TextStyle(fontSize:12, color: Colors.white70)), SizedBox(height:6), Text('3', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.white)) ]),
              )
            ]),
          ),
          SizedBox(height:16),
          Expanded(child: ListView.builder(itemCount: days.length, itemBuilder: (ctx,i){ final d=days[i]; return DayCard(day: d, streakDays: i%4+1, onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => DayScreen(day: d)))); }))
        ]),
      )
    );
  }
}
