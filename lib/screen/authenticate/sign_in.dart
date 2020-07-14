import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading =false;

  //text field state
  String email ='';
  String password ='';
  String error ='';

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign up')
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) =>val.isEmpty ? 'Enter an Email' : null,
                onChanged: (value){
                  setState(() => email = value);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) =>val.length <6  ? 'Enter a password with 6 characters or more' : null,
                obscureText: true,
                onChanged: (value){
                  setState(() => password = value);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.redAccent,
                child: Text(
                    'Sign In',
                    style:TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                    if(_formkey.currentState.validate()){
                      setState(() => loading =true);
                    dynamic result = await _auth.signInEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                      error = 'Could not sign in with these credentials';
                      loading =false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 14.0),
              )
            ],
          ),
        )
      ),
    );
  }
}
