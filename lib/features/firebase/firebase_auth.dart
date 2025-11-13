import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  /// Create Account With Email And Password
 static Future<void> createAccountWithEmailAndPassword({
    required String password,
    required String email,
   required String name,
     required var phone,
  }) async {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
      
    ).then((value)async{
      await value.user?.updateDisplayName(name);
   await FirebaseFirestore.instance.collection('users').doc(value.user?.uid).set({
        'name':name,
        'email':email,
        'phone':phone,
        
      });
    }) ;
  }
  /// Get Current User Data from Firebase
  static User? getUserData(){
    return firebaseAuth.currentUser;
  }

  /// Sign In With Email And Password
  static Future<UserCredential?> signInWithEmailAndPassword({ required String email, required String password })async{
   return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  
  }
 
  static Future<void>sendPasswordResetEmail({required String email }) async{
    return await firebaseAuth.sendPasswordResetEmail(email: email);
  }
   static Future<void> signOut()async{
    await firebaseAuth.signOut();
  }

  static bool isInitialized = false;
  //initialize google sign in =>identify app in google
  static Future<void> _initializeSignInWithGoogle() async {
if( !isInitialized)
{
  await _googleSignIn.initialize(serverClientId: "872183862119-pnskm5d429rbpa2g4qp28rhulc51siar.apps.googleusercontent.com");
}
isInitialized=true;
  }
//user select account=> IDtoken , accessToken
 static Future<UserCredential>signInWithGoogle()async{
  _initializeSignInWithGoogle();
GoogleSignInAccount? account=await _googleSignIn.authenticate();
final idToken=account.authentication.idToken;
final authClien =account.authorizationClient;
GoogleSignInClientAuthorization ?auth=await authClien.authorizationForScopes(['email' , 'profile']);
final accessToken = auth?.accessToken;

//token sign in
final credential = GoogleAuthProvider.credential(
  idToken: idToken,
  accessToken: accessToken,
);
return await FirebaseAuth.instance.signInWithCredential(credential);
}

}

