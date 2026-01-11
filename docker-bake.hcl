#
# Build with: docker buildx bake
#
group "default" {
    targets = ["ubuntu-dev"]
}

target "ubuntu-dev" {
    context    = "."
    dockerfile = "images/ubuntu-dev/Dockerfile"
    platforms  = ["linux/amd64", "linux/arm64"]
    # NOTE: We only use "latest" as tag as users will always want to use the latest (and thus only) image.
    #   There should be no point in using an older image. Also, this way we don't need to cleanup old images.
    tags       = ["skrysm/ubuntu-dev:latest"]
}
