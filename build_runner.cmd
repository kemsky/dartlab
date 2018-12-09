@echo off
REM Invoke code generation
REM Sometimes need to clean "flutter packages pub run build_runner clean"
flutter packages pub run build_runner build --delete-conflicting-outputs