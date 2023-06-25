import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
class FavoriteMealsNotifiers extends StateNotifier<List<Meal>>{
  // FavoriteMealsNotifiers(super.state);
  FavoriteMealsNotifiers():super([]);
  bool toggleMealFavoritesStatus(Meal meal){
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
     
      state = state.where((m) => m.id !=m.id).toList();
      return false;
    }else{
      state=[...state,meal]; 
      return true; 
    }
    

  }
}
final favoriteMealsProvider=StateNotifierProvider<FavoriteMealsNotifiers,List<Meal>>((ref){
  return FavoriteMealsNotifiers();
});