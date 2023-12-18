import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            FeatherIcons.search,
            color: Color(0xFF2BCCC0),
            size: 20,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FeatherIcons.messageCircle,
            color: Color(0xFF2BCCC0),
            size: 20,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FeatherIcons.plusCircle,
            color: Color(0xFF2BCCC0),
            size: 20,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FeatherIcons.bookmark,
            color: Color(0xFF2BCCC0),
            size: 20,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FeatherIcons.user,
            size: 20,
            color: Color(0xFF2BCCC0),
          ),
          label: 'Search',
        ),
      ],
      fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
        switch (idx) {
          case 0:
            // do nothing
            break;
          case 1:
            Navigator.pushNamed(context, '/about');
            break;
          case 2:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
