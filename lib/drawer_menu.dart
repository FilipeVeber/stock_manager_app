import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final PageController _pageController;

  const DrawerMenu(this._pageController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerMenuTile(Icons.wallet, "Wallet", _pageController, 0),
          DrawerMenuTile(Icons.insert_chart, "Stocks", _pageController, 1),
        ],
      ),
    );
  }
}

class DrawerMenuTile extends StatelessWidget {
  final IconData _icon;
  final String _description;
  final PageController _pageController;
  final int _page;

  const DrawerMenuTile(
      this._icon, this._description, this._pageController, this._page);

  @override
  Widget build(BuildContext context) {
    var color = _pageController.page!.round() == _page
        ? Theme.of(context).primaryColor
        : Colors.grey[700];

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: SizedBox(
            height: 60,
            child: Row(
              children: <Widget>[
                Icon(
                  _icon,
                  size: 32,
                  color: color,
                ),
                const SizedBox(
                  width: 32,
                ),
                Text(
                  _description,
                  style: TextStyle(
                    fontSize: 16,
                    color: color,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            _pageController.jumpToPage(_page);
          },
        ),
      ),
    );
  }
}
