part of 'app_bloc.dart';

@immutable
abstract class AppEvent extends Equatable {}

class AppLogoutEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class AppUserChangedEvent extends AppEvent {
  final User user;

  AppUserChangedEvent(this.user);

  @override
  List<Object?> get props => [user];
}
