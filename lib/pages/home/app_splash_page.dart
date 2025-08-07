import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:fx_platform_adapter/fx_platform_adapter.dart';
import 'package:wolf_im/config/app/app_config.dart';
import 'package:wolf_im/config/app/app_const_field.dart';
import 'package:wolf_im/config/app/global_value.dart';
import 'package:wolf_im/config/theme/app_text_style.dart';
import 'package:wolf_im/widgets/flutter_unit_text_widget.dart';

/// 说明: app 闪屏页
class WolfIMSplashPage extends StatelessWidget {
  const WolfIMSplashPage({super.key});

  // 1. AppStartListener类是fx_boost_starter框架提供，作用是监听框架内部应用启动过程的事件AppStatus。
  //  当框架收到AppStatus事件后，通过框架bloc获取AppStartAction，触发业务应用启动回调。
  //  流程：main() -> WolfIMApplication -> 实现app和repository -> 同时也实现了AppStartAction中的所有接口 ->
  //      初始化fx框架的AppStartBloc(AppStatus) -> startApp() -> 状态改变 -> 框架BlocListener<AppStartBloc> ->
  //      fx框架read action -> 触发业务应用层回调(WolfIMApplication中实现AppStartAction的接口)

  // 2. AnnotatedRegion 是一个用于向系统传递特定区域元数据的 Widget，主要作用是控制与该区域关联的系统级 UI 元素的样式（如状态栏、底部导航栏等），
  //    实现应用 UI 与系统 UI 的视觉协调。
  // 核心作用：配置系统级 UI 样式
  //    AnnotatedRegion 的核心功能是通过传递元数据（通常是 SystemUiOverlayStyle 类型），
  //    告诉操作系统如何渲染当前区域对应的系统 UI 元素（如状态栏的背景色、文字颜色，底部导航栏的样式等）。
  // 最常见的使用场景是控制状态栏（Status Bar）和底部导航栏（Navigation Bar）的样式，例如：
  //    状态栏文字颜色（亮色 / 暗色）；
  //    状态栏背景色；
  //    底部导航栏的背景色和图标颜色。
  // 工作原理
  //    AnnotatedRegion 本身不直接渲染 UI，而是通过 value 参数传递一个 “元数据对象”（如 SystemUiOverlayStyle），
  //    并将该元数据与子 Widget 所在的区域关联。当 Flutter 框架渲染到该区域时，会读取这个元数据，并通知操作系统调整对应的系统 UI 样式。

  // 3. SystemUiOverlayStyle 是 Flutter 中用于配置系统级 UI 覆盖层（如状态栏、底部导航栏）样式的类，主要作用是定义这些系统元素的视觉属性（如颜色、亮度等），
  //    以实现应用与系统 UI 的风格统一。它通常与 AnnotatedRegion 或 AppBar 配合使用，控制特定区域的系统 UI 表现。
  // 核心作用： SystemUiOverlayStyle 专注于描述系统级 UI 元素的样式规则，这些元素包括：
  //    状态栏（Status Bar）：屏幕顶部显示时间、电量等信息的区域。
  //    底部导航栏（System Navigation Bar）：屏幕底部的虚拟按键区域（如返回、主页键，主要存在于 Android 设备）。
  //
  // 通过配置其属性，可以控制这些区域的背景色、文字 / 图标颜色、亮度等，适配应用的主题（如深色 / 浅色模式）。
  //      属性	                                            作用说明	                                            适用平台
  //      statusBarColor	                        状态栏背景色（透明或具体颜色）	                            主要用于 Android；iOS 部分场景（如全屏）可能生效
  //      statusBarIconBrightness	        状态栏图标和文字的亮度（Brightness.light 对应白色，dark 对应黑色）	  仅 Android（控制图标 / 文字颜色）
  //      statusBarBrightness	            状态栏的亮度（影响文字颜色，与 statusBarIconBrightness 逻辑类似）	  仅 iOS（控制状态栏文字颜色）
  //      systemNavigationBarColor	                   底部导航栏的背景色	                                      仅 Android
  //      systemNavigationBarIconBrightness	底部导航栏图标的亮度（控制图标颜色）	                                    仅 Android
  //      systemNavigationBarDividerColor	底部导航栏分割线颜色（如导航栏与内容区的分隔线）	                          仅 Android（API 28+ 支持）
  //      systemStatusBarContrastEnforced	是否强制状态栏文字 / 图标与背景色的对比度（确保可读性）	                    仅 Android（API 29+ 支持）
  //      systemNavigationBarContrastEnforced	是否强制导航栏图标与背景色的对比度	                                仅 Android（API 29+ 支持）
  @override
  Widget build(BuildContext context) {
    return const AppStartListener<AppConfig>(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors
              .transparent, // 状态栏背景色（透明或具体颜色），主要用于 Android；iOS 部分场景（如全屏）可能生效。
          statusBarIconBrightness: Brightness
              .dark, // 状态栏图标和文字的亮度（Brightness.light 对应白色，dark 对应黑色），仅 Android（控制图标 / 文字颜色）。
        ),
        child: Material(color: Colors.white, child: _SplashBody()),
      ),
    );
  }
}

