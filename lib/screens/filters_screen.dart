import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    super.initState();
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
  }

  Widget _buildeSwitchTile(
    String title, 
    String desccription, 
    bool currentValue, 
    Function updateValue
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue, 
      subtitle: Text(desccription),
      onChanged: updateValue,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'vegetarian': _vegetarian,
                'vegan': _vegan,
                'lactose': _lactoseFree,
              };
              widget.saveFilters(selectedFilters);
            }, 
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildeSwitchTile(
                  'Gluten-Free', 
                  'Only include gluten-free meals', 
                  _glutenFree, 
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }
                ),
                _buildeSwitchTile(
                  'Vegetarian', 
                  'Only include vegetarian meals', 
                  _vegetarian, 
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }
                ),
                _buildeSwitchTile(
                  'Vegan', 
                  'Only include vegan meals', 
                  _vegan, 
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  }
                ),
                _buildeSwitchTile(
                  'Lactose-Free', 
                  'Only include lactose-free meals', 
                  _lactoseFree, 
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }
                ),
              ],
            )
          )
        ],
      )
    );
  }
}
