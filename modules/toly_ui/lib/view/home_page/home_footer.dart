import 'package:flutter/material.dart';
import 'package:toly_ui/app/logic/actions/navigation.dart';
import 'package:tolyui/tolyui.dart';


class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const SizedBox(height: 36,),

        const Divider(),
        Container(
          // height: 56,
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 24),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text('Made by  '),
                  TolyLink(href: kFxGithubUrl, text: 'Fx', onTap: jumpUrl,style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                  ),),
                  const Text(' & '),
                  TolyLink(href: kGithubUrl, text: 'TolyUI', onTap: jumpUrl,style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                  ),),
                ],
              ),
              const SizedBox(height: 2,),
              const Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  Text('Copyright © 2024 张风捷特烈'),
                ],
              ),

              const SizedBox(height: 2,),
              Wrap(
                alignment: WrapAlignment.center,

                crossAxisAlignment: WrapCrossAlignment.center,
                children: [

                  TolyLink(href: kBeiAnUrl, text: '皖ICP备18001618号-2', onTap: jumpUrl,),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      height: 14,
                      child: const VerticalDivider()),
                  TolyLink(href: kWanBeiAnUrl, text: '皖公网安备 34010202600392号', onTap: jumpUrl,),




                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
