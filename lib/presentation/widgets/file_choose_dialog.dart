import 'package:flutter/material.dart';
import '../../data/repositories/windows_repository.dart';
import '../../service_locator.dart';

import '../pages/loading_page.dart';

class FileChooseDialog extends StatefulWidget {
  const FileChooseDialog({super.key});

  @override
  State<FileChooseDialog> createState() => _FileChooseDialogState();
}

class _FileChooseDialogState extends State<FileChooseDialog> {
  WindowsRepository repository = getIt.get<WindowsRepository>();

  bool parseTable = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: repository.getPath(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.data == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Файл не выбран"),
                    ElevatedButton(
                      onPressed: () async {
                        await repository.pickFile();

                        print(snapshot.data);
                        setState(() {});
                      },
                      child: const Text("Выбрать"),
                    ),
                  ],
                ),
              );
            } else {
              return Builder(
                builder: (context) {
                  return Center(
                    child: SizedBox(
                      width: 600,
                      height: 300,
                      child: Dialog(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Выбран файл: ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${snapshot.data}",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "Заполнить таблицу автоматически?",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      repository.watchExcel(snapshot.data!);
                                      parseTable = false;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return LoadingPage(
                                              shouldParseTable: parseTable,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text("Нет"),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await repository.pickFile();
                                    print(snapshot.data);
                                    setState(() {});
                                  },
                                  child: const Text("Выбрать другой файл"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      repository.watchExcel(snapshot.data!);
                                      parseTable = true;
                                    },
                                    child: const Text("Да"),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Отмена"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
