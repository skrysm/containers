#
# To test changes locally:
#
# 1. docker build -t ubuntu-dev .
# 2. docker run -it --rm ubuntu-dev:latest
#

# NOTE: Tag "rolling" is actually the latest version. Tag "latest" points to the latest "LTS" version.
FROM ubuntu:rolling

# Set environment variable to skip interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Disable installing recommended and suggested packages via apt/apt-get.
COPY --chown=root:root ./files/apt/99-no-recommends /etc/apt/apt.conf.d/

# NOTE: We keep the update list so that users can more easily install new software.
RUN apt-get update

# Install tools
RUN apt-get install -y \
        # Required for proper HTTPS
        ca-certificates \
        curl \
        wget \
        iputils-ping \
        nano \
        zsh \
        less \
        man-db \
        # For oh-my-zsh and general dev purposes
        git

# Set nano as default editor.
ENV EDITOR=nano

# Install oh-my-zsh for the user
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended

# Add customization for zsh
COPY --chown=root:root ./files/oh-my-zsh/customizations.zsh /root/.oh-my-zsh/custom/

# Run zsh as default shell
CMD ["zsh"]
