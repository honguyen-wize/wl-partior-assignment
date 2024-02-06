# Partior Assignment Project

## Description

This project contains solutions for both the simple and complex assignments using the Karate framework.

## Installation

1. **Download the Submission ZIP File:**
   - Download the submission ZIP file and extract the project.

2. **Run Tests:**

   - Run the simple assignment:

     ```bash
     mvn test -Dtest=AssignmentSimpleRunner
     ```

   - Run the complex assignment:

     ```bash
     mvn test -Dtest=AssignmentComplexRunner
     ```

## Report

After running the tests, view the test report at `target/karate-reports/karate-summary.html`.

## Mock Server URLs

The project uses the following mock server URLs:

- **Simple Assignment:**
  - Base URL: `https://api.dev.runner.wizerace.net/mockApi/simple/`

- **Complex Assignment:**
  - Base URL: `https://api.dev.runner.wizerace.net/mockApi/complex/`
