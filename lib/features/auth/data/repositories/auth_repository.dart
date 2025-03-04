import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  @override
  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential=await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.sendEmailVerification();

      await _firebaseAuth.signOut();


    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> signIn(String email, String password) async {
    try {
      UserCredential userCredential=await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(!userCredential.user!.emailVerified){
        await userCredential.user!.sendEmailVerification();
        await _firebaseAuth.signOut();
        throw "Email is Not Verified";
      }

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      return userDoc.exists ? "yes" : "no";

    }
    on FirebaseAuthException catch(e){
      throw e.code;
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<String> handleGoogleSign() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut(); // Ensuring a fresh login
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();

      if (gUser == null) {
        throw "Google Sign-In cancelled"; // Explicitly throw an exception
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user == null) return "null";

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      return userDoc.exists ? "yes" : "no";
    } catch (e) {
      print("Error during sign-in: $e");
      throw Exception(e.toString()); // Make sure to propagate errors
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> checkauthstatus()async{
    User? user= await _firebaseAuth.currentUser;
    if(user==null)return "null";
    DocumentSnapshot userDoc =
    await _firestore.collection('users').doc(user.uid).get();
    if (userDoc.exists) return "yes";
    else return "no";
  }
}
