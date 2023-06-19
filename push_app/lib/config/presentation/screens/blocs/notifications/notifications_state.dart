part of 'notifications_bloc.dart';

 class NotificationsState extends Equatable {

  final AuthorizationStatus status;
  final List<dynamic> notificactions;
  
  const NotificationsState({

    this.status = AuthorizationStatus.notDetermined,
    this.notificactions = const[],
  });
  
  NotificationsState copyWith({
    AuthorizationStatus? status,
    List<dynamic>? notificactions
  }) => NotificationsState(
    status: status ?? this.status,
    notificactions: notificactions ?? this.notificactions,
  );

  @override
  List<Object> get props => [status, notificactions];
}


