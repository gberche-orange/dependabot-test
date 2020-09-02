# dependabot-test
test repo for experimenting with dependabot usage and workaround patterns

See related issue at https://github.com/dependabot/dependabot-core/issues/2483#issuecomment-683635632 

## go mod

A module version is defined in https://golang.org/cmd/go/#hdr-Pseudo_versions as

> A module version like v1.2.3 is introduced by tagging a revision in the underlying source repository. Untagged revisions can be referred to using a "pseudo-version" like v0.0.0-yyyymmddhhmmss-abcdefabcdef, where the time is the commit time in UTC and the final suffix is the prefix of the commit hash. The time portion ensures that two pseudo-versions can be compared to determine which happened later, the commit hash identifes the underlying commit, and the prefix (v0.0.0- in this example) is derived from the most recent tagged version in the commit graph before this commit. 