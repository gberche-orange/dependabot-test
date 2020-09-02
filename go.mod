module github.com/orange-cloudfoundry/dependabot-test

go 1.14

require (
		//we got a PR for this older version
	github.com/cloudfoundry-incubator/bosh-backup-and-restore v1.7.0
	    //we expect a pr for 1.2.0
	github.com/thomasmitchell/bosh-complete v1.1.0

	//surprisingly fails with:
	//go: errors parsing go.mod:
    ///go.mod:8: require github.com/cloudfoundry/bosh-cli: version "v6.2.1" invalid: should be v0 or v1, not v6
	//github.com/cloudfoundry/bosh-cli v6.2.1

	//this is the commit for release 1.5
	// see https://github.com/stedolan/jq/commit/a5b5cbefb83935ce95ec62b9cadc8ec73026d33a
	github.com/stedolan/jq v0.0.0-20150818062500-a5b5cbefb83935ce95ec62b9cadc8ec73026d33a
	// failed attempt with jq which does not use semver tags and does not start with v
	//github.com/stedolan/jq jq-1.6
	//fails with:
	//Dependabot couldn't parse the go.mod found at /go.mod.
	//
	//The error Dependabot encountered was:
	//
	//go: errors parsing go.mod:
	///go.mod:7: require github.com/cloudfoundry/bosh-cli: version "v6.2.1" invalid: should be v0 or v1, not v6
	///go.mod:10: require github.com/stedolan/jq: version "jq-1.6" invalid: must be of the form v1.2.3


)