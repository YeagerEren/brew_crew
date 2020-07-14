import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  //create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return (user != null ? User(uid: user.uid) : null);
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user)); is same as bottom
          .map(_userFromFirebaseUser);
  }

  //sign in annon
  Future signInAnnon() async{

    try{

      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    }
    catch(e){

      print(e.toString());

    }
  }
  //sign in with email & password
  Future signInEmailAndPassword(String email , String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }
  //register with email & password
  Future registerWithEmailAndPassword(String email , String password) async{
    try{
      AuthResult result =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user =result.user;

      //create a document for new user with uid
      await DatabaseService(uid: user.uid).updateUserData('0', 100, 'new crew member');
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}