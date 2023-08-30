import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/firebase_options.dart';
import 'package:pokedex_mobile/providers/category_provider.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/screens/login_screen.dart';
import 'package:pokedex_mobile/screens/pokemon_details.dart';
import 'package:pokedex_mobile/screens/pokemon_favorite_list.dart';
import 'package:pokedex_mobile/screens/pokemon_screen.dart';
import 'package:provider/provider.dart';
import 'screens/category_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CategoryProvider()),
          ChangeNotifierProvider(create: (context) => PokemonProvider()),
          ChangeNotifierProvider(create: (context) => LoginProvider())
        ],
        child: MaterialApp(
          title: 'Pokedex',
          //home: new MainWidget(),
          initialRoute: LoginScreen.routeName,
          routes: {
            MainWidget.routeName: (context) => const MainWidget(),
            PokemonDetailsScreen.routeName: (context) =>
                const PokemonDetailsScreen(),
            CategoryScreen.routeName: (context) => CategoryScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
          },
        ));
  }
}

class MainWidget extends StatefulWidget {
  static const routeName = '/';

  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int _selectedIndex = 0;

  final List<Widget> _mainWidgets = [
    CategoryScreen(),
    PokemonScreenWidget(),
    PokemonFavoriteListScreen()
  ];

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Pokemons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onTapItem,
      ),
    );
  }
}
