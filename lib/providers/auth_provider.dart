import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

class AuthProvider with ChangeNotifier {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    // _initAuth();
  }

  // void _initAuth() {
  //   _auth.authStateChanges().listen((User? user) async {
  //     if (user != null) {
  //       await _loadUserData(user.uid);
  //     } else {
  //       _currentUser = null;
  //       _isAuthenticated = false;
  //       _isLoading = false;
  //       notifyListeners();
  //     }
  //   });
  // }

  // Future<void> _loadUserData(String uid) async {
  //   try {
  //     final doc = await _firestore
  //         .collection(FirestoreCollections.users)
  //         .doc(uid)
  //         .get();

  //     if (doc.exists) {
  //       _currentUser = UserModel.fromMap(doc.data()!, doc.id);
  //       _isAuthenticated = true;
  //     }
  //   } catch (e) {
  //     _errorMessage = e.toString();
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> signUp(
    String email,
    String password,
    String displayName,
    AuthType authType,
  ) async {
    try {
      _errorMessage = null;
      _isLoading = true;
      notifyListeners();

      // TODO: Implement Firebase sign up
      // For now, simulate successful signup
      await Future.delayed(const Duration(seconds: 1));
      
      _currentUser = UserModel(
        id: 'demo-user-id',
        email: email,
        displayName: displayName,
        authType: authType,
      );
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();

    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      _errorMessage = null;
      _isLoading = true;
      notifyListeners();

      // TODO: Implement Firebase sign in
      // For now, simulate successful signin
      await Future.delayed(const Duration(seconds: 1));
      
      _currentUser = UserModel(
        id: 'demo-user-id',
        email: email,
        displayName: 'Demo User',
        authType: AuthType.password,
      );
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();

    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    // await _auth.signOut();
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
