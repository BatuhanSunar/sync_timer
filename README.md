# Sync Timer

A Flutter package for server time synchronization and version management. This package provides functionality to calculate time differences with a server and generate synchronized version strings.

## Features

- **Server Time Synchronization**: Calculate and store time differences between client and server
- **Version Generation**: Generate synchronized version strings in `yyyyMMddHHmmssSSS` format
- **Unix Timestamp**: Get current UTC time as Unix timestamp in milliseconds (similar to .NET's `DateTimeOffset.UtcNow.ToUnixTimeMilliseconds()`)
- **Dependency Injection**: Built-in dependency injection support with GetIt
- **Persistent Storage**: Uses SharedPreferences for storing time differences

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  sync_timer: ^1.1.0
```

## Usage

### Setup

First, initialize the sync timer module:

```dart
import 'package:sync_timer/core/container/sync_timer_module.dart';

void main() {
  setUpSyncTimerModule();
  runApp(MyApp());
}
```

### Basic Usage

```dart
import 'package:get_it/get_it.dart';
import 'package:sync_timer/domain/usecases/sync_timer_usecases.dart';

// Get the use cases instance
final syncTimerUsecases = GetIt.instance<SyncTimerUsecases>();

// Calculate server time difference
await syncTimerUsecases.calculateServerTimeDiff(20250828123045123);

// Get synchronized version string
final version = await syncTimerUsecases.getVersion();
print(version); // Output: 20250828123045123

// Get Unix timestamp in milliseconds
final unixTimeMs = await syncTimerUsecases.getUtcNowUnixTimeMilliseconds();
print(unixTimeMs); // Output: 1724851825123
```

### Server Time Format

The server time should be provided as a 17-digit integer in the format: `yyyyMMddHHmmssSSS`

Example: `20250828123045123` represents:

- Year: 2025
- Month: 08
- Day: 28
- Hour: 12
- Minute: 30
- Second: 45
- Millisecond: 123

## API Reference

### SyncTimerUsecases

#### `calculateServerTimeDiff(int serverTime)`

Calculates the time difference between client and server time.

**Parameters:**

- `serverTime`: 17-digit integer representing server time in `yyyyMMddHHmmssSSS` format

**Returns:** `Future<Duration>` - The time difference

#### `getVersion()`

Gets a synchronized version string based on current time and server time difference.

**Returns:** `Future<String>` - Version string in `yyyyMMddHHmmssSSS` format

#### `getUtcNowUnixTimeMilliseconds()`

Gets the current UTC time as Unix timestamp in milliseconds, synchronized with server time.

**Returns:** `Future<int>` - Unix timestamp in milliseconds

## Dependencies

- `shared_preferences: ^2.5.1` - For persistent storage
- `intl: ^0.20.2` - For date formatting
- `get_it: ^8.0.3` - For dependency injection

## Example

```dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sync_timer/core/container/sync_timer_module.dart';
import 'package:sync_timer/domain/usecases/sync_timer_usecases.dart';

void main() {
  setUpSyncTimerModule();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SyncTimerExample(),
    );
  }
}

class SyncTimerExample extends StatefulWidget {
  @override
  _SyncTimerExampleState createState() => _SyncTimerExampleState();
}

class _SyncTimerExampleState extends State<SyncTimerExample> {
  String version = '';
  int unixTimeMs = 0;

  final syncTimerUsecases = GetIt.instance<SyncTimerUsecases>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sync Timer Example')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await syncTimerUsecases.calculateServerTimeDiff(20250828123045123);
              final newVersion = await syncTimerUsecases.getVersion();
              final newUnixTime = await syncTimerUsecases.getUtcNowUnixTimeMilliseconds();

              setState(() {
                version = newVersion;
                unixTimeMs = newUnixTime;
              });
            },
            child: Text('Sync with Server'),
          ),
          Text('Version: $version'),
          Text('Unix Time (ms): $unixTimeMs'),
        ],
      ),
    );
  }
}
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
