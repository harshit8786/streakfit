import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget{ @override _LoginScreenState createState()=> _LoginScreenState(); }
class _LoginScreenState extends State<LoginScreen>{
  final _email = TextEditingController();
  final _pass = TextEditingController();
  String? _err;
  @override Widget build(BuildContext context){
    final auth = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF3F7F4), Color(0xFFE6F3EE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(children:[
              SizedBox(height:24),
              Hero(
                tag:'hero-logo',
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1F8A70), Color(0xFF39A78B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x261F8A70),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    size: 72,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height:20),
              Text('Welcome to StreakFit', style: TextStyle(fontSize:24, fontWeight: FontWeight.bold, color: Color(0xFF173D38))),
              SizedBox(height:8),
              Text(
                'Build consistency with a clean weekly workout routine.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height:24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(children: [
                    TextField(controller: _email, decoration: InputDecoration(labelText:'Email')),
                    SizedBox(height:12),
                    TextField(controller: _pass, decoration: InputDecoration(labelText:'Password'), obscureText:true),
                    SizedBox(height:12),
                    if (_err!=null) Text(_err!, style: TextStyle(color: theme.colorScheme.error)),
                    SizedBox(height:12),
                    ElevatedButton(onPressed: auth.loading?null:() async { final e = await auth.login(_email.text.trim(), _pass.text); if (e!=null) setState(()=>_err=e); }, child: auth.loading?SizedBox(height:16,width:16,child:CircularProgressIndicator(strokeWidth:2,color: Colors.white)):Text('Login')),
                    TextButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen())), child: Text('Create account'))
                  ]),
                ),
              ),
              SizedBox(height:16),
            ])
          ),
        )
      )
    );
  }
}
