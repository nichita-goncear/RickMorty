fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios build_dev

```sh
[bundle exec] fastlane ios build_dev
```

Initiate build process(development).. 🛠️

### ios upload_to_firebase

```sh
[bundle exec] fastlane ios upload_to_firebase
```

Distribute to Firebase. 🚚

- group: Testing group ID e.g. 'internal', 'external', 'dev', etc.

### ios bump_build_number

```sh
[bundle exec] fastlane ios bump_build_number
```

Bump build number.. 🆙

Increase and commit new build number.

### ios run_unit_tests

```sh
[bundle exec] fastlane ios run_unit_tests
```

Running unit tests.. 🧪🔬

### ios update_keychain

```sh
[bundle exec] fastlane ios update_keychain
```

Keychain update initiated.. 🔑🗄️

Deleting previous keychain and creating a new one..

### ios sign_ad_hoc

```sh
[bundle exec] fastlane ios sign_ad_hoc
```

Signing process initiated.. 🔐

Fetching certificates and provisioning profiles..

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
