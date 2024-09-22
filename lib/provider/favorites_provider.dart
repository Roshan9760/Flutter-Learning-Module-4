import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  // as in provider the value of any things like list can't be add or remove
  // directly or edit the existing list or value  but we can assign new value always .
  //  so we need to add or remove smartly

  bool toggleMealsFavoritesStatus(Meal meal) {
    final mealIsFavorites = state.contains(meal);
    if (mealIsFavorites) {
      state = state.where((newMeal) => newMeal.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final FavoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
