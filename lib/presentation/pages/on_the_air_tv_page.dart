import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnTheAirTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-tv';

  @override
  _OnTheAirTVPageState createState() => _OnTheAirTVPageState();
}

class _OnTheAirTVPageState extends State<OnTheAirTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TVListCubit>().fetchOnTheAirTV());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVListCubit, TVListState>(
          builder: (_, data) {
            if (data.onTheAirState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.onTheAirState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  final tv = data.onTheAirTV[index];
                  return TVCard(tv);
                },
                itemCount: data.onTheAirTV.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
