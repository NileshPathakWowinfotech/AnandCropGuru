import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/response/status.dart';
import 'package:provider/provider.dart';

import '../view_model/home_view_model.dart';

class MyPostApi extends StatefulWidget {
  const MyPostApi({super.key});

  @override
  State<MyPostApi> createState() => _MyPostApiState();
}

class _MyPostApiState extends State<MyPostApi> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  @override
  void initState() {
    homeViewViewModel.labTestingType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              homeViewViewModel.labTestingType();
            },
            child: Text("jhxjcxjc")),
      ),
      body:ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(builder: (context, value, _) {
          switch (value.movieslLists.status!) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.movieslLists.message.toString()));
            case Status.COMPLETED:
              return ListView.builder(
                  itemCount: value.movieslLists.data!.data.length,
                  itemBuilder: (context, index) {
                    dynamic item = value.movieslLists.data!.data[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          value.movieslLists.data!.data[index].testingImg
                              .toString(),
                          errorBuilder: (context, error, stack) {
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          },
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(value.movieslLists.data!.data[index].amount
                            .toString()),
                        subtitle: Text(value
                            .movieslLists.data!.data![index].testingTypeId
                            .toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            
                          ],
                        ),
                      ),
                    );
                  });
          }
          return Container();
        }),
      ),
    );
  }
}