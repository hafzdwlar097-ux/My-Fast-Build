// Unique_Build_nsdj_1770482784
To set up a new Flutter project and add the necessary dependencies for a file transfer app using shelf_static and shelf, follow these steps:

First, create a new Flutter project:

```bash
flutter create file_transfer_app
```

Then, navigate to the project directory:

```bash
cd file_transfer_app
```

Next, add the necessary dependencies to the `pubspec.yaml` file:

```yml
dependencies:
  flutter:
    sdk: flutter
  shelf: ^1.3.0
  shelf_static: ^1.1.0
```

Run `flutter pub get` to get the dependencies.

Now, create a new file `server.dart` in the `lib` directory and add the following code to set up a basic shelf server:

```dart
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart';

Future<void> main() async {
  var server = await shelf_io.serve(
    const Pipeline().addMiddleware(logRequests()).addHandler(_handler),
    InternetAddress.anyIPv4,
    8080,
  );
  print('Server running on port ${server.port}');
}

Handler _handler(Handler _) {
  return const StaticHandler(
    fileSystem: FileSystem.system(),
    urlPrefix: '/files',
    defaultDocument: 'index.html',
  );
}
```

This sets up a basic shelf server that serves static files from the `files` directory.

Next, create a new directory `files` in the root of the project and add some files to it.

To handle file uploads, you will need to add a new endpoint to the `_handler` function. For example:

```dart
Handler _handler(Handler _) {
  return Cascade()
    .add(_staticHandler)
    .add(_uploadHandler);
}

Handler _staticHandler(Handler _) {
  return const StaticHandler(
    fileSystem: FileSystem.system(),
    urlPrefix: '/files',
    defaultDocument: 'index.html',
  );
}

Handler _uploadHandler(Handler _) {
  return (request) async {
    if (request.method != 'POST') {
      return Response.notFound(body: 'Not Found');
    }

    if (request.url.pathSegments.first != 'upload') {
      return Response.notFound(body: 'Not Found');
    }

    final multipartRequest = await request.read().timeout(const Duration(seconds: 10));
    final multipartRequestBody = MultipartRequest(multipartRequest);

    final file = await multipartRequestBody.files.first.value;
    final fileName = file.filename;
    final fileBytes = await file.stream.toBytes();

    await File('files/$fileName').writeAsBytes(fileBytes);

    return Response.ok(body: 'File uploaded successfully');
  };
}
```

This code sets up a new endpoint at `/upload` that accepts POST requests with a multipart body. It saves the uploaded file to the `files` directory.

Now you can use a tool like curl to upload a file to the server:

```bash
curl -X POST -F 'file=@/path/to/file' http://localhost:8080/upload
```

This is a basic example of a file transfer app using shelf_static and shelf. You can add more features like authentication and error handling as needed.

In the Flutter app, you can use the `http` package to send requests to the server. Add the `http` package to your `pubspec.yaml` file:

```yml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.5
```

Then, use the `http` package to send requests to the server. For example:

```dart
import 'package:http/http.dart' as http;

Future<void> uploadFile() async {
  final url = Uri.parse('http://localhost:8080/upload');
  final request = http.MultipartRequest('POST', url);
  request.files.add(http.MultipartFile.fromBytes(
    'file',
    await File('path/to/file').readAsBytes(),
    filename: 'file.txt',
  ));
  final response = await request.send();
  print('Response status: ${response.statusCode}');
}
```

This code sends a POST request to the `/upload` endpoint with a multipart body containing the file.