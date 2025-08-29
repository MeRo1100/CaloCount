class DietrecipesResponse {
  List<RecipesBean>? recipes;

  static DietrecipesResponse? fromMap(Map<String, dynamic> map) {
    DietrecipesResponse dietrecipesResponseBean = DietrecipesResponse();
    dietrecipesResponseBean.recipes = [...(map['recipes'] as List ?? []).map((o) => RecipesBean.fromMap(o)!)];
    return dietrecipesResponseBean;
  }

  Map toJson() => {
    "recipes": recipes,
  };
}

class RecipesBean {
  DataBean? Veg;
  DataBean? NonVeg;

  static RecipesBean? fromMap(Map<String, dynamic> map) {
    RecipesBean recipesBean = RecipesBean();
    recipesBean.Veg = DataBean.fromMap(map['Veg']);
    recipesBean.NonVeg = DataBean.fromMap(map['NonVeg']);
    return recipesBean;
  }

  Map toJson() => {
    "Veg": Veg,
    "NonVeg": NonVeg,
  };
}

class DataBean {
  List<FoodDataBean>? Breakfast;
  List<FoodDataBean>? Lunch;
  List<FoodDataBean>? Dinner;
  List<FoodDataBean>? Snacks;

  static DataBean? fromMap(Map<String, dynamic> map) {
    DataBean nonVegBean = DataBean();
    nonVegBean.Breakfast = [...(map['Breakfast'] as List ?? []).map((o) => FoodDataBean.fromMap(o)!)];
    nonVegBean.Lunch = [...(map['Lunch'] as List ?? []).map((o) => FoodDataBean.fromMap(o)!)];
    nonVegBean.Dinner = [...(map['Dinner'] as List ?? []).map((o) => FoodDataBean.fromMap(o)!)];
    nonVegBean.Snacks = [...(map['Snacks'] as List ?? []).map((o) => FoodDataBean.fromMap(o)!)];
    return nonVegBean;
  }

  Map toJson() => {
    "Breakfast": Breakfast,
    "Lunch": Lunch,
    "Dinner": Dinner,
    "Snacks": Snacks,
  };
}

class FoodDataBean {
  String? Day;
  String? Title;
  String? Ingredients;
  String? Instructions;

  static FoodDataBean? fromMap(Map<String, dynamic> map) {
    FoodDataBean snacksBean = FoodDataBean();
    snacksBean.Day = map['Day'];
    snacksBean.Title = map['Title'];
    snacksBean.Ingredients = map['Ingredients'];
    snacksBean.Instructions = map['Instructions'];
    return snacksBean;
  }

  Map toJson() => {
    "Day": Day,
    "Title": Title,
    "Ingredients": Ingredients,
    "Instructions": Instructions,
  };
}

