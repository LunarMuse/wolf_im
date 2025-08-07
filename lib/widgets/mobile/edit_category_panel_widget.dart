import 'package:flutter/material.dart';
import 'package:wolf_im/config/theme/unit_color.dart';
import 'package:wolf_im/utils/color_utils.dart';
import 'package:wolf_im/widgets/color_chooser.dart';
import 'package:wolf_im/widgets/edit_panel.dart';
import 'package:wolf_im/widgets/input_button.dart';

/// create by 张风捷特烈 on 2020-04-23
/// contact me by email 1981462002@qq.com
/// 说明:

enum EditType { add, update }

class CategoryModel {
  final int? id;
  final String name;
  final String info;
  final String? createDate;
  final String? imageCover;
  final int? count;
  final Color color;

  const CategoryModel({
    required this.name,
    required this.id,
    required this.info,
    this.createDate,
    this.imageCover,
    this.count,
    required this.color,
  });
} // TODO:

class EditCategoryPanelWidget extends StatefulWidget {
  final CategoryModel? model;
  final EditType type;

  const EditCategoryPanelWidget({
    Key? key,
    this.model,
    this.type = EditType.add,
  }) : super(key: key);

  @override
  _EditCategoryPanelState createState() => _EditCategoryPanelState();
}

class _EditCategoryPanelState extends State<EditCategoryPanelWidget> {
  String name = '';
  String color = '';
  String info = '';

  int get colorIndex => widget.model == null
      ? 0
      : UnitColor.collectColorSupport
            .map((e) => e.value)
            .toList()
            .indexOf(widget.model!.color.value);

  @override
  void initState() {
    super.initState();
    info = widget.model?.info ?? '';
    color =
        (widget.model == null
            ? null
            : ColorUtils.colorString(widget.model!.color)) ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: InputButton(
            defaultText: '${widget.model?.name ?? ''}',
            config: const InputButtonConfig(
              hint: '收藏集名称',
              iconData: Icons.check,
            ),
            onSubmit: _doEdit,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: EditPanel(
            defaultText: '${widget.model?.info ?? ''}',
            submitClear: false,
            hint: '收藏集简介...',
            onChange: (v) => info = v,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: ColorChooser(
            defaultIndex: colorIndex,
            colors: UnitColor.collectColorSupport,
            onChecked: (v) => color = ColorUtils.colorString(v),
          ),
        ),
      ],
    );
  }

  void _doEdit(String str) {
    // name = str;
    // if (name.isNotEmpty) {
    //   if (widget.type == EditType.add) {
    //     BlocProvider.of<CategoryBloc>(
    //       context,
    //     ).add(EventAddCategory(name: name, info: info, color: color));
    //   }
    //   if (widget.type == EditType.update) {
    //     BlocProvider.of<CategoryBloc>(context).add(
    //       EventUpdateCategory(
    //         id: widget.model!.id!,
    //         name: name,
    //         info: info,
    //         color: color,
    //       ),
    //     );
    //   }
    // }
    Navigator.of(context).pop();
  }
}
