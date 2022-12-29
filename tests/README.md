# Infrastructure as Code Tests 🧪

This directory contains a number of automated tests that cover the functionality
of the modules that ship with this repository.

## Introduction
We are using [Terratest] for automated tests that are located in the
`tests/` **directory**. Terratest deploys _real_ infrastructure
(e.g., servers) in a _real_ environment (e.g., AWS).

The basic usage pattern for writing automated tests with Terratest is to:

1. Write tests using Go's built-in [package testing]: you create a file ending
   in `_test.go` and run tests with the `go test` command.
2. Use Terratest to execute your _real_ IaC tools (e.g., Terraform, Packer, etc.)
   to deploy _real_ infrastructure (e.g., servers) in a _real_ environment (e.g., AWS).
3. Validate that the infrastructure works correctly in that environment by
   making HTTP requests, API calls, SSH connections, etc.
4. Undeploy everything at the end of the test.

>**Note #1**: Many of these tests create real resources in an AWS account.
That means they cost money to run, especially if you don't clean up after
yourself. Please be considerate of the resources you create and take extra care
to clean everything up when you're done!

>**Note #2**: Never hit `CTRL + C` or cancel a build once tests are running or
the cleanup tasks won't run!

## How to run the tests
The **tests** structure is described as follows:

```text
tests/
├── README.md
├── TaskFile.yml
├── integration
│   ├── basic
│   │   ├── go.mod
│   │   ├── go.sum
│   │   └── integration_sample_test.go
│   └── target
│       └── basic
│           └── main.tf
└── unit
    ├── basic
    │   ├── account_creator_simple_test.go
    │   ├── go.mod
    │   └── go.sum
    └── target
        └── basic
            └── main.tf
```

This repository comes with a [Taskfile]  that helps you to run the
tests in a convenient way.

<!-- References -->

<!-- markdown-link-check-disable -->
[terratest]: https://github.com/gruntwork-io/terratest
[package testing]: https://golang.org/pkg/testing/
[Taskfile]: https://taskfile.dev/#/

<!-- markdown-link-check-enable -->
