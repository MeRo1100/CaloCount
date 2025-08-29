
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ketodiet/model/diet_response.dart';
import 'package:ketodiet/model/dietrecipes_response.dart';
import 'package:ketodiet/utils/sessionmanager.dart';

class Api{

  Future<void> loadDietJson(BuildContext context) async {
    DietResponse? dietResponse = DietResponse();
    String response = await DefaultAssetBundle.of(context)
        .loadString("assets/json/diet.json");
    print('response>>>>$response');
      dietResponse = DietResponse.fromMap(json.decode(response));
      if (dietResponse!.foods!.isNotEmpty) {
        print('Api response getting>>>${dietResponse.foods!.length}');
        SessionManager manager = SessionManager();
        manager.setDietResponse(dietResponse);
      } else {
        print('Null data');
      }
  }

  Future<void> loadDietRecipes(BuildContext context) async {
    DietrecipesResponse dietResponse = DietrecipesResponse();
    String response = await DefaultAssetBundle.of(context)
        .loadString("assets/json/DietRecipe.json");
    print('response>>> recipes>$response');
      dietResponse = DietrecipesResponse.fromMap(json.decode(response))!;
      if (dietResponse.recipes!.isNotEmpty) {
        print('Api recipes response getting>>>${dietResponse.recipes![0].Veg!.Breakfast!.length}');
        SessionManager manager = SessionManager();
        manager.setDietRecipesResponse(dietResponse);
      } else {
        print('Null data');
      }
  }




}