import 'package:app/screens/admin/deceased_profile.dart';
import 'package:app/screens/admin/edit/edit_deceased_profile.dart';
import 'package:app/screens/admin/edit/edit_registrant_profile.dart';
import 'package:app/screens/admin/main_admin.dart';
import 'package:app/screens/admin/profile_preview.dart';
import 'package:app/screens/admin/registrant_profile.dart';
import 'package:app/screens/loading.dart';
import 'package:app/screens/pre_load.dart';
import 'package:app/screens/search/search_main.dart';
import 'package:app/screens/search/search_results_item_preview.dart';
import 'package:app/screens/search/search_results.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> routes() {
  return [
    GetPage(name: "/preload", page: () => const PreLoad()),
    GetPage(name: "/loading", page: () => const LoadingScreen()),

    // ADMIN
    GetPage(
      name: "/admin",
      page: () => const MainAdmin(),
    ),
    GetPage(
      name: "/admin-registrant-profile",
      page: () => const RegisterProfile(),
    ),

    GetPage(
      name: "/admin-deceased-profile",
      page: () => const DeceasedProfile(),
    ),
    GetPage(
      name: "/admin-edit-deceased-profile",
      page: () => const EditDeceasedProfile(),
    ),
    GetPage(
      name: "/admin-edit-registrant-profile",
      page: () => const EditRegisterProfile(),
    ),

    GetPage(
      name: "/admin-profile-preview",
      page: () => const ProfilePreview(),
    ),

    // USERS
    GetPage(name: "/search", page: () => const SearchMain()),
    GetPage(name: "/search-results", page: () => const SearchResults()),
    GetPage(
      name: "/search-results-item-preview",
      page: () => const SearchResultItemPreview(),
    ),
  ];
}
