# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2025-08-28

### Added

- **New Feature**: `getUtcNowUnixTimeMilliseconds()` method that returns Unix timestamp in milliseconds
  - Similar to .NET's `DateTimeOffset.UtcNow.ToUnixTimeMilliseconds()` functionality
  - Synchronized with server time difference for accurate timestamping
  - Available through both repository and use cases layers
- Comprehensive test coverage for the new Unix timestamp functionality
- Enhanced documentation with usage examples and API reference

### Changed

- Updated repository interface to include the new Unix timestamp method
- Enhanced use cases with Unix timestamp functionality
- Improved test suite with additional validation for timestamp format

### Technical Details

- The new method applies server time synchronization (if available) before generating the Unix timestamp
- Returns `Future<int>` representing milliseconds since Unix epoch
- Follows the existing architecture pattern with proper dependency injection support

## [1.0.0] - 2025-08-28

### Added

- Initial release of Sync Timer package
- Server time synchronization functionality
- Version generation in `yyyyMMddHHmmssSSS` format
- SharedPreferences integration for persistent time difference storage
- Clean architecture implementation with repository pattern
- Dependency injection support using GetIt
- Comprehensive test suite

### Features

- `calculateServerTimeDiff()`: Calculate time difference between client and server
- `getVersion()`: Generate synchronized version strings
- Automatic time difference persistence
- Support for 17-digit server time format (yyyyMMddHHmmssSSS)

### Dependencies

- shared_preferences: ^2.5.1
- intl: ^0.20.2
- get_it: ^8.0.3
