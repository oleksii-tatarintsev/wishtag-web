import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishtag_web/data/repositories.dart';
import 'package:wishtag_web/utils/toast.dart';

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> singIn({required String email, required String password}) async {
    state = const AsyncValue.loading();

    try {
      final user = await _authRepository.singIn(email: email, password: password);
      state = AsyncValue.data(user);
    } on FirebaseAuthException catch (e, s) {
      state = AsyncValue.error(e, s);
      Toast.add(message: e.code, containerColor: Colors.red);
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    state = const AsyncData(null);
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
  (ref) => AuthNotifier(ref.watch(authRepositoryProvider)),
);
