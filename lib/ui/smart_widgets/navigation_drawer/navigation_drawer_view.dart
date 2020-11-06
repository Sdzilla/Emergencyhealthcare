import 'package:emergencyhealthcare/ui/smart_widgets/navigation_drawer/navigation_drawer_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NavigationDrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationDrawerViewModel>.reactive(
      onModelReady: (model) {
        model.getCurrentUser();
      },
      builder: (context, model, child) => Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.image),
              ),
              accountName: Text('${model.name}'),
              accountEmail: Text('${model.email}'),
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('Theme'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: model.logout,
            ),
          ],
        ),
      ),
      viewModelBuilder: () => NavigationDrawerViewModel(),
    );
  }
}
