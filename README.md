# Cool linter

## Usage

1. Add dependency to `pubspec.yaml`

    ```yaml
    dev_dependencies:
      cool_linter: ^0.0.5
    ```

2. Add configuration to `analysis_options.yaml`

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
    ```

  * pattern - RegExp-pattern, for example: Test123{1}, ^Test123$ and others
  * severity - [optional parameter]. It is console information level. May be WARNING, INFO, ERROR. Default is WARNING
  * hint - [optional parameter]. It is console information sentence
3. Result

  example:
  ![Screenshot](images/analysis_options.yaml.png)
  ![Screenshot](images/linter1.png)
  ![Screenshot](images/linter2.png)