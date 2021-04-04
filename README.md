# Cool linter

## Usage

1. Add dependency to `pubspec.yaml`

    ```yaml
    dev_dependencies:
      cool_linter: ^0.0.1
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
          pattern: Test
          hint: Use Test1 instead!
          severity: ERROR
    ```