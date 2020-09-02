# dependabot-test
test repo for experimenting with dependabot usage and workaround patterns

See related issue at https://github.com/dependabot/dependabot-core/issues/2483#issuecomment-683635632 

The goal is to be able to bump versions inferred from github releases for software not yet managed by a supported dependabot ecosystem

## Source files format to bump

### Docker file

```
FROM ubuntu:18.04
USER root
ARG DEBIAN_FRONTEND=noninteractive


#--- Cli versions
ENV BBR_VERSION="1.7.2" \
    BOSH_CLI_VERSION="6.2.1" \
    BOSH_CLI_COMPLETION_VERSION="1.2.0" \
    BOSH_GEN_VERSION="0.101.1" \
    CF_CLI_VERSION="6.51.0" \
    CF_CLI7_VERSION="7.0.0-beta.30" \
[...]

RUN printf '\n=====================================================\n Install ops tools\n=====================================================\n' && \
    printf '\n=> Add BBR-CLI\n' && curl -sSL "https://github.com/cloudfoundry-incubator/bosh-backup-and-restore/releases/download/v${BBR_VERSION}/bbr-${BBR_VERSION}.tar" | tar -x -C /tmp && mv /tmp/releases/bbr /usr/local/bin/bbr && \
    printf '\n=> Add BOSH-CLI\n' && curl -sSLo /usr/local/bin/bosh "https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSH_CLI_VERSION}-linux-amd64" && \
    printf '\n=> Add BOSH-CLI completion\n' && curl -sSLo /home/bosh/bosh-complete-linux "https://github.com/thomasmmitchell/bosh-complete/releases/download/v${BOSH_CLI_COMPLETION_VERSION}/bosh-complete-linux" && chmod 755 /home/bosh/bosh-complete-linux && \
    printf '\n=> Add CF-CLI\n' && curl -sSL "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_CLI_VERSION}&source=github" | tar -xz -C /tmp && mv /tmp/cf /usr/local/bin/cf && \
    printf '\n=> Add CF-CLI completion\n' && curl -sSLo /usr/share/bash-completion/completions/cf "https://raw.githubusercontent.com/cloudfoundry/cli/master/ci/installers/completion/cf"  && \
    printf '\n=> Add CF7-CLI\n' && curl -sSL "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_CLI7_VERSION}&source=github" | tar -xz -C /tmp && mv /tmp/cf7 /usr/local/bin/cf7 && \
    printf '\n=> Add CF7-CLI completion\n' && curl -sSLo /usr/share/bash-completion/completions/cf7 "https://raw.githubusercontent.com/cloudfoundry/cli/master/ci/installers/completion/cf7"  && \
    printf '\n=> Add CREDHUB-CLI\n' && curl -sSL "https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/${CREDHUB_VERSION}/credhub-linux-${CREDHUB_VERSION}.tgz" | tar -xz -C /usr/local/bin && \
    printf '\n=> Add FLY-CLI\n' && curl -sSL "https://github.com/concourse/concourse/releases/download/v${FLY_VERSION}/fly-${FLY_VERSION}-linux-amd64.tgz" | tar -xz -C /usr/local/bin && \
[...] 
```  

### Bosh releases

Bosh releases numbers are usually used in github repos as github tags but don't use the "v" prefix that gomod requires
 
https://bosh.io/releases/github.com/cloudfoundry/routing-release?all=1

## Reference documentation for ecosystems

### go mod

A module version is defined in https://golang.org/cmd/go/#hdr-Pseudo_versions as

> A module version like v1.2.3 is introduced by tagging a revision in the underlying source repository. Untagged revisions can be referred to using a "pseudo-version" like v0.0.0-yyyymmddhhmmss-abcdefabcdef, where the time is the commit time in UTC and the final suffix is the prefix of the commit hash. The time portion ensures that two pseudo-versions can be compared to determine which happened later, the commit hash identifes the underlying commit, and the prefix (v0.0.0- in this example) is derived from the most recent tagged version in the commit graph before this commit. 