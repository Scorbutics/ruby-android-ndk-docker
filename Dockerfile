FROM alpine:latest

ENV ANDROID_NDK_HOME /opt/android-ndk
ENV ANDROID_NDK_VERSION r25b

# get the Android NDK
RUN mkdir /tmp/android-ndk && \
    cd /tmp/android-ndk && \
    wget https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux.zip && \
    unzip -q android-ndk-${ANDROID_NDK_VERSION}-linux.zip && \
    mv ./android-ndk-${ANDROID_NDK_VERSION} ${ANDROID_NDK_HOME} && \
    cd /tmp && rm -rf /tmp/android-ndk

RUN apk update && \
    apk upgrade && \
    apk add \
    git \
    make \
    'cmake>3.19.2' \
    'ruby-dev>3.1' \
    ninja \
    libtool \
# some executable in the ndk are prebuilt with glibc therefore require gcompat
    gcompat \
    bash \
    gcc \
    musl-dev \
    autoconf \
# ncurses on host is required for cross-compiling ncurses (tic executable must be on the host when cross-compiling)
    ncurses \
    zip

# add NDK to PATH
ENV PATH $PATH:$ANDROID_NDK_HOME
ENV ANDROID_NDK $ANDROID_NDK_HOME

# COPY ./entrypoint.sh /make.sh
# RUN chmod +x /make.sh
# ENTRYPOINT [ "/make.sh" ]

WORKDIR /opt/current
