# OpenRewrite bug code sample

This sample project shows that change package fails for files with a Javadoc comment that includes a method reference with varargs arguments when Maven runs on Java 11+.

## Steps to reproduce
First, ensure yur JAVA_HOME environment variable points to a Java 11 or greater installation. Then:

1. Clone this repository
2. Change directory to the following: `cd openrewrite-varargs-repro/openrewrite-library`
3. From there, run the PowerShell script: `generate-core.ps1`

You'll see that the `Original.java` file gets rewritten as `Rewritten.java` as expected, but the file changed package only in the package declaration in line 1 and not in the folder structure. If you run the same script while changing the Javadoc comment in line 9 to mention `{@link Original#main(String[])}` instead of `{@link Original#varargsMethod(String...)}`, you'll see the folder gets renamed properly and according to the package declaration in line 1.