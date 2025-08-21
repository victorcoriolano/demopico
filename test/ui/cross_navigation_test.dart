import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/features/home/presentation/provider/home_provider.dart';
import 'package:demopico/features/home/presentation/provider/weather_provider.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../features/mocks/mocks_profile.dart';

final mockCommunique = Communique(
  id: '1',
  text: 'Test Communique',
  timestamp: 'This is a test communique.',
  likeCount: 0,
  likedBy: [],
  pictureUrl: "",
  type: TypeCommunique.announcement,
  uid: "fdstrsfgfd",
  vulgo: "vkfdlsmp2"

);

class MockWeatherProvider extends Mock implements OpenWeatherProvider {
  @override
  bool get isLoading => false;

  @override
  String? get errorMessage => null;

  @override
  bool isUpdated() => true;

  @override
  bool imOld() => false;

  @override
  Future<void> fetchWeatherData() => Future.value();
}

class MockUserDatabaseProvider extends Mock implements UserDatabaseProvider {
  @override
  UserM? get user => mockUserProfile;
}

class MockHomeProvider extends Mock implements HomeProvider {
  @override
  List<Communique> get allCommuniques => [mockCommunique];

  @override
  Future<void> fetchRecentCommuniques() => Future.value();
}

void main() {
  late MockWeatherProvider mockWeatherProvider;
  late MockUserDatabaseProvider mockUserDatabaseProvider;

  setUp(() {
    mockWeatherProvider = MockWeatherProvider();
    mockUserDatabaseProvider = MockUserDatabaseProvider();
  });

  Widget makeTestableWidget({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OpenWeatherProvider>(
          create: (_) => mockWeatherProvider,
        ),
        ChangeNotifierProvider<UserDatabaseProvider>(
          create: (_) => mockUserDatabaseProvider,
        ),
        ChangeNotifierProvider<HomeProvider>(create: (_) => MockHomeProvider())
      ],
      child: GetMaterialApp(
        initialRoute: Paths.home,
        getPages: [
          GetPage(name: Paths.home, page: () => HomePage()),
          GetPage(name: Paths.map, page: () => Scaffold(body: Text('Map Page'))),
          GetPage(
              name: Paths.profile, page: () => Scaffold(body: Text('Profile Page'))),
        ],
        home: child,
      ),
    );
  }

  group('HomePage Navigation Tests', () {
    testWidgets('Navigates to MapPage on right swipe',
        (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: HomePage()));

      // Find the GestureDetector
      final gestureDetector = find.byKey(const Key('home_page_gesture_detector_navigate'));

      // Simulate a right swipe
      await tester.drag(gestureDetector, Offset(500, 0));
      await tester.pumpAndSettle();

      // Verify that we navigated to the map page
      expect(Get.currentRoute, Paths.map);
      expect(find.text('Map Page'), findsOneWidget);
    });

    testWidgets('Navigates to ProfilePage on left swipe',
        (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: HomePage()));

      // Find the GestureDetector
      final gestureDetector = find.byType(GestureDetector);

      // Simulate a left swipe
      await tester.drag(gestureDetector, Offset(-500, 0));
      await tester.pumpAndSettle();

      // Verify that we navigated to the profile page
      expect(Get.currentRoute, Paths.profile);
      expect(find.text('Profile Page'), findsOneWidget);
    });
  });
}