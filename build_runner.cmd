@echo off
REM Invoke code generation
REM Clean: "flutter packages pub run build_runner clean"
REM Watch mode: "flutter packages pub run build_runner watch --delete-conflicting-outputs"
flutter packages pub run build_runner build --delete-conflicting-outputs