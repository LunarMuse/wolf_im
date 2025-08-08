import 'package:flutter/material.dart';
import 'package:wolf_im/config/app/app_const_field.dart';

class HomeDrawerHeaderWidget extends StatelessWidget {
  final Color color;

  const HomeDrawerHeaderWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: const EdgeInsets.only(top: 10, left: 15),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/wy_300x200_filter.webp'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 35),
              Text(
                AppConstField.appName,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(1, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            '个人信息',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: color,
                  offset: const Offset(.5, .5),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '简介',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: color,
                  offset: const Offset(.5, .5),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: <Widget>[
              Spacer(flex: 5),
              Text(
                '—— OpenIM',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.orangeAccent,
                      offset: Offset(.5, .5),
                      blurRadius: 1,
                    ),
                  ],
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        ],
      ),
    );
  }
}
