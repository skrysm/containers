#
# Build with: docker buildx bake
#
group "default" {
    targets = ["ubuntu-dev"]
}

target "common" {
    # Base directory (needed to be able to access the "shared" folder).
    context    = "."
    # Defaults for amd64 for local builds. Will be overridden with other platforms in the GitHub Action workflow.
    platforms = ["linux/amd64"]
}

target "ubuntu-dev" {
    inherits  = ["common"]  # inherit common settings

    dockerfile = "images/ubuntu-dev/Dockerfile"
    # NOTE: We only use "latest" as tag as users will always want to use the latest (and thus only) image.
    #   There should be no point in using an older image. Also, this way we don't need to cleanup old images.
    tags       = ["skrysm/ubuntu-dev:latest"]
}
