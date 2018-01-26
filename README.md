<p align="center">
    <a href="https://sentry.io" target="_blank" align="center">
        <img src="https://camo.githubusercontent.com/bf0171b40f72483bc67dd4352db1d37c90a541c1/687474703a2f2f7777772e6c697a6172642e77732f776562736974652f7374617469632f696d672f6c6f676f2d736d616c6c2e706e67">
    </a>
<br/>
    <h1>Lizard Fastlane Plugin</h1>
</p>

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-lizard)
[![Gem Version](https://badge.fury.io/rb/fastlane-plugin-lizard.svg)](https://badge.fury.io/rb/fastlane-plugin-lizard)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-lizard`, add it to your project by running:

```bash
fastlane add_plugin lizard
```

## About lizard

Lizard is an extensible Cyclomatic Complexity Analyzer for many imperative programming languages including C/C++ (doesn't require all the header files or Java imports).

For more information check out the [Github repository](https://github.com/terryyin/lizard)

## Lizard Actions

Lizard has only one action so far

```
lizard(
  source_folder: "foo",
  language: "swift",
  export_type: "csv",
  report_file: "bar.csv"
)
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
