
import 'package:go_router/go_router.dart';
import 'package:push_app/config/presentation/screens/details.screen.dart';
import 'package:push_app/config/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  
  routes: [
    GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),

    ),
      GoRoute(
    path: '/push-details/:messageId',
    builder: (context, state) =>  DetailsScreen(pushMessageId: state.pathParameters['messageId'] ?? '',),

    )

  ],
  
  
  );

