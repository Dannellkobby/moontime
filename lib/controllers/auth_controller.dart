/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    _auth.signInAnonymously();
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  @override
  void onReady() async {
    firebaseUser.value = _auth.currentUser;
    super.onReady();
  }

  @override
  void onClose() {
    firebaseUser.close();
    super.onClose();
  }
}
