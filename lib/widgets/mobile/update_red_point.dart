import 'package:flutter/material.dart';

class UpdateRedPoint extends StatelessWidget {
  const UpdateRedPoint({super.key});

  @override
  Widget build(BuildContext context) {
    Widget radPoint = Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
    );
    // return BlocBuilder<UpgradeBloc, UpdateState>(
    //   builder: (BuildContext context, UpdateState state) {
    //     if (state is ShouldUpdateState) {
    //       return radPoint;
    //     } else {
    //       return const SizedBox.shrink();
    //     }
    //   },
    // );
    return const SizedBox.shrink();
  }
}
