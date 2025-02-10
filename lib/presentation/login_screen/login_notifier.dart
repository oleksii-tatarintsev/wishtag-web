import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishtag_web/data/repositories/auth_repository.dart';
import 'package:wishtag_web/utils/toast_messenger/toast_controller.dart';

class LoginNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository _authRepository;

  LoginNotifier(this._authRepository) : super(const AsyncValue.data(null));

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

final loginNotifierProvider = StateNotifierProvider<LoginNotifier, AsyncValue<User?>>(
  (ref) => LoginNotifier(
    ref.watch(authRepositoryProvider),
  ),
);
