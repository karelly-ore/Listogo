import 'package:flutter/material.dart';
import '../views/summary_view.dart';
import '../views/inventory_view.dart';
import '../views/live_monitor_view.dart';
import 'admin_login_screen.dart'; // Importamos el login para poder regresar

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedView = 0;

  // 1. Nueva variable para controlar si el menú está abierto o cerrado
  bool _isExpanded = false;

  final List<Widget> _views = [
    const SummaryView(),
    const InventoryView(),
    const LiveMonitorView(),
    const Center(child: Text("Configuración de Recompensas")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // SIDEBAR (Envuelta en un contenedor para manejar el fondo oscuro completo)
          Container(
            color: const Color(0xFF2C2C2C),
            child: Column(
              children: [
                // 2. El NavigationRail toma todo el espacio disponible arriba
                Expanded(
                  child: NavigationRail(
                    extended: _isExpanded, // Activa la animación de expansión
                    backgroundColor: const Color(0xFF2C2C2C),
                    unselectedIconTheme: const IconThemeData(
                      color: Colors.white54,
                    ),
                    selectedIconTheme: const IconThemeData(
                      color: Color(0xFFFF5A1F),
                    ),
                    unselectedLabelTextStyle: const TextStyle(
                      color: Colors.white54,
                    ),
                    selectedLabelTextStyle: const TextStyle(
                      color: Color(0xFFFF5A1F),
                    ),

                    // 3. Botón superior (Hamburguesa) para abrir/cerrar
                    leading: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, top: 10.0),
                      child: IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded; // Alterna el estado
                          });
                        },
                      ),
                    ),

                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.dashboard),
                        label: Text("Resumen"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.inventory_2),
                        label: Text("Inventario"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.videocam),
                        label: Text("Monitor en Vivo"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.star),
                        label: Text("Premios"),
                      ),
                    ],
                    selectedIndex: _selectedView,
                    onDestinationSelected: (int index) {
                      setState(() => _selectedView = index);
                    },
                  ),
                ),

                // 4. Botón de CERRAR SESIÓN anclado al fondo
                InkWell(
                  onTap: () {
                    // Lógica para regresar a la pantalla de Login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminLoginScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: _isExpanded
                        ? 200
                        : 72, // Se adapta si está abierto o cerrado
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout, color: Colors.redAccent),
                        // Si está expandido, mostramos el texto al lado
                        if (_isExpanded) ...[
                          const SizedBox(width: 15),
                          const Text(
                            "Cerrar Sesión",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const VerticalDivider(thickness: 1, width: 1),

          // CONTENIDO PRINCIPAL
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: _views[_selectedView],
            ),
          ),
        ],
      ),
    );
  }
}
