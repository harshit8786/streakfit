import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignupScreen extends StatefulWidget{ @override _SignupScreenState createState()=> _SignupScreenState(); }
class _SignupScreenState extends State<SignupScreen>{
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  String? _err;
  @override Widget build(BuildContext context){ final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Sign up')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(children:[
              TextField(controller: _name, decoration: InputDecoration(labelText:'Name')),
              SizedBox(height:12),
              TextField(controller: _email, decoration: InputDecoration(labelText:'Email')),
              SizedBox(height:12),
              TextField(controller: _pass, decoration: InputDecoration(labelText:'Password'), obscureText:true),
              SizedBox(height:12),
              if (_err!=null) Text(_err!, style: TextStyle(color:Colors.red)),
              SizedBox(height:12),
              ElevatedButton(onPressed: auth.loading?null:() async { final e = await auth.register(_name.text.trim(), _email.text.trim(), _pass.text); if (e!=null) setState(()=>_err=e); else Navigator.pop(context); }, child: auth.loading?CircularProgressIndicator(color: Colors.white):Text('Register'))
            ]),
          ),
        ),
      )
    );
  }
}
