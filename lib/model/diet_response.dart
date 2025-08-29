class DietResponse {
  List<FoodsBean>? foods;

  static DietResponse? fromMap(Map<String, dynamic> map) {
    DietResponse dietResponseBean = DietResponse();
    dietResponseBean.foods = [...(map['foods'] as List ?? []).map((o) => FoodsBean.fromMap(o)!)];
    return dietResponseBean;
  }

  Map toJson() => {
    "foods": foods,
  };
}

class FoodsBean {
  List<DataBean>? veg;
  List<DataBean>? nonveg;

  static FoodsBean? fromMap(Map<String, dynamic> map) {
    FoodsBean foodsBean = FoodsBean();
    foodsBean.veg = [...(map['veg'] as List ?? []).map((o) => DataBean.fromMap(o)!)];
    foodsBean.nonveg = [...(map['nonveg'] as List ?? []).map((o) => DataBean.fromMap(o)!)];
    return foodsBean;
  }

  Map toJson() => {
    "veg": veg,
    "nonveg": nonveg,
  };
}

class DataBean {
  String? name;
  String? image;
  String? preference;
  int? calories;
  String? servingSize;
  MacronutrientsBean? macronutrients;

  static DataBean? fromMap(Map<String, dynamic> map) {
    DataBean nonvegBean = DataBean();
    nonvegBean.name = map['name'];
    nonvegBean.image = map['image'];
    nonvegBean.preference = map['preference'];
    nonvegBean.calories = map['calories'];
    nonvegBean.servingSize = map['serving_size'];
    nonvegBean.macronutrients = MacronutrientsBean.fromMap(map['macronutrients']);
    return nonvegBean;
  }

  Map toJson() => {
    "name": name,
    "image": image,
    "preference": preference,
    "calories": calories,
    "serving_size": servingSize,
    "macronutrients": macronutrients,
  };
}

class MacronutrientsBean {
  String? protein;
  String? fat;
  String? carbohydrates;

  static MacronutrientsBean? fromMap(Map<String, dynamic> map) {
    MacronutrientsBean macronutrientsBean = MacronutrientsBean();
    macronutrientsBean.protein = map['protein'];
    macronutrientsBean.fat = map['fat'];
    macronutrientsBean.carbohydrates = map['carbohydrates'];
    return macronutrientsBean;
  }

  Map toJson() => {
    "protein": protein,
    "fat": fat,
    "carbohydrates": carbohydrates,
  };
}

/*
class VegBean {
  String? name;
  String? preference;
  String? image;
  int? calories;
  String? servingSize;
  MacronutrientsData? macronutrients;

  static VegBean? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    VegBean vegBean = VegBean();
    vegBean.name = map['name'];
    vegBean.preference = map['preference'];
    vegBean.image = map['image'];
    vegBean.calories = map['calories'];
    vegBean.servingSize = map['serving_size'];
    vegBean.macronutrients = MacronutrientsData.fromMap(map['macronutrients']);
    return vegBean;
  }

  Map toJson() => {
    "name": name,
    "preference": preference,
    "image": image,
    "calories": calories,
    "serving_size": servingSize,
    "macronutrients": macronutrients,
  };
}

class MacronutrientsData {
  String? protein;
  String? fat;
  String? carbohydrates;

  static MacronutrientsData? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MacronutrientsData macronutrientsData = MacronutrientsData();
    macronutrientsData.protein = map['protein'];
    macronutrientsData.fat = map['fat'];
    macronutrientsData.carbohydrates = map['carbohydrates'];
    return macronutrientsData;
  }

  Map toJson() => {
    "protein": protein,
    "fat": fat,
    "carbohydrates": carbohydrates,
  };
}*/
