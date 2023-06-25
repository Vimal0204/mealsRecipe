import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals/data/dummy_data.dart';
// import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
// import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screen/categories.dart';
import 'package:meals/screen/filters.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widgets/main_drawer.dart';


const kIntialFilters= {
    Filter.glutenFree: false,
    Filter.lactoseFree:false,
    Filter.vegetarian:false,
    Filter.vegan:false,

  };
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favoriteMeals = [];
  
  

  // void _toggleMealFavoritesStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //       _showInfoMessage('Meal removed to favorite');
  //     });
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage('Meal added from favorite');
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async{
    Navigator.pop(context);
    if (identifier == 'filters') {
      
      await Navigator.of(context).push<Map<Filter,bool >>(
        MaterialPageRoute(
          builder: (ctx) =>  const FiltersScreen(),
        ),
      );
      
      
    } 
    
  }

  @override
  Widget build(BuildContext context) {
    // final availableMeals = dummyMeals.where((meal) {
    //   if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree ){
    //     return false;
    //   }
    //   if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree ){
    //     return false;
    //   }
    //   if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian ){
    //     return false;
    //   }
    //   if(_selectedFilters[Filter.vegan]! && !meal.isVegan ){
    //     return false;
    //   }
    //   return true; 
    // }).toList();
  //  final meals= ref.watch(mealsProvider); 
  //  final activeFilter = ref.watch(filtersProvider);
   final availableMeals = ref.watch(filteredMealProvider);

    
    Widget activePage = CategoriesScreen(
      // onToggleFavorite: _toggleMealFavoritesStatus,
      availableMeals: availableMeals,
    );
    var activePagetitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
        // onToggleFavorite: _toggleMealFavoritesStatus,
      );
      activePagetitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePagetitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Category',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
