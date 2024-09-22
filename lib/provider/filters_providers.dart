import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/screens/filters.dart';

enum Filters {
  glutenFree,
  lastoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.vegan: false,
          Filters.vegetarian: false,
          Filters.lastoseFree: false,
        });
  void setFilters(Map<Filters, bool> choosenFilters) {
    state = choosenFilters;
  }

  void setFilter(Filters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final FiltersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
  (ref) => FiltersNotifier(),
);
