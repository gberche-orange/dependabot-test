module github.com/orange-cloudfoundry/dependabot-test

go 1.14

require (
	github.com/cloudfoundry-incubator/bosh-backup-and-restore v1.7.0
	github.com/cloudfoundry/bosh-cli v6.2.1
	github.com/thomasmitchell/bosh-complete v1.1.0
	// attempting with jq which does not use semver tags and does not start with v
	github.com/stedolan/jq jq-1.6
)