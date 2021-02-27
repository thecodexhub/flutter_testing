# Flutter Testing demo

This project shows how to implement tests in Flutter 
<!-- , using various test methods (unit tests, widget tests, integration tests). -->

## Project goals

This project shows how to:

- implement the various test methods
- use most convinient techniques to write tests
- write production-ready code following best practices

## Preview

**Unit Test**

<div style="text-align: center"><table><tr>
<td style="text-align: center">
<img src="screenshots/ss_one.png" width="200" />
</td>
<td style="text-align: center">
<img src="screenshots/ss_two.png" width="200"/>
</td>
</tr></table>
</div>

## Test features

### Supported test methods

- [x] Unit test (see [documentation](docs/unit-testing.md))
- [x] Widget test (see [documentation](docs/widget-testing.md))
- [ ] Integration test

## Application features

### Make payment page

- [x] Regex validation
- [x] Custom `TextInputFormatter` for `TextField`

## TODO

- [ ] Internationalization
- [ ] Improve documentations

## Project structure

Current project structure:

```
/lib
  /home_page
  /string_validator
  /validation_textfield
/test
  /amount_validator_test
```

This is an arbitrary structure. Choose what works best for **your** project.

## Run the tests

Go to your project terminal and run this command to run all the tests in the project

```console
foo@bar:~$ flutter test
```