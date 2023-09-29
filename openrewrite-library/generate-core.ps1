# Conditionally clean up existing directory, if it exists
if (Test-Path ..\my-rewritten-project\) {
    Write-Host "Deleting existing rewritten directory"
    Remove-Item ..\my-rewritten-project\ -Recurse -Force
}

# Copy everything from the repro directory as the starting point for our rewriting
Write-Host "Copying original directory to rewritten directory"
Copy-Item -Path "..\my-original-project\" -Destination "..\my-rewritten-project\" -Recurse

# Run Maven to build this library (used by OpenRewrite in the next step)
Write-Host "Building the 'openrewrite' package"
mvn -f pom.xml clean install

# Run Maven with a project list consisting of just the modules we care about
Write-Host "Running OpenRewrite on sub-projects"
mvn -f ..\my-rewritten-project\pom.xml -Popenrewrite rewrite:run

# Delete the empty directories, which are left-over from the com.azure -> com.typespec.core.gen rewrite
Write-Host "Deleting empty directories"
Get-ChildItem -Path "..\my-rewritten-project\" -Force -Recurse -Directory |
    Where-Object { (Get-ChildItem -Path $_.FullName -Recurse -File -EA SilentlyContinue |
        Measure-Object).Count -eq 0 } | Remove-Item -Force -Recurse

# Run the Maven build on the new libraries
mvn -f ..\my-rewritten-project\pom.xml install
