# qml-hydra

QML bindings for creating UI applications using the "hydra" C library.

## Setting up a Build Environment

The following is intended to be a complete guide to setting up a build environment that can build for Android (as well as your desktop, although that part is considerably easier).  To that end, if you encounter parts where steps are missing or unclear, please file an issue or pull request about it so that others might learn from your research.

Eventually, we'd like to remove some of these steps where possible to make this process simpler.  If you have ideas about removing or simplifying steps, please file an issue or pull request so that others might be saved some complexity.

### C Library Dependencies

If you are building for Android, you can skip this step, as the necessary dependencies are automatically pulled down and built by the `vendor/build` scripts.  If you are developing and testing on your desktop, you will need a local installation of the [hydra library](https://github.com/edgenet/hydra) to link against and include.

### Ruby

You will need an installation of [Ruby 1.9 or greater](https://www.ruby-lang.org/en/downloads/) to run some of the build scripts.  In the future, this requirement may be eliminated and replaced by "pure" shell scripts with no Ruby dependency.

On Linux, you can get Ruby from your package manager.  On OSX, use [brew](http://brew.sh/).  If you are already a Ruby developer and have an existing system to manage your Rubies, use what you are comfortable with.

Once Ruby is installed, you will need the [qt-commander](https://github.com/jemc/qt-commander) gem, a utility package for parsing the Qt Creator IDE configuration files to pull out key information for building projects and project dependencies from the command line without the IDE.  You will also need the [rake](https://github.com/jimweirich/rake) gem, a task automation package with usage similiar to the `make` command.  You can install both using the `gem` command:
```
gem install rake
gem install qt-commander
```

### Qt 5

You will need [Qt 5](http://www.qt.io/download-open-source/) and a fully-functioning environment for Qt that can build and deploy to Android.

Qt features [a guide for Android](http://qt-project.org/doc/qt-5/android-support.html) that you can refer to for tips on getting started.

At the end of this step, you should be able to use the Qt Creator IDE to build and deploy an out-of-the-box simple 'Hello World' app for QML.

To ready your device for deployment:

* Be sure your Android device has [developer options enabled](http://developer.android.com/tools/device.html#developer-device-options).
* Run the adb server with a privileged user (`sudo adb start-server`).  If you previously tried to run adb with an unprivileged user, you'll need to stop the old adb server first (`sudo adb kill-server`).  You will need the `adb` binary from the Android development kit in your `$PATH`.
* Connect your device via USB and set it to "USB Debugging Mode".
* Run `adb devices` to make sure your device is detected and ready.

To create the temporary project:

* Click `File`->`New File or Project...`
* Choose `Applications`/`Qt Quick Application`
* Enter a name and location for the temporary project
* Choose the latest "Qt Quick Component Set"
* Select the relevant kits you want to be able to deploy with (this should include the Android kit(s) that you set up earlier)
* Choose a version control system to use (if you like)
* Finish the creation wizard

Once you have a project to deploy:

* In the lower-left corner of the IDE (above the build icons), select from the drop-down menu the Android kit that matches the architectureof your connected device.
* Click the "Run" button (just below the kit menu) to deploy.
* Watch the bottom output pane of the IDE; it will show output from the build and packaging process, transfer the file, then show in a different tab output from the program execution as it runs on your device.

## Build tasks

### Install Locally and Run Tests
```
rake test
```

Use this command when developing and testing the library.  A copy of the library is installed locally where Qt can find it for running desktop applications that use the library.

### Build Vendor Dependencies for Android
```
rake vendor
```

Use this command as a precursor to installing locally for Android.

### Install Locally for Android
```
rake android
```

Use this command to install a copy of the library locally where Qt can find it later for bundling into an application you are deploying to Android.

## Contributing

The contribution policy is the standard ZeroMQ [C4.1 process](http://rfc.zeromq.org/spec:22). Please read this RFC if you have never contributed to a ZeroMQ project.
