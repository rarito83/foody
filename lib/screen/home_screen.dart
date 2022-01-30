import 'package:flutter/material.dart';
import 'package:foody/data/source.dart';
import 'package:foody/provider/product_provider.dart';
import 'package:foody/screen/widgets/product_grid.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PanelController _panelController = PanelController();

  bool expand = false;
  double marginLeft = 30;
  double marginRight = 30;
  double marginBottom = 20;

  double blRadius = 20;
  double brRadius = 20;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(apiService: ApiService()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Food Product'),
          centerTitle: true,
        ),
        body: Stack(children: [
          SlidingUpPanel(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(blRadius),
              bottomRight: Radius.circular(brRadius),
            ),
            parallaxEnabled: true,
            margin: EdgeInsets.only(
                left: marginLeft, right: marginRight, bottom: marginBottom),
            maxHeight: size.height * 0.8,
            minHeight: 60,
            controller: _panelController,
            onPanelSlide: (position) {
              setState(() {
                marginLeft = ((30 - (30 * position)).abs()).toDouble();
                marginRight = ((30 - (30 * position)).abs()).toDouble();
                marginBottom = ((20 - (20 * position)).abs()).toDouble();

                blRadius = ((20 - (20 * position)).abs()).toDouble();
                brRadius = ((20 - (20 * position)).abs()).toDouble();

                if (position > 0.8) {
                  expand = true;
                }

                if (expand && position < 0.8) {
                  expand = false;
                }
              });
            },
            body: const ProductGrid(),
            panelBuilder: (control) {
              return buildNavigation(control);
            },
          ),
        ]),
      ),
    );
  }

  Widget buildNavigation(ScrollController control) {
    return ListView(
      controller: control,
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              navIcon(Icons.home, 'HOME'),
              navIcon(Icons.settings, 'ACTIVITY'),
              navIcon(Icons.message, 'MESSAGE'),
              navIcon(Icons.person, 'PROFILE'),
            ],
          ),
        ),
        !expand
            ? const SizedBox.shrink()
            : Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  expandIcon(Icons.ac_unit_rounded, 'AC Unit'),
                  expandIcon(Icons.access_alarm_rounded, 'Alarm'),
                  expandIcon(Icons.access_time_filled_rounded, "Time"),
                  expandIcon(Icons.accessibility_new_rounded, "Access")
                ],
              )
      ],
    );
  }

  Widget navIcon(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 2),
        Text(text, style: TextStyle(fontSize: 10)),
      ],
    );
  }

  Widget expandIcon(IconData icon, String text) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      child: GridView.builder(
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 2,
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            return GridTile(
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Icon(icon),
                    Text(text),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
