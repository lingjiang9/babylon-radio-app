import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:babylon_flutter_app/pages/login_page.dart';

@GenerateMocks([
  FirebaseAuth,
  UserCredential,
  User,
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
])
import 'login_firestore_test.mocks.dart';

void main() {
  testWidgets('Login succeeds if email exists in Firestore and password matches', (tester) async {
    // Mock Auth
    final mockAuth = MockFirebaseAuth();
    final mockUserCredential = MockUserCredential();
    final mockUser = MockUser();
    when(mockAuth.signInWithEmailAndPassword(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => mockUserCredential);
    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('testuid');

    // Mock Firestore
    final mockFirestore = MockFirebaseFirestore();
    final mockCollection = MockCollectionReference<Map<String, dynamic>>();
    final mockDoc = MockDocumentReference<Map<String, dynamic>>();
    final mockSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();

    when(mockFirestore.collection('users')).thenReturn(mockCollection);
    when(mockCollection.doc(any)).thenReturn(mockDoc);
    when(mockDoc.get()).thenAnswer((_) async => mockSnapshot);
    when(mockSnapshot.exists).thenReturn(true);
    when(mockSnapshot.data()).thenReturn({'firstName': 'Test', 'lastName': 'User'});

    // Pump the widget
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(firebaseAuth: mockAuth, firebaseFirestore: mockFirestore),
      ),
    );

    // Enter valid credentials
    await tester.enterText(find.byType(TextFormField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'Password123!');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Check for success SnackBar
    expect(find.text('Hey, Test User, you are successfully logged in.'), findsOneWidget);
  });
} 