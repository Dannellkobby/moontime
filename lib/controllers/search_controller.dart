import 'dart:convert';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moontime/models/person.dart';
import 'package:moontime/models/show.dart';
import 'package:http/http.dart' as http;

enum SearchScope { series, people }

class SearchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  final ScrollController chipsScrollController = ScrollController();
  late final Rx<SearchScope> searchScope;
  final RxBool loading = RxBool(false);
  final TextEditingController tecSearch = TextEditingController();
  final RxString searchPhrase = RxString('');
  final RxString errorMessage = RxString('');
  final RxMap<String, List> mapOfSearchResults = RxMap();
  final int initialIndex;
  var client = http.Client();

  SearchController(this.initialIndex);

  Future<void> performSearch(SearchScope index, String phrase) async {
    if (phrase.isEmpty) {
      EasyDebounce.cancel('search');
      return;
    }
    loading.value = true;
    EasyDebounce.debounce('search', const Duration(milliseconds: 1000),
        () async {
      if (kDebugMode) print('searching in ${index.name} : $phrase');
      errorMessage.value = '';
      client
          .get(Uri.https('api.tvmaze.com', 'search/${searchScope.value == SearchScope.people?'people':'shows'}', {'q': phrase}))
          .then((response) async {
        print(
            'response: ${(jsonDecode(utf8.decode(response.bodyBytes)) as List)}');
        List results = [];
        try {
          switch (index) {
            case SearchScope.series:
              results = Show.listFromJson(
                  (jsonDecode(utf8.decode(response.bodyBytes)) as List)
                      .map((e) => e['show'])
                      .toList());
              break;
            case SearchScope.people:
              results = results = Person.listFromJson(
                  (jsonDecode(utf8.decode(response.bodyBytes)) as List)
                      .map((e) => e['person'])
                      .toList());
              break;
          }
        } catch (e) {
          if (kDebugMode) print('parsing response failed: $e');
        }

        if (tecSearch.text.isEmpty) {
          if (kDebugMode) {
            print('scrubbing ${index.name} results ${results.length}');
          }
          return;
        }

        mapOfSearchResults.assign(index.name, results);
        loading.value = false;
      }).catchError((error) {
        loading.value = false;
        if ('$error'.toLowerCase().contains('time') ||
            '$error'.toLowerCase().contains('socket')) {
          errorMessage.value = 'Please check your Internet connection';
        } else {
          errorMessage.value = 'Something went wrong';
        }
        if (kDebugMode) {
          print('performSearch failed: $error');
        }
      });
    });
  }

  void cancelSearch() {
    errorMessage.value = '';
    tecSearch.clear();
    mapOfSearchResults.clear();
    loading.value = false;
  }

  @override
  onInit() async {
    super.onInit();
    searchScope = Rx(SearchScope.values.elementAt(initialIndex));
    tabController = TabController(
        initialIndex: initialIndex,
        length: SearchScope.values.length,
        vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    tabController.addListener(() {
      searchScope.value = SearchScope.values.elementAt(tabController.index);
      if (searchPhrase.isNotEmpty &&
          (mapOfSearchResults[searchScope.value.name]?.isNotEmpty ?? true)) {
        performSearch(searchScope.value, searchPhrase.value);
      }
      chipsScrollController.animateTo(
          (((searchScope.value.index / SearchScope.values.length) *
              (Get.context!.width / 2))),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut);
    });
    tecSearch.addListener(() {
      if (tecSearch.text.isEmpty) {
        cancelSearch();
      }
      if (searchPhrase.value != tecSearch.text) {
        searchPhrase.value = tecSearch.text;
        performSearch(searchScope.value, searchPhrase.value);
      }
    });
  }

  @override
  void onClose() {
    client.close();
    tabController.dispose();
    tecSearch.dispose();
    super.onClose();
  }
}