class _SplashBody extends StatelessWidget {
  const _SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(
      context,
    ).primaryColor; // 当前上下文的 “主色调”，确保颜色与应用全局主题保持一致。当主题切换（如从亮色模式切换到暗色模式）时，primaryColor 会自动使用对应主题的配置，避免手动修改多处颜色。
    const TextStyle shadowStyle = AppTextStyle
        .splashShadows; // 定义一个带阴影的文本样式 shadowStyle，其值引用自全局样式类 AppTextStyle 中的静态属性 splashShadows。
    const TextStyle titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
    ); // 定义一个加粗的标题文本样式 titleStyle。

    // 通过 Column、Expanded、Wrap、Stack 等组件构建了上下分区域的布局，上半部分展示应用标识（图标 + 名称），下半部分展示底部说明文字，整体呈现居中、有层次的视觉效果。
    //    顶部：   展示标题栏logo和窗口控制按钮
    //    上半部分：居中展示应用核心标识（组合图标 + 应用名称），强化品牌认知；
    //    下半部分：底部展示辅助信息（如版权、 slogan 等），布局紧凑且有层次。
    return Column(
      children: [
        // 自适应平台的窗口标题栏：
        const SplashTopBar(
          leading: Text(AppConstField.appSplashLeading, style: titleStyle),
          logo: CircleAvatar(
            backgroundImage: AssetImage(AppConstField.appSplashLogo),
            radius: 14,
          ),
        ),
        // Spacer() 是一个用于灵活分配 Flex 布局（如 Row 或 Column）中剩余空间的 Widget，核心作用是 “撑开” 子组件之间的距离，实现灵活的布局调整。
        // Spacer 会在 Row（水平布局）或 Column（垂直布局）中占据所有未被其他子组件占用的剩余空间，从而推动其他子组件向两端或指定方向排列。
        // 简单说：它就像一个 “弹性空白”，自动填充布局中的空闲区域，让相邻组件之间的距离根据剩余空间动态调整。
        const Spacer(),
        Expanded(
          child: Wrap(
            direction: Axis.vertical, // 垂直方向排列子组件
            alignment: WrapAlignment.center, // 垂直方向居中对齐
            crossAxisAlignment: WrapCrossAlignment.center, // 水平方向居中对齐
            children: [
              const Stack(
                children: [ColorfulText(), FlutterLogo(size: 60)],
              ), // 叠加的图标
              const SizedBox(height: 20), // 图标与文字的垂直间距
              FlutterUnitTextWidget(
                text: AppConstField.appName,
                color: color,
              ), // 应用名称
            ],
          ),
        ),
        const Expanded(
          child: Stack(
            alignment:
                Alignment.bottomCenter, // 栈布局，所有子组件默认靠底部居中对齐，确保底部文本整体在屏幕下方。
            children: [
              Positioned(
                bottom: 15, // 距离底部15px
                child: Wrap(
                  direction: Axis.vertical, // 垂直排列
                  alignment: WrapAlignment.center, // 垂直居中
                  crossAxisAlignment: WrapCrossAlignment.center, // 水平居中
                  children: [
                    Text(
                      AppConstField.appSplashBottomText1,
                      style: shadowStyle, // 带阴影的文本样式
                    ),
                    Text(
                      AppConstField.appSplashBottomText2,
                      style: shadowStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 这个 ColorfulText 是一个自定义的装饰性文本组件，核心功能是展示一个带有多彩渐变效果的字母 "U"，
//    通过自定义画笔（Paint）实现了文字的渐变描边或填充效果，属于视觉增强型组件。
//
// 这部分是实现 “彩色文字” 的核心，通过 Paint 配置了一个复杂的渐变效果：
//    PaintingStyle.stroke：设置绘制模式为 “描边”（文字边缘会显示渐变，内部可能透明；若改为 fill 则文字内部填充渐变）。
//    ui.Gradient.linear：创建线性渐变，从起点到终点依次显示指定颜色。
//    颜色序列 [red, yellow, blue, green] 表示渐变包含红→黄→蓝→绿四种颜色；
//    位置数组 [1/4, 2/4, 3/4, 1] 定义颜色过渡点：红色占 1/4 长度，黄色占 2/4，蓝色占 3/4，绿色占剩余部分；
//    TileMode.mirror：当渐变长度不足时，以 “镜像” 方式重复（如渐变结束后反向重复，避免生硬截断）；
//    旋转矩阵 Matrix4.rotationZ(pi / 4)：将原本水平的渐变（从 (0,0) 到 (22,0)）旋转 45 度（π/4 弧度），使渐变呈对角线方向。
class ColorfulText extends StatelessWidget {
  const ColorfulText({super.key});

  @override
  Widget build(BuildContext context) {
    final Paint paint = Paint()
      ..style = PaintingStyle
          .stroke // 绘制样式：描边（stroke）或填充（fill）
      ..shader = ui.Gradient.linear(
        // 线性渐变着色器
        const Offset(0, 0), // 渐变起始点（相对坐标）
        const Offset(22, 0), // 渐变结束点（相对坐标，水平方向22单位）
        [
          Colors.red,
          Colors.yellow,
          Colors.blue,
          Colors.green,
        ], // 渐变结束点（相对坐标，水平方向22单位）
        [1 / 4, 2 / 4, 3 / 4, 1], // 颜色位置（0~1范围，对应颜色在渐变中的占比）
        TileMode.mirror, // 渐变超出范围时的重复模式：镜像重复
        Matrix4.rotationZ(pi / 4).storage, // 渐变旋转矩阵（旋转45度）
      );
    return Text(
      AppConstField.appSplashColorfulText,
      style: TextStyle(
        fontSize: 26,
        height: 1,
        fontWeight: FontWeight.bold,
        foreground: paint,
      ),
    );
  }
}

// 这段代码实现了一个自适应平台的窗口标题栏：
//
//    仅在桌面平台显示，非桌面平台隐藏（返回空容器）；
//    标题栏左侧可显示 logo 和应用信息，右侧显示窗口控制按钮；
//    整个标题栏区域支持鼠标拖拽，实现窗口移动（通过 DragToMoveWrapper）；
//     布局通过 Stack 层叠和 Row 水平排列，确保左右内容互不干扰，视觉结构清晰。
class SplashTopBar extends StatelessWidget {
  final Widget? leading;
  final Widget? logo;

  const SplashTopBar({super.key, this.leading, this.logo});

  // 1. DragToMoveWrapper 是一个桌面端应用专用的交互包装组件，核心作用是为子组件区域添加窗口拖拽和双击最大化 / 恢复的交互功能，
  //    提升桌面应用（如 Windows、macOS、Linux 平台）的窗口操作体验；仅在桌面端生效。

  @override
  Widget build(BuildContext context) {
    if (!kIsDesk)
      // // SizedBox.shrink() 是 SizedBox 组件的一个静态方法，用于创建一个尺寸为 0（宽度和高度均为 0）的不可见容器。它的核心作用是在布局中作为 “空占位符”，不占用任何空间，但保持 Widget 树的结构完整性。
      return const SizedBox.shrink();
    return DragToMoveWrapper(
      // Stack 用于层叠显示标题栏的两部分内容：左侧的信息区和右侧的控制按钮区，确保控制按钮始终在右上角，不被左侧内容挤压。
      child: Stack(
        children: [
          // 标题栏左侧内容（logo、文字等）
          Container(
            alignment: Alignment.topLeft, // 内容靠左上角对齐
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8,
            ), // 内边距
            child: Row(
              // 水平排列子元素
              children: [
                if (leading != null)
                  Row(
                    children: [
                      if (logo != null) logo!,
                      const SizedBox(width: 8),
                      leading!,
                    ],
                  ),
                const Spacer(), // 占据剩余空间，将左侧内容推到最左
                const SizedBox(width: 20), // 右侧预留20px间距，避免内容与窗口按钮重叠
              ],
            ),
          ),
          // 标题栏右侧窗口控制按钮

          // Positioned(right: 0) 使子组件固定在右上角，不受左侧内容影响；
          // WindowButtons 是一个自定义组件，包含桌面窗口的标准控制按钮：最小化、最大化 / 恢复、关闭按钮（这是桌面应用标题栏的标配），
          //    同时支持添加自定义按钮，适配应用主题样式，并与系统窗口管理器交互实现窗口状态控制。
          //    actions：可选的自定义按钮列表（List<Widget>?），允许在标准控制按钮前添加额外的自定义交互按钮（如 “设置”“帮助” 等）。
          //    size：按钮尺寸（默认 30），统一控制所有按钮的宽高，确保视觉一致性。
          const Positioned(right: 0, child: WindowButtons()),
        ],
      ),
    );
  }
}
