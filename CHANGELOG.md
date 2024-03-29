# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]



<a name="v1.0.17"></a>
## [v1.0.17] - 2023-06-26

- Update config.yml to disable sumo-logic collector failing


<a name="v1.0.16"></a>
## [v1.0.16] - 2023-06-26

- Fix/issue-18: Add new variable to set datapoints_to_alarm attribute


<a name="v1.0.15"></a>
## [v1.0.15] - 2022-08-23

- Update README.md


<a name="v1.0.14"></a>
## [v1.0.14] - 2021-10-26

- Comment unused imports
- Remove AWS Account ID variable to Terrastest (golang)
- Pass AWS Account ID to Terrastest (golang)
- Fix Dev Account ID for deploying the Terratest resources
- Change Terratest comparison to lists
- Change to string comparision in Terratests
- Fix wrong list definition in Terratests
- Change Terratest comparison to lists
- Fix expected value for Terratest
- Update CirceCI pipeline for Terrattest & TF 0.14.11
- Update Terratest code to TF 0.14.11
- Update Terraform verstion for Terratest
- Update README
- Update module outputs
- * Logic refactor to use a single resource block * Add support to list of SNS Topics


<a name="v1.0.13"></a>
## [v1.0.13] - 2021-10-08

- Create FUNDING.yml


<a name="v1.0.12"></a>
## [v1.0.12] - 2021-05-10

- fixed typo
- update reference to tf repo and output name


<a name="v1.0.11"></a>
## [v1.0.11] - 2021-04-26

- fix: set the correct currency in the alarm description


<a name="v1.0.10"></a>
## [v1.0.10] - 2021-01-20

- BBL-424 | updating examples to use tf 0.12.28 terraform-slim image


<a name="v1.0.9"></a>
## [v1.0.9] - 2020-11-16

- BBL-440 | small circleci config naming improvement


<a name="v1.0.8"></a>
## [v1.0.8] - 2020-11-16

- BBL-440 | adding pending example readme.md pre-commit cleanup
- BBL-440 | ci pre-commit added + slack notif + makefile-lib versioned


<a name="v1.0.7"></a>
## [v1.0.7] - 2020-10-02

- BBL-381 | updating makefile include sintaxt + circleci sumologic integration


<a name="v1.0.6"></a>
## [v1.0.6] - 2020-09-24

- BBL-381 | upgrading circleci VM executor


<a name="v1.0.5"></a>
## [v1.0.5] - 2020-09-18

- Merge branch 'master' of github.com:binbashar/terraform-aws-cost-billing-alarm
- BBL-381 | minor README.md figures udpate


<a name="v1.0.4"></a>
## [v1.0.4] - 2020-09-18

- BBL-381 | small README.md sintaxt improvements
- BBL-381 | standalone makefile approach implemented + README.md updated


<a name="v1.0.3"></a>
## [v1.0.3] - 2020-08-20

- BBL-192 | updating .gitignore + adding .editorconfig + LICENSE.md + Makefile docker ver to latest


<a name="v1.0.2"></a>
## [v1.0.2] - 2020-07-20

- updating changelog to its latest config
- Promoting project name creds related update


<a name="v1.0.1"></a>
## [v1.0.1] - 2020-07-10

- BBL-78 updating to patch for future releases


<a name="v1.0.0"></a>
## [v1.0.0] - 2020-07-10

- BBL-78 fixing expected output in tests
- BBL-84 releasing major version
- BBL-78 tests have been added
- BBL-84 module migrated to tf-0.12
- BBL-78 examples updated to follow tf-0.12 format
- BBL-78 std file structure for tf 0.12 migration
- BBL-84 makefile cross-project sync


<a name="v0.0.3"></a>
## [v0.0.3] - 2019-07-12

- Adding CHANGELOG.md for v0.0.3
- updating figures url by github raw endpoint in order to let README.md images to be publicly accesible by docker-hub and tf-registry among others
- updating public figures url
- fixing example README.md title
- Adding examples README.mds to avoid - Submodules without a README or README.md are considered to be internal-only by the Terraform Module Registry.
- Updating Makefile to support terratests cmds
- .gitignore updated to its std cross-project format
- updating example output string with the correrct 'sns' value
- fixing example code to be executable
- adding CHANGELOG.md with new release semtag v0.0.2


<a name="v0.0.2"></a>
## [v0.0.2] - 2019-07-05

- adding pre-reqs for git-release -> CHANGELOG.md with new semtag v0.0.2
- Adding git-release support in makefile with git-chglog and semtag
- updating tf 0.12 related readme.md with exact release ver
- adding tf 0.12 related readme.md updates


<a name="v0.0.1"></a>
## [v0.0.1] - 2019-06-11

- Set theme jekyll-theme-slate


<a name="0.0.1"></a>
## 0.0.1 - 2019-06-11

- readme.md fixing figures link
- readme.md fixing figures link
- adding .gitignore and .gitallow files + minor readme.md update
- Initial commit


[Unreleased]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.17...HEAD
[v1.0.17]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.16...v1.0.17
[v1.0.16]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.15...v1.0.16
[v1.0.15]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.14...v1.0.15
[v1.0.14]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.13...v1.0.14
[v1.0.13]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.12...v1.0.13
[v1.0.12]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.11...v1.0.12
[v1.0.11]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.10...v1.0.11
[v1.0.10]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.9...v1.0.10
[v1.0.9]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.8...v1.0.9
[v1.0.8]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.7...v1.0.8
[v1.0.7]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.6...v1.0.7
[v1.0.6]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.5...v1.0.6
[v1.0.5]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.4...v1.0.5
[v1.0.4]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.3...v1.0.4
[v1.0.3]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.2...v1.0.3
[v1.0.2]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.1...v1.0.2
[v1.0.1]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v1.0.0...v1.0.1
[v1.0.0]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v0.0.3...v1.0.0
[v0.0.3]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v0.0.2...v0.0.3
[v0.0.2]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/v0.0.1...v0.0.2
[v0.0.1]: https://github.com/binbashar/terraform-aws-cost-billing-alarm/compare/0.0.1...v0.0.1
