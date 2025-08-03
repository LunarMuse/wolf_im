// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-06-09
// Contact Me:  1981462002@qq.com

import 'dart:io';

import 'package:path/path.dart' as path;

import 'display_file_parser.dart';
import 'display_meta.dart';
import 'file_gen.dart';

void main() async {
  await TolyUIGenTool().gen();
}

class TolyUIGenTool {
  const TolyUIGenTool();

  Future<void> gen() async {
    int start = DateTime.now().millisecondsSinceEpoch;

    String dataPath = path.join(Directory.current.path, 'lib/view/widgets');
    Directory dataDir = Directory(dataPath);
    Map<String, List<NodeMeta>> displayMap = {};
    await parserDir(dataDir, displayMap);

    String genPath = path.join(Directory.current.path, 'lib/view/widgets/display_nodes/gen');
    Directory genDir = Directory(genPath);
    if (!genDir.existsSync()) {
      await genDir.create();
    }
    String out = path.join(genPath, 'node.g.dart');
    await FileGen(displayMap).genNode(out);
    int end = DateTime.now().millisecondsSinceEpoch;
    print("生成完毕: 耗时 ${end - start} ms");
  }
}

Future<void> parserDir(Directory dir, Map<String, List<NodeMeta>> displayMap) async {
  List<NodeMeta> displays = [];
  List<FileSystemEntity> entity = dir.listSync();
  for (FileSystemEntity e in entity) {
    if (e is File) {
      NodeMeta? ret = await DisplayFileParser(e.path).parser();
      if (ret != null) {
        displays.add(ret);
        ret.saveCode();
      }
    } else if (e is Directory) {
      await parserDir(e, displayMap);
    }
  }
  if (displays.isNotEmpty) {
    displayMap[path.basename(dir.path)] = displays;
  }
}
