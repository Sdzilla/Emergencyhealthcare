import 'package:emergencyhealthcare/constants.dart';
import 'package:emergencyhealthcare/ui/views/search/search_viewmodel.dart';
import 'package:emergencyhealthcare/ui/widgets/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back), onPressed: model.onPop),
                  Expanded(
                    child: RoundedInputField(
                      icon: Icons.search,
                      hintText: 'Search a Hospital',
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        model.query = value;
                      },
                    ),
                  ),
                  SizedBox(width: 18)
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: model.searchResult.length < 1
                      ? model.hospitals.length
                      : model.searchResult.length,
                  itemBuilder: (context, index) {
                    var hospital = model.searchResult.length < 1
                        ? model.hospitals
                        : model.searchResult;
                    return MaterialButton(
                      onPressed: () {
                        model.getAdmit(hospital[index].name);
                      },
                      padding: EdgeInsets.all(18),
                      splashColor: kPrimaryColor.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 8),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: Icon(
                              Icons.medical_services,
                              color: kPrimaryColor,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hospital[index].name,
                                  style: kFont(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  hospital[index].location,
                                  style: kFont(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SearchViewModel(),
    );
  }
}
