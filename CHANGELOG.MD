# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

N/A

### Changed

N/A

### Deprecated

N/A

### Removed

N/A

### Fixed

N/A

### Security

N/A

## [v0.3.1]

### Added

- Workflow to stop local depeendcy paths from making it into releases

### Changed

- README Updates

### Fixed

- Dependency paths

## [v0.3.0] - 12/3/2023

### Added

- `FlowApp` View
- `FlowManager.mutate` Convienience Function

### Changed

- Migrated FlowManger to @Observable macro
- Migrated AppProperties to @Observable macro
- Migrated ThemeConfig to @Observable macro

### Removed

- Removed `ResponiveView`
- Removed `ResponsiveApp`

## [v0.2.4]

### Fixed

- Fixed Error View Launching

## [v0.2.3]

### Fixed

- IPFSImage View

## [v0.2.2]

### Fixed

- Dependency Imports

## [v0.2.1]

### Fixed

- Dependency Imports

## [v0.2.0] - 11/31/2023

### Added

- Created a CadenceCode protocol to assist with initializing `CodeBlock`
- Added the ability for the `TransactionView` to automatically appear in any app the package has been added to when a transaction is "subscribed" to within the `flowManager`.
- Added `.responsiveApp` view modifer to assist with building responsive views
- Added `IPFSImage` view

### Changed

- Updated README

## [v0.1.0] - 11/21/2023

### Added

- ButtonView
- Large Button Modifer
- CodeBlock View
- FlowManager Class
- Transaction View
