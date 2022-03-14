import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:max_flutter_authentication/model/user.dart';
import 'package:meta/meta.dart';

import '../repositories/auth_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  StreamSubscription<User>? _streamSubscription;
  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(authRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authRepository.currentUser)
            : const AppState.unathenticated()) {
    on<AppUserChangedEvent>(_onAppUserChangedEvent);
    on<AppLogoutEvent>(_onAppLogoutEvent);
    _streamSubscription = _authRepository.user.listen((user) {
      add(AppUserChangedEvent(user));
    });
  }

  FutureOr<void> _onAppUserChangedEvent(AppUserChangedEvent event, Emitter<AppState> emit) {
    emit(event.user.isNotEmpty ? AppState.authenticated(event.user) : const AppState.unathenticated());
  }

  FutureOr<void> _onAppLogoutEvent(AppLogoutEvent event, Emitter<AppState> emit) {
    unawaited(_authRepository.logOut());
  }
  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
