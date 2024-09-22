import 'package:flutter/material.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/screens/categories.dart';
import 'package:mealsapp/screens/filters.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/main_drawer.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lastoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filters, bool> _selectedFilter = kInitialFilters;

  void _showInfoMessages(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoritesStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessages('Meal Added to Favorites');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessages('Meal Remove From  Favorites');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(
          MaterialPageRoute(builder: (ctx) => FilterScreen(
            currentFilters: _selectedFilter,
          )));
      setState(() {
        _selectedFilter = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availabelMeals = dummyMeals.where((meal) {
      if (_selectedFilter[Filters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilter[Filters.lastoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilter[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilter[Filters.vegan]! && !meal.isVegan) {
        return false;
      }

      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavoriates: _toggleMealFavoritesStatus,
      availabelMeals: availabelMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavoriates: _toggleMealFavoritesStatus,
      );
      activePageTitle = 'Your Favoriates';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
