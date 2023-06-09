import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_app/domain/entities/push_message.dart';
import 'package:push_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificactionStatusChanged);
    on<NotificationReceived>(_onPushMessageReceived);
    _initialStatusCheck();
    _onForegroundMessage();
  
  }
  static Future<void> initializeFCM() async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificactionStatusChanged (NotificationStatusChanged event, Emitter<NotificationsState> emit){
    emit(
      state.copyWith(
        status:event.status
      )
      );
      _getFCMToken();

  }
  void _onPushMessageReceived (NotificationReceived event, Emitter<NotificationsState> emit){
    emit(
      state.copyWith(
        notificactions: [event.pushMessage, ...state.notificactions]
      )
      );
     

  }

  void _initialStatusCheck() async {
      final settings = await messaging.getNotificationSettings();
        add(NotificationStatusChanged( settings.authorizationStatus));
      
  }

  void handleRemoteMessage(RemoteMessage message){
    //  print('Got a message whilst in the foreground!');
    //  print('Message data: ${message.data}');
     if (message.notification == null)  return;
     final notification = PushMessage(
      messageId: message.messageId
      ?.replaceAll(';', '').replaceAll('%','')
      ?? '', 
      title: message.notification!.title?? '', 
      body: message.notification!.body ?? '', 
      senDate: message.sentTime?? DateTime.now(), 
      data: message.data,
      imageUrl: Platform.isAndroid
      ? message.notification!.android?.imageUrl
      : message.notification!.apple?.imageUrl);
    add(NotificationReceived(notification));
  
  }
  void _onForegroundMessage(){
    final listener = FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void _getFCMToken() async{
    final settings = await messaging.getNotificationSettings();
    if(state.status != AuthorizationStatus.authorized) return;
    final token = await messaging.getToken();
    print(token);
  }

  void requestPermission() async{
      
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: false,
        sound: true,
      );
      add(NotificationStatusChanged( settings.authorizationStatus));
      
   

  }


  PushMessage? getMessageById(String pushMessageId){
    final exist = state.notificactions.any((element) => element.messageId == pushMessageId);
    if(!exist) return null;
    return state.notificactions.firstWhere((element) => element.messageId == pushMessageId);
  }

}
