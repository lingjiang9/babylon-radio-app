import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@GenerateMocks([
  FirebaseAuth,
  UserCredential,
  User,
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
])
import 'login_logic_unit_test.mocks.dart';

void main() {
  group('Login logic unit test', () {
    test('Checks if email exists in Firestore and password matches', () async {
      final mockAuth = MockFirebaseAuth();
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();
      final mockFirestore = MockFirebaseFirestore();
      final mockCollection = MockCollectionReference<Map<String, dynamic>>();
      final mockDoc = MockDocumentReference<Map<String, dynamic>>();
      final mockSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();

      // Setup Firestore to return a user document for the email
      when(mockFirestore.collection('users')).thenReturn(mockCollection);
      when(mockCollection.doc('testuid')).thenReturn(mockDoc);
      when(mockDoc.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.exists).thenReturn(true);
      when(mockSnapshot.data()).thenReturn({'firstName': 'Test', 'lastName': 'User', 'email': 'user@example.com'});

      // Setup Auth to return a user credential if password matches
      when(mockAuth.signInWithEmailAndPassword(email: 'user@example.com', password: 'Password123!'))
        .thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('testuid');

      // Simulate login logic
      final userCredential = await mockAuth.signInWithEmailAndPassword(email: 'user@example.com', password: 'Password123!');
      final userDoc = await mockFirestore.collection('users').doc(userCredential.user!.uid).get();
      final exists = userDoc.exists;
      final data = userDoc.data();

      expect(exists, isTrue);
      expect(data!['email'], 'user@example.com');
    });
  });
} 