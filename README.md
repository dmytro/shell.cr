# shell

Small simplistic helper class for executing shell commands in Crystal:

- run command,
- exit if it fails,
- return STDOUT of the command;
- optionally
  - allow to ignore failure
  - return STDERR of failed command.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  shell:
    github: dmytro/shell.cr
```


## Usage


```crystal
require "shell"
```

Output of the shell command is available through `#stdout` and `#stderr`
methods, numeric value of the exit status returned by the function `#run`.

Simplest usage of the `#run` method:

```crystal
puts Shell.run("ls").stdout
```


If command fails `Shell` raises exception, but this behaviour can be
overridden by `fail_on_error` variable:

```crystal
puts Shell.run("command_with_non_zero_status", fail_on_error: false).stderr
```


## Contributing

1. Fork it ( https://github.com/dmytro/shell/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [dmytro](https://github.com/dmytro) Dmytro Kovalov - creator, maintainer
