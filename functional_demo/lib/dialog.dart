import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Dialog'),
      ),
      body: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      ElevatedButton(
          onPressed: () async {
            bool result = await showConfirmDialog(context);
            print('Dialog Result: $result');
          },
          child: Text('Confirm Dialog')),
      ElevatedButton(
          onPressed: () => showSimpleDialog(context),
          child: Text('Simple Dialog')),
      ElevatedButton(
          onPressed: () => showListDialog(context), child: Text('List Dialog')),
      ElevatedButton(
          onPressed: () => showCustomDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Alert Dialog'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('取消')),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('确定')),
                  ],
                  content: Text('这是一个普通对话框'),
                );
              }),
          child: Text('Custom Dialog')),
      ElevatedButton(
          onPressed: () async {
            bool result = await showCheckboxDialog(context);
            print('Checkbox Result: $result');
          },
          child: Text('Checkbox Dialog')),
      ElevatedButton(
          onPressed: () async {
            int index = await _showModalBottomSheet(context);
            print('Result: $index');
          },
          child: Text('BottomSheet Dialog')),
      ElevatedButton(
          onPressed: () {
            showFullBottomSheet(context);
          },
          child: Text('Fullscreen BottomSheet Dialog')),
      ElevatedButton(
          onPressed: () => showLoadingDialog(context),
          child: Text('Loading Dialog')),
      ElevatedButton(
          onPressed: () => showCustomLoadingDialog(context),
          child: Text('Custom Loading Dialog')),
      ElevatedButton(
          onPressed: () async {
            var datetime = await showDatePickerDialog(context);
            print('CHoose Time: $datetime');
          },
          child: Text('Date Picker Dialog'))
    ]);
  }
}

Future showConfirmDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alert Dialog'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('取消')),
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('确定')),
          ],
          content: Text('这是一个普通对话框'),
        );
      });
}

Future showSimpleDialog(BuildContext context) async {
  var languages = ['简体中文', '英语'];
  int i = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('请选择语言'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: Text(languages[0]),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(1),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: Text(languages[1]),
              ),
            ),
          ],
        );
      });
  if (i != null) {
    print('选择了：${languages[i]}');
  }
}

Future showListDialog(BuildContext context) async {
  int index = await showDialog(
    context: context,
    builder: (context) {
      return Column(
        children: [
          Text('请选择'),
          Expanded(
              child: Dialog(
            child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('$index'),
                    onTap: () => Navigator.pop(context, index),
                  );
                }),
          ))
        ],
      );
    },
  );
  if (index != null) {
    print('点击了 $index');
  }
}

Future<T> showCustomDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (buildContext, animation, secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black87,
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

Future showCheckboxDialog(BuildContext context) {
  bool _withTree = false;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Checkbox Dialog'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('取消')),
            TextButton(
                onPressed: () => Navigator.of(context).pop(_withTree),
                child: Text('删除')),
          ],
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('是否删除当前文件夹？'),
              Row(
                children: [
                  Builder(builder: (context) {
                    return Checkbox(
                        value: _withTree,
                        onChanged: (value) {
                          (context as Element).markNeedsBuild();
                          _withTree = !_withTree;
                        });
                  }),
                  Text('包含子目录'),
                ],
              )
            ],
          ),
        );
      });
}

Future _showModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('$index'),
                onTap: () => Navigator.pop(context, index),
              );
            });
      });
}

// 父组件必须要有Scaffold
PersistentBottomSheetController<int> showFullBottomSheet(BuildContext context) {
  return showBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text('$index'),
                  onTap: () {
                    print('$index');
                    Navigator.pop(context);
                  });
            });
      });
}

Future showLoadingDialog(BuildContext context) {
  return showDialog(
      // 禁止点击遮罩关闭对话框
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(top: 26.0),
                child: Text('加载中，请稍后...'),
              )
            ],
          ),
        );
      });
}

Future showCustomLoadingDialog(BuildContext context) {
  return showDialog(
    // 禁止点击遮罩关闭对话框
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return UnconstrainedBox(
        constrainedAxis: Axis.vertical,
        child: SizedBox(
          width: 200.0,
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top: 26.0),
                  child: Text('加载中，请稍后...'),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future showDatePickerDialog(BuildContext context) {
  var date = DateTime.now();
  return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(Duration(days: 30)));
}
