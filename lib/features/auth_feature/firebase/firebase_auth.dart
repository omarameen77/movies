import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Create Account With Email And Password
  static Future<void> createAccountWithEmailAndPassword({
    required String password,
    required String email,
    required String name,
    required var phone,
  }) async {
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await value.user?.updateDisplayName(name);
      await _firestore.collection('users').doc(value.user?.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }

  /// Get Current User Data from Firebase Auth
  static User? getUserData() {
    return firebaseAuth.currentUser;
  }

  /// Get User Details from Firestore
  static Future<Map<String, dynamic>?> getUserDetails() async {
    try {
      User? currentUser = firebaseAuth.currentUser;
      if (currentUser == null) return null;

      DocumentSnapshot doc =
          await _firestore.collection('users').doc(currentUser.uid).get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      print('Error getting user details: $e');
      return null;
    }
  }

  /// Get User Details Stream (Real-time updates)
  static Stream<Map<String, dynamic>?> getUserDetailsStream() {
    User? currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      return Stream.value(null);
    }

    return _firestore
        .collection('users')
        .doc(currentUser.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>?;
      }
      return null;
    });
  }

  /// Update User Profile
  static Future<void> updateUserProfile({
    String? name,
    String? phone,
    String? photoUrl,
  }) async {
    try {
      User? currentUser = firebaseAuth.currentUser;
      if (currentUser == null) return;

      Map<String, dynamic> updateData = {};

      if (name != null) {
        updateData['name'] = name;
        await currentUser.updateDisplayName(name);
      }
      if (phone != null) updateData['phone'] = phone;
      if (photoUrl != null) {
        updateData['photoUrl'] = photoUrl;
        await currentUser.updatePhotoURL(photoUrl);
      }

      if (updateData.isNotEmpty) {
        await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .update(updateData);
      }
    } catch (e) {
      print('Error updating profile: $e');
      rethrow;
    }
  }

  /// Sign In With Email And Password
  static Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> sendPasswordResetEmail({required String email}) async {
    return await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await firebaseAuth.signOut();
  }

  static bool isInitialized = false;

  static Future<void> _initializeSignInWithGoogle() async {
    if (!isInitialized) {
      await _googleSignIn.initialize(
        serverClientId:
            "872183862119-pnskm5d429rbpa2g4qp28rhulc51siar.apps.googleusercontent.com",
      );
    }
    isInitialized = true;
  }

  static Future<UserCredential> signInWithGoogle() async {
    await _initializeSignInWithGoogle();
    GoogleSignInAccount? account = await _googleSignIn.authenticate();
    final idToken = account.authentication.idToken;
    final authClient = account.authorizationClient;
    GoogleSignInClientAuthorization? auth =
        await authClient.authorizationForScopes(['email', 'profile']);
    final accessToken = auth?.accessToken;

    final credential = GoogleAuthProvider.credential(
      idToken: idToken,
      accessToken: accessToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.additionalUserInfo?.isNewUser ?? false) {
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': userCredential.user?.displayName ?? '',
        'email': userCredential.user?.email ?? '',
        'phone': '',
        'photoUrl': userCredential.user?.photoURL ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return userCredential;
  }

  // WATCH LIST METHODS


  // /// Add Movie to Watch List
  // static Future<void> addToWatchList(Map<String, dynamic> movieData) async {
  //   try {
  //     User? currentUser = firebaseAuth.currentUser;
  //     if (currentUser == null) throw Exception('User not logged in');

  //     // إضافة timestamp
  //     movieData['addedAt'] = FieldValue.serverTimestamp();

  //     await _firestore
  //         .collection('users')
  //         .doc(currentUser.uid)
  //         .collection('watchlist')
  //         .doc(movieData['id'].toString())
  //         .set(movieData);
  //   } catch (e) {
  //     print('Error adding to watchlist: $e');
  //     rethrow;
  //   }
  // }

  // /// Remove Movie from Watch List
  // static Future<void> removeFromWatchList(int movieId) async {
  //   try {
  //     User? currentUser = firebaseAuth.currentUser;
  //     if (currentUser == null) throw Exception('User not logged in');

  //     await _firestore
  //         .collection('users')
  //         .doc(currentUser.uid)
  //         .collection('watchlist')
  //         .doc(movieId.toString())
  //         .delete();
  //   } catch (e) {
  //     print('Error removing from watchlist: $e');
  //     rethrow;
  //   }
  // }

  // /// Check if Movie is in Watch List
  // static Future<bool> isInWatchList(int movieId) async {
  //   try {
  //     User? currentUser = firebaseAuth.currentUser;
  //     if (currentUser == null) return false;

  //     DocumentSnapshot doc = await _firestore
  //         .collection('users')
  //         .doc(currentUser.uid)
  //         .collection('watchlist')
  //         .doc(movieId.toString())
  //         .get();

  //     return doc.exists;
  //   } catch (e) {
  //     print('Error checking watchlist: $e');
  //     return false;
  //   }
  // }

  /// Get Watch List Stream
  // static Stream<List<Map<String, dynamic>>> getWatchListStream() {
  //   User? currentUser = firebaseAuth.currentUser;
  //   if (currentUser == null) {
  //     return Stream.value([]);
  //   }

  //   return _firestore
  //       .collection('users')
  //       .doc(currentUser.uid)
  //       .collection('watchlist')
  //       .orderBy('addedAt', descending: true)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) => doc.data()).toList();
  //   });
  // }

  // /// Get Watch List Count
  // static Future<int> getWatchListCount() async {
  //   try {
  //     User? currentUser = firebaseAuth.currentUser;
  //     if (currentUser == null) return 0;

  //     QuerySnapshot snapshot = await _firestore
  //         .collection('users')
  //         .doc(currentUser.uid)
  //         .collection('watchlist')
  //         .get();

  //     return snapshot.docs.length;
  //   } catch (e) {
  //     return 0;
  //   }
  // }

  /// Add Movie to History
  // static Future<void> addToHistory(Map<String, dynamic> movieData) async {
  //   try {
  //     User? currentUser = firebaseAuth.currentUser;
  //     if (currentUser == null) return;

  //     movieData['addedAt'] = FieldValue.serverTimestamp();

  //     await _firestore
  //         .collection('users')
  //         .doc(currentUser.uid)
  //         .collection('history')
  //         .doc(movieData['id'].toString())
  //         .set(movieData, SetOptions(merge: true));
  //   } catch (e) {
  //     print('Error adding to history: $e');
  //   }
  // }

  // /// Get History Stream
  // static Stream<List<Map<String, dynamic>>> getHistoryStream() {
  //   User? currentUser = firebaseAuth.currentUser;
  //   if (currentUser == null) {
  //     return Stream.value([]);
  //   }

  //   return _firestore
  //       .collection('users')
  //       .doc(currentUser.uid)
  //       .collection('history')
  //       .orderBy('addedAt', descending: true)
  //       .limit(50)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) => doc.data()).toList();
  //   });
  // }

  // /// Get History Count
  // static Future<int> getHistoryCount() async {
  //   try {
  //     User? currentUser = firebaseAuth.currentUser;
  //     if (currentUser == null) return 0;

  //     QuerySnapshot snapshot = await _firestore
  //         .collection('users')
  //         .doc(currentUser.uid)
  //         .collection('history')
  //         .get();

  //     return snapshot.docs.length;
  //   } catch (e) {
  //     return 0;
  //   }
  // }

  /// Clear History
  // static Future<void> clearHistory() async {
  //   try {
  //     User? currentUser = firebaseAuth.currentUser;
  //     if (currentUser == null) return;

  //     QuerySnapshot snapshot = await _firestore
  //         .collection('users')
  //         .doc(currentUser.uid)
  //         .collection('history')
  //         .get();

  //     WriteBatch batch = _firestore.batch();
  //     for (var doc in snapshot.docs) {
  //       batch.delete(doc.reference);
  //     }
  //     await batch.commit();
  //   } catch (e) {
  //     print('Error clearing history: $e');
  //     rethrow;
  //   }
  // }

  // /// Remove Single Movie from History
  // static Future<void> removeFromHistory(int movieId) async {
  //   try {
  //     User? currentUser = firebaseAuth.currentUser;
  //     if (currentUser == null) return;

  //     await _firestore
  //         .collection('users')
  //         .doc(currentUser.uid)
  //         .collection('history')
  //         .doc(movieId.toString())
  //         .delete();
  //   } catch (e) {
  //     print('Error removing from history: $e');
  //     rethrow;
  //   }
  // }

}