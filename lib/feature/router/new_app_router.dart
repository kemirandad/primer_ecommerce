import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primer_ecommerce/feature/models/producto_model.dart';
import 'package:primer_ecommerce/feature/providers/carrito_provider.dart';
import 'package:primer_ecommerce/feature/screens/carrito_screen.dart';
import 'package:primer_ecommerce/feature/screens/login_screen.dart';
import 'package:primer_ecommerce/feature/screens/perfil_screen.dart';
import 'package:primer_ecommerce/feature/screens/producto_detail_screen.dart';
import 'package:primer_ecommerce/feature/screens/productos_screen.dart';


final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    ShellRoute(
      builder: (context, state, child) {
        return ScaffolConTabs(child: child);
      },
      routes: [
        GoRoute(
          path: '/productos',
          builder: (context, state) {
            return ProductosScreen();
          },
          routes: [
            GoRoute(
              path: 'detail/:id',
              builder: (context, state) {
                final producto = state.extra as ProductoModel;
                return ProductoDetailScreen(producto: producto);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/carrito',
          builder: (context, state) {
            return CarritoScreen();
          },
        ),
        GoRoute(
          path: '/perfil',
          builder: (context, state) {
            return PerfilScreen();
          },
        ),
      ],
    ),
  ],
);

class ScaffolConTabs extends StatelessWidget {
  final Widget child;
  const ScaffolConTabs({super.key, required this.child});

  int _indexActual(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/carrito')) return 1;
    if (location.startsWith('/perfil')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: carritoProvider.state,
        builder: (context, items, child) => NavigationBar(
          selectedIndex: _indexActual(context),
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                context.go('/productos');
              case 1:
                context.go('/carrito');
              case 2:
                context.go('/perfil');
            }
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.shopify_outlined),
              selectedIcon: Icon(Icons.shopify),
              label: 'Productos',
            ),
            NavigationDestination(
              icon: Badge.count(
                count: carritoProvider.totalItems,
                child: Icon(Icons.shopping_cart_outlined),
              ),
              selectedIcon: Badge.count(
                count: carritoProvider.totalItems,
                child: Icon(Icons.shopping_cart),
              ),
              label: 'Productos',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
