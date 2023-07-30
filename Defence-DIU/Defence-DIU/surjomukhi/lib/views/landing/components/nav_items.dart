import 'package:flutter/material.dart';

List<BottomNavigationBarItem> get navItems {
  return [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.directions_bus_filled_outlined), label: 'Tickets'),
    BottomNavigationBarItem(
        icon: Icon(Icons.chat_bubble_outline_outlined), label: 'Global Chat'),
    BottomNavigationBarItem(
        icon: Icon(Icons.mode_of_travel_outlined), label: 'Bus Schedule'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
  ];
}
