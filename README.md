# Cool linter

  This is a custom linter for dart/flutter code. It can set linter for exclude some of words. This words you can set
  in analysis_options.yaml by example below

## Usage

### 1. Add dependency to `pubspec.yaml`

    ```yaml
    dev_dependencies:
      cool_linter: ^0.0.7 # last version of plugin
    ```

###  2. Add configuration to `analysis_options.yaml`

    ```yaml
    analyzer:
      plugins:
        - cool_linter

    cool_linter:
      exclude_words:
        -
          pattern: Colors
          hint: Use colors from design system instead!
          severity: WARNING
        -
          pattern: Test123{1}
          severity: ERROR
      exclude_folders:
        - test/**
        - lib/ku/**
    ```

  * pattern - RegExp-pattern, for example: Test123{1}, ^Test123$ and others
  * severity - [optional parameter]. It is console information level. May be WARNING, INFO, ERROR. Default is WARNING
  * hint - [optional parameter]. It is console information sentence
  * exclude_folders - this folders linter will ignore. By default included folders are:

  ```dart
  '.dart_tool/**',
  '.vscode/**',
  'packages/**',
  'ios/**',
  'macos/**',
  'web/**',
  'linux/**',
  'windows/**',
  'go/**',
  ```

## Attention!!!
##  You must restart your IDE for starting plugin

### 3. Result

  ![Screenshot](images/analysis_options.yaml.png)
  ![Screenshot](images/linter1.png)
  ![Screenshot](images/linter2.png)