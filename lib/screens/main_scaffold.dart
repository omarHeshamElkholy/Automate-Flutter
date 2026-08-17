import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/car_provider.dart';
import '../providers/specialist_provider.dart';
import 'dashboard_screen.dart';
import 'my_garage_screen.dart';
import 'specialists_list_screen.dart';
import 'expenses_screen.dart';
import 'profile_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch user's cars on login / app launch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final carProvider = Provider.of<CarProvider>(context, listen: false);
      carProvider.fetchCars().then((_) {
        carProvider.fetchAllRecords();
      });
      Provider.of<SpecialistProvider>(context, listen: false).fetchServiceCenters();
    });
  }

  final List<Widget> _pages = [
    const DashboardScreen(), // Services (Fleet Dashboard)
    const MyGarageScreen(),  // Garage
    const SpecialistsListScreen(), // Records / Specialists placeholder
    const ExpensesScreen(), // Expenses
    const ProfileScreen(), // Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFE5EEFF), width: 1)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: const Color(0xFF515F74),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_repair_service), label: 'Services'),
            BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Garage'),
            BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Workshops'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Expenses'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
