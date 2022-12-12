import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moontime/controllers/auth_controller.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/models/person.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/utilities/strings.dart';

class FavoritesController extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Show> favoriteShows = RxList<Show>([]);
  RxList<Show> favoriteEpisodes = RxList<Show>([]);
  RxList<Show> favoritePeople = RxList<Show>([]);

  @override
  void onInit() {
    ever(Get.find<AuthController>().firebaseUser, (User? user) => user != null ? handleUserChanged(user) : () {});

     super.onInit();
  }

  handleUserChanged(User? user) {
    if (user == null) {
      favoriteShows.clear();
      favoritePeople.clear();
      favoriteEpisodes.clear();
    } else {
      favoriteShows.bindStream(_firestore
          .collection('${Strings.colUsers}/${user.uid}/${Strings.colFavoriteShows}')
          .orderBy('name', descending: false)
          .snapshots()
          .map((snaps) => snaps.docs.map((snap) => Show.fromJson(snap.data())).toList()));
      favoriteEpisodes.bindStream(_firestore
          .collection('${Strings.colUsers}/${user.uid}/${Strings.colFavoriteEpisodes}')
          .orderBy('name', descending: false)
          .snapshots()
          .map((snaps) => snaps.docs.map((snap) => Show.fromJson(snap.data())).toList()));
      favoritePeople.bindStream(_firestore
          .collection('${Strings.colUsers}/${user.uid}/${Strings.colFavoritePeople}')
          .orderBy('name', descending: false)
          .snapshots()
          .map((snaps) => snaps.docs.map((snap) => Show.fromJson(snap.data())).toList()));

     }
  }

  @override
  void onClose() {
    favoriteShows.close();
    favoriteEpisodes.close();
    favoritePeople.close();
    super.onClose();
  }

  Future toggleFavoriteShow(Show show) async {
    if (favoriteShows.any((e) => e.id == show.id)) {
      //remove
      return _firestore
          .doc('${Strings.colUsers}/${Get.find<AuthController>().firebaseUser.value?.uid}/${Strings.colFavoriteShows}/${show.id}')
          .delete();
    } else {
      return _firestore
          .doc('${Strings.colUsers}/${Get.find<AuthController>().firebaseUser.value?.uid}/${Strings.colFavoriteShows}/${show.id}')
          .set(show.toJson());
    }
  }
  Future toggleFavoriteEpisode(Episode episode) async {
    if (favoriteShows.any((e) => e.id == episode.id)) {
      //remove
      return _firestore
          .doc('${Strings.colUsers}/${Get.find<AuthController>().firebaseUser.value?.uid}/${Strings.colFavoriteEpisodes}/${episode.id}')
          .delete();
    } else {
      return _firestore
          .doc('${Strings.colUsers}/${Get.find<AuthController>().firebaseUser.value?.uid}/${Strings.colFavoriteEpisodes}/${episode.id}')
          .set(episode.toJson());
    }
  }
  Future toggleFavoritePeople(Person person) async {
    if (favoriteShows.any((e) => e.id == person.id)) {
      //remove
      return _firestore
          .doc('${Strings.colUsers}/${Get.find<AuthController>().firebaseUser.value?.uid}/${Strings.colFavoritePeople}/${person.id}')
          .delete();
    } else {
      return _firestore
          .doc('${Strings.colUsers}/${Get.find<AuthController>().firebaseUser.value?.uid}/${Strings.colFavoritePeople}/${person.id}')
          .set(person.toJson());
    }
  }

}
