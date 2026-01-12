#
# To test changes locally:
#
# 1. docker build -t ubuntu-dev .
# 2. docker run -it --rm ubuntu-dev:latest
#

# NOTE: Tag "rolling" is actually the latest version. Tag "latest" points to the latest "LTS" version.
ARG BASE_IMAGE=ubuntu:rolling
FROM ${BASE_IMAGE}

# Set environment variable to skip interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Disable installing recommended and suggested packages via apt/apt-get.
COPY --from=shared --chown=root:root --chmod=644 /apt/99-no-recommends /etc/apt/apt.conf.d/

# NOTE: We keep the update list so that users can more easily install new software.
RUN apt-get update

# Install tools
RUN apt-get update && \
    apt-get install -y \
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
        git \
        command-not-found \
        # For non-root users
        sudo \
        && \
    # Re-run for "command-not-found"
    apt-get update

# NOTE: These args must be after(!) the FROM directive (or else they won't be available below).
# IMPORTANT: These must be as late as possible because "docker buildx bake" can't share layers
#   where these values are different. So they should explicitly be after(!) the "apt-get" stuff above.
ARG USE_NON_ROOT=false
ARG USER_NAME=root
ARG HOME_DIR=/root

RUN if [ "$USE_NON_ROOT" = "true" ]; then \
        useradd -m -s /bin/zsh "$USER_NAME" && \
        usermod -aG sudo "$USER_NAME" && \
        echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers; \
    fi

# Switch to non-root user, if non-root user is used.
USER ${USER_NAME}
WORKDIR ${HOME_DIR}

# Set nano as default editor.
ENV EDITOR=nano

# Install oh-my-zsh for the user
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended

# Add customization for zsh
COPY --from=shared --chown=$USER_NAME:$USER_NAME --chmod=600 /oh-my-zsh/.zshrc $HOME_DIR/.zshrc

# Run zsh as default shell
CMD ["zsh"]
