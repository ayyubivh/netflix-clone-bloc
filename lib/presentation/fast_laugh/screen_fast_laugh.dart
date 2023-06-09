import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/fast_laugh/fast_laugh_bloc.dart';
import 'widget/video_list_item.dart';

class FastAndLaughScreen extends StatelessWidget {
  const FastAndLaughScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<FastLaughBloc>(context).add(const Initialize());
      },
    );
    return Scaffold(
      body: SafeArea(child: BlocBuilder<FastLaughBloc, FastLaughState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.isError) {
            return const Center(
              child: Text('Oopss..!!\n Error While Getting Data!!'),
            );
          } else if (state.videoList.isEmpty) {
            return const Center(
                child: Text('Oopss..!!\n The List is Empty..!!'));
          } else {
            return PageView(
              scrollDirection: Axis.vertical,
              children: List.generate(
                state.videoList.length,
                (index) => VideoListItemInheritedWidget(
                    widget:
                        VideoListItem(key: Key(index.toString()), index: index),
                    movieData: state.videoList[index]),
              ),
            );
          }
        },
      )),
    );
  }
}
