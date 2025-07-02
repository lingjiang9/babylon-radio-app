import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:babylon_flutter_app/pages/signup_page.dart';

@GenerateMocks([
  FirebaseAuth,
  FirebaseFirestore,
  CollectionReference,
  Query,
  QuerySnapshot,
  QueryDocumentSnapshot,
  UserCredential,
  User,
  DocumentReference,
])
import 'signup_page_firebase_mock_test.mocks.dart';

void main() {
  testWidgets('SignupPage builds with mocked Firebase', (tester) async {
    final mockAuth = MockFirebaseAuth();
    final mockFirestore = MockFirebaseFirestore();

    // If your SignupPage takes these as parameters, pass them in. Otherwise, just build the widget.
    await tester.pumpWidget(
      MaterialApp(
        home: SignupPage(
          firebaseAuth: mockAuth,
          firebaseFirestore: mockFirestore,
        ),
      ),
    );

    // Basic check: SignupPage is present
    expect(find.byType(SignupPage), findsOneWidget);
  });

  testWidgets('shows error if email is already registered in Firestore', (tester) async {
    final mockAuth = MockFirebaseAuth();
    final mockFirestore = MockFirebaseFirestore();
    final mockCollection = MockCollectionReference<Map<String, dynamic>>();
    final mockQuery = MockQuery<Map<String, dynamic>>();
    final mockQuerySnapshot = MockQuerySnapshot<Map<String, dynamic>>();
    final mockQueryDocumentSnapshot = MockQueryDocumentSnapshot<Map<String, dynamic>>();

    when(mockFirestore.collection('users')).thenReturn(mockCollection);
    when(mockCollection.where('email', isEqualTo: anyNamed('isEqualTo'))).thenReturn(mockQuery);
    when(mockQuery.limit(1)).thenReturn(mockQuery);
    when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
    when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);

    await tester.pumpWidget(MaterialApp(
      home: SignupPage(
        firebaseAuth: mockAuth,
        firebaseFirestore: mockFirestore,
      ),
    ));

    await tester.enterText(find.byType(TextFormField).at(0), 'John');
    await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
    await tester.enterText(find.byType(TextFormField).at(2), 'john.doe@example.com');
    await tester.enterText(find.byType(TextFormField).at(3), 'Password1!');
    final signUpButton = find.widgetWithText(ElevatedButton, 'Sign Up');
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();
    expect(find.text('This email is already registered.'), findsOneWidget);
  });

  testWidgets('shows thank you snackbar if signup is successful and email does not exist', (tester) async {
    final mockAuth = MockFirebaseAuth();
    final mockFirestore = MockFirebaseFirestore();
    final mockCollection = MockCollectionReference<Map<String, dynamic>>();
    final mockQuery = MockQuery<Map<String, dynamic>>();
    final mockQuerySnapshot = MockQuerySnapshot<Map<String, dynamic>>();
    final mockUserCredential = MockUserCredential();
    final mockUser = MockUser();
    final mockDoc = MockDocumentReference<Map<String, dynamic>>();

    when(mockFirestore.collection('users')).thenReturn(mockCollection);
    when(mockCollection.where('email', isEqualTo: anyNamed('isEqualTo'))).thenReturn(mockQuery);
    when(mockQuery.limit(1)).thenReturn(mockQuery);
    when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
    when(mockQuerySnapshot.docs).thenReturn([]); // Email does not exist
    when(mockAuth.createUserWithEmailAndPassword(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => mockUserCredential);
    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('testuid');
    when(mockCollection.doc('testuid')).thenReturn(mockDoc);
    when(mockDoc.set(any)).thenAnswer((_) async => {});

    await tester.pumpWidget(MaterialApp(
      home: SignupPage(
        firebaseAuth: mockAuth,
        firebaseFirestore: mockFirestore,
      ),
    ));

    await tester.enterText(find.byType(TextFormField).at(0), 'John');
    await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
    await tester.enterText(find.byType(TextFormField).at(2), 'john.doe@example.com');
    await tester.enterText(find.byType(TextFormField).at(3), 'Password1!');
    final signUpButton = find.widgetWithText(ElevatedButton, 'Sign Up');
    await tester.tap(signUpButton);
    await tester.pump(); // Start async
    await tester.pump(const Duration(seconds: 2)); // Wait for signup delay
    await tester.pump(const Duration(seconds: 1)); // Wait for navigation delay
    await tester.pumpAndSettle();
    expect(find.text('Thank you for signing up, John Doe!'), findsOneWidget);
  });
} 