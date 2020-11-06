import 'package:cached_network_image/cached_network_image.dart';
import 'package:emergencyhealthcare/ui/smart_widgets/navigation_drawer/navigation_drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:emergencyhealthcare/ui/views/home/home_viewmodel.dart';
import 'package:map/map.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) {
        model.getCurrentLocation();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Search a Hospital'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: model.onNavigateToSearchView,
                
              ),
            ),
          ],
        ),
        drawer: NavigationDrawerView(),
        body: GestureDetector(
          onDoubleTap: model.onDoubleTap,
          onScaleStart: model.onScaleStart,
          onScaleUpdate: model.onScaleUpdate,
          onScaleEnd: (details) {
            print(
                "Location: ${model.controller.center.latitude}, ${model.controller.center.longitude}");
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Map(
                builder: (context, x, y, z) {
                  final url =
                      'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                  return CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                  );
                },
                controller: model.controller,
              ),
              Center(
                child: Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 48,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: model.gotoDefault,
          tooltip: 'My Location',
          child: Icon(Icons.my_location),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
