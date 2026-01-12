#
# Build with: docker buildx bake
#
# See: https://docs.docker.com/build/bake/introduction/
# Reference: https://docs.docker.com/build/bake/reference/
#
group "default" {
    # NOTE: Unfortunately, the "targets" element doesn't support wildcards. So all targets
    #   must be listed explicitly.
    targets = [
        "ubuntu-dev",
        "ubuntu-dev-lts",
        "ubuntu-dev-non-root",
        "ubuntu-dev-lts-non-root"
    ]
}

target "common" {
    # Pull "shared" via named context.
    contexts = {
        shared = "./shared"
    }

    # Defaults for amd64 for local builds. Will be overridden with other platforms in the GitHub Action workflow.
    platforms = ["linux/amd64"]
}

target "ubuntu-common" {
    inherits  = ["common"]  # inherit common settings

    # Make context explicit (uses the current working directory, if not specified). This way
    # we can control the number of files copied to Docker for building the image; i.e. we explicitly
    # don't use "context = '.'" (which contain a lot of files).
    #
    # NOTE: This also defines the location of the Dockerfile.
    context    = "images/ubuntu-dev"
}

target "ubuntu-dev" {
    inherits  = ["ubuntu-common"]  # inherit common settings

    # NOTE: We only use "latest" as tag as users will always want to use the latest (and thus only) image.
    #   There should be no point in using an older image. Also, this way we don't need to cleanup old images.
    tags       = ["skrysm/ubuntu-dev:latest"]
}

target "ubuntu-dev-lts" {
    inherits  = ["ubuntu-common"]  # inherit common settings

    args = {
        BASE_IMAGE = "ubuntu:latest"
    }
    tags = ["skrysm/ubuntu-dev:lts"]
}

target "ubuntu-dev-non-root" {
    inherits  = ["ubuntu-common"]  # inherit common settings

    args = {
        USE_NON_ROOT = "true"
        USER_NAME    = "dev"
        HOME_DIR     = "/home/dev"
    }
    tags = ["skrysm/ubuntu-dev:non-root"]
}

target "ubuntu-dev-lts-non-root" {
    inherits  = ["ubuntu-common"]  # inherit common settings

    args = {
        BASE_IMAGE   = "ubuntu:latest"
        USE_NON_ROOT = "true"
        USER_NAME    = "dev"
        HOME_DIR     = "/home/dev"
    }
    tags = ["skrysm/ubuntu-dev:lts-non-root"]
}
