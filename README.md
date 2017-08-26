# cr

Short for change-run, it runs a command with every change to the working
directory tree.

### Setup
  Make sure to have inotifywait available

  ```bash
    $ sudo apt-get install inotify-tools
  ```

### Usage

  ```bash
  $ cr bazel --watchfs test --test_output=errors :tests
  ```
