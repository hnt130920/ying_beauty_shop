import 'package:flutter/material.dart';
import 'package:ying_beauty/ui/home/home_screen.dart';
import 'package:ying_beauty/ui/order/order_history.dart';
import 'package:ying_beauty/ui/personal/personal_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key, this.index = 0});
  final int index;
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  _BottomBarState();
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    OrderHistory(),

    PersonalSceen(),
    // const ItemDetailScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tôi',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 107, 148, 72),
        onTap: _onItemTapped,
      ),
    );
  }
}
