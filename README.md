# jsonnetdoc

*/!\\ This is a fork from https://github.com/trotttrotttrott/jsonnetdoc that seem to be no longer maintained*

Documentation parser for [JSDoc](https://jsdoc.app/) style comments in Jsonnet.

This is not even close to covering the complete spec. Only descriptions, `@name`, `@param`, and `@return`. The initial motivation for this was [Grafonnet](https://github.com/grafana/grafonnet-lib) which has used this documentation style for quite a while without something to parse it.

See [testdata/](./testdata) for documentation examples.

## Installation

```
go install github.com/AntoineThebaud/jsonnetdoc@master
```

Or clone the repo to build jsonnetdoc from source.

## Usage

Expects a single argument which should be a path to your Jsonnet files. By default, it will output a JSON representation of your documentation. If you pass, the `--markdown` flag, it will instead output Markdown.

```
Usage:
  jsonnetdoc <input-file|dir> [flags]

Flags:
  -h, --help       help for jsonnetdoc
      --markdown   output markdown instead of JSON
```

Example:

```
jsonnetdoc testdata --markdown
```

Same command using Docker:

```
docker run --rm \
  -v $PWD:$PWD \
  -w $PWD \
  AntoineThebaud/jsonnetdoc \
  testdata --markdown
```
