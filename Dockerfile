FROM archlinux:base-devel

RUN pacman -Syu --noconfirm \
    gnupg \
    git \
    wget \
    curl \
    unzip \
    python \
    python-pip \
    nodejs \
    npm \
    yarn \
    rustup \
    go

COPY makepkg.conf /etc/makepkg.conf
COPY pacman.conf /pacman.conf
RUN useradd -d /build -s /bin/bash -m builduser
RUN echo "builduser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN passwd -d builduser
RUN gpg --recv-keys C0E032ACED9D1A30
RUN sudo -u builduser bash -c "gpg --recv-keys C0E032ACED9D1A30"
RUN rustup default stable
RUN sudo -u builduser bash -c "rustup default stable"
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]