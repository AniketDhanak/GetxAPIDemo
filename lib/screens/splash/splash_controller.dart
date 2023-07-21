import 'dart:developer';

import 'package:get/get.dart';
import 'package:getx_api_demo_mvc/constants/routes_constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SplashController extends GetxController {
  // final HttpLink httpLink = HttpLink(
  //   'https://rickandmortyapi.com/graphql',
  // );
  //
  // Link? link;

  // AuthLink authLink = AuthLink(
  //   getToken: () async => 'Bearer ${await "SessionManager.getAuthToken()"}',
  // );

  // GraphQLClient? qlClient;
  // QueryResult? queryResult;



  // var characters = <dynamic>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    // initGraphQl();
    startTimer();
  }

  /*initGraphQl() async {
    isLoading(true);
    HttpLink link = HttpLink("https://rickandmortyapi.com/graphql");
    qlClient = GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore()));

    queryResult = await qlClient!.query(
      QueryOptions(
        document: gql(
          """query {
  characters() {
    results {
      name
      image 
    }
  }
  
}""",
        ),
      ),
    );

    characters.value = queryResult?.data!['characters']['results'];
    isLoading.value = false;
    log(characters.toString());
  }*/


  startTimer(){
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(RouteConstants.homeScreen);
    });
  }


}
