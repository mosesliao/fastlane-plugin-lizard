# fastlane-plugin-lizard

[![fastlane Plugin Badge][1]][2]
[![Gem Version][3]][4]
[![CircleCI][5]][6]
[![codecov][7]][8]

## Getting Started

This project is a [_fastlane_][9] plugin. To get started with
`fastlane-plugin-lizard`, add it to your project by running:

```bash
fastlane add_plugin lizard
```

## About Lizard

Lizard is an extensible Cyclomatic Complexity Analyzer for many imperative programming
languages including C/C++ (doesn't require all the header files or Java imports).

For more information check out the [GitHub repository][10]

![Lizard][11]

## Lizard Actions

Lizard has only one action so far

```ruby
lizard(
  source_folder: 'foo',
  language: 'swift',
  export_type: 'csv',
  report_file: 'bar.csv'
)
```

### Options

#### Multiple languages

```ruby
language: 'swift,objectivec'
```

#### XML reports

```ruby
export_type: 'xml'
```

## Sonar Swift Usage

In the default configuration, the [Backelite sonar-swift plugin][15] for SonarQube
expects an xml report located at `sonar-reports/lizard-report.xml`:

```ruby
lizard(source_folder: 'foo', export_type: 'xml', report_file: 'sonar-reports/lizard-report.xml')
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting][12]
guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the
[Plugins documentation][13].

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your
iOS and Android apps. To learn more, check out [fastlane.tools][14].

[1]: https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg
[2]: https://rubygems.org/gems/fastlane-plugin-lizard
[3]: https://badge.fury.io/rb/fastlane-plugin-lizard.svg
[4]: https://badge.fury.io/rb/fastlane-plugin-lizard
[5]: https://circleci.com/gh/liaogz82/fastlane-plugin-lizard.svg?style=svg&circle-token=6d2bc552098ad6c8955ddecc9b058827e91e25cf
[6]: https://circleci.com/gh/liaogz82/fastlane-plugin-lizard
[7]: https://codecov.io/gh/liaogz82/fastlane-plugin-lizard/branch/master/graph/badge.svg
[8]: https://codecov.io/gh/liaogz82/fastlane-plugin-lizard
[9]: https://github.com/fastlane/fastlane
[10]: https://github.com/terryyin/lizard
[11]: https://camo.githubusercontent.com/bf0171b40f72483bc67dd4352db1d37c90a541c1/687474703a2f2f7777772e6c697a6172642e77732f776562736974652f7374617469632f696d672f6c6f676f2d736d616c6c2e706e67
[12]: https://docs.fastlane.tools/plugins/plugins-troubleshooting/
[13]: https://docs.fastlane.tools/plugins/create-plugin/
[14]: https://fastlane.tools
[15]: https://github.com/Backelite/sonar-swift
