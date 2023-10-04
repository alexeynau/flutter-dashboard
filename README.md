# Dashboard for nestro-challenge, 3 track

Возможности изменений:

Строки: содержание, кол-во, порядок - да 

Столбцы: названия, порядок - нет

[Постановка задачи для дэшбордов и требования к автоматизации в приложениях](https://autumn-athlete-fea.notion.site/b0f7889d5f774bfea0f683e0ef71b654?pvs=4)

[Скачать установщик](https://github.com/alexeynau/flutter-dashboard/releases/tag/v0.0.3)
## User flow:
0) Установить [приложение](https://github.com/alexeynau/flutter-dashboard/releases/tag/v0.0.3)
1) Запустить приложение с дэшбордами
2) Указать путь к таблице
3) Выбрать - автоматически обновлять таблицу или нет?
Да: запускаем скрипт предобработки, ждем окончания и запускаем скрипт постобработки 
Нет: запускаем скрипт постобработки
4) Подождать пока постобработка с помощью робота закончится
5) Дэшборды отображены

После первого запуска, информация о наличии данных и пути к таблице сохраняется и при повторном запуске приложения робот заново не запускается, а сразу показываются дэшборды


## Сборка проекта:
1) Установите актуальную версию [Flutter](https://docs.flutter.dev/get-started/install)
2) Склонируйте репозиторий
```shell
git clone https://github.com/alexeynau/flutter-dashboard.git
```
3) Запустите приложение
```shell
flutter pub get
flutter run
```
4) Для билда под Windows
```shell
flutter pub get
flutter build windows --release
```

