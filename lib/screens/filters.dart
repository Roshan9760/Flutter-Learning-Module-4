import 'package:flutter/material.dart';
import 'package:mealsapp/screens/tabs.dart';
import 'package:mealsapp/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  @override
  State<FilterScreen> createState() {
    // TODO: implement createState
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeFilterSet = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters !'),
      ),
      drawer: MainDrawer(onSelectScreen: (identifier) {
        Navigator.of(context).pop();
        if (identifier == 'meals') {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) => TabsScreen()));
        }
      }),
      body: Column(
        children: [
          SwitchListTile(
            value: _glutenFreeFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _glutenFreeFilterSet = isChecked;
              });
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include gluten-free meals',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          )
        ],
      ),
    );
  }
}
