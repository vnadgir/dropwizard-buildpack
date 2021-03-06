# OpenJDK JRE
The OpenJDK JRE provides Java runtimes from the [OpenJDK][openjdk] project.  Versions of Java from the `1.6`, `1.7`, and `1.8` lines are available.  Unless otherwise configured, the version of Java that will be used is specified in [`config/openjdk.yml`][openjdk_yml].

[openjdk]: http://openjdk.java.net
[openjdk_yml]: ../config/openjdk.yml

| Detection ||
| --- | ---
| **Tags** | `openjdk-<version>`


## Configuration
The JRE can be configured by modifying the [`config/openjdk.yml`][openjdk_yml] file.  The JRE uses the [`Repository` utility support][util_repositories] and so it supports the [version syntax][version_syntax]  defined there.

[openjdk_yml]: ../config/openjdk.yml
[util_repositories]: util-repositories.md
[version_syntax]: util-repositories.md#version-syntax-and-ordering

| Name | Description
| ---- | -----------
| `version` | The version of Java runtime to use.  Candidate versions can be found in [this listing][openjdk_index_yml].

[openjdk_index_yml]: http://download.pivotal.io.s3.amazonaws.com/openjdk/lucid/x86_64/index.yml

### Memory

| Name | Description
| ---- | -----------
| `java.heap.size` | The Java maximum heap size to use. For example, a value of `64m` will result in the java command line option `-Xmx64m`. Values containing whitespace are rejected with an error, but all others values appear without modification on the java command line appended to `-Xmx`.
| `java.metaspace.size` | The Java maximum Metaspace size to use. This is applicable to versions of OpenJDK from 1.8 onwards. For example, a value of `128m` will result in the java command line option `-XX:MaxMetaspaceSize=128m`. Values containing whitespace are rejected with an error, but all others values appear without modification on the java command line appended to `-XX:MaxMetaspaceSize=`.
| `java.permgen.size` | The Java maximum PermGen size to use. This is applicable to versions of OpenJDK earlier than 1.8. For example, a value of `128m` will result in the java command line option `-XX:MaxPermSize=128m`. Values containing whitespace are rejected with an error, but all others values appear without modification on the java command line appended to `-XX:MaxPermSize=`.
| `java.stack.size` | The Java stack size to use. For example, a value of `256k` will result in the java command line option `-Xss256k`. Values containing whitespace are rejected with an error, but all others values appear without modification on the java command line appended to `-Xss`.

#### Default Memory Sizes

If some memory sizes are not specified using the above properties, default values are provided. For maximum heap, Metaspace, or PermGen size, the default value is based on a proportion of the total memory specified when the application was pushed. For stack size, the default value is one megabyte.

If any memory sizes are specified which are not equal to the default value, the proportionate defaults are adjusted accordingly. The default stack size is never adjusted from the default value.

#### OpenJDK Memory Heuristics

The calculation of default memory sizes for OpenJDK is configured via YAML files in the buildpack's `config` directory.

The configuration contains a weighting between `0` and `1` corresponding to a proportion of the total memory specified when the application was pushed. The weightings should add up to `1`.
