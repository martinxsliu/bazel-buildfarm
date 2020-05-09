# https://docs.bazel.build/versions/master/install-ubuntu.html

FROM openjdk:8

RUN echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
  && curl https://bazel.build/bazel-release.pub.gpg | apt-key add -

RUN apt-get update \
  && apt-get install -y bazel-3.1.0 \
  && rm -rf /var/lib/apt/lists/*

RUN mv /usr/bin/bazel-3.1.0 /usr/bin/bazel && bazel version

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN git clone https://github.com/bazelbuild/bazel-buildfarm.git
WORKDIR /usr/src/app/bazel-buildfarm

RUN bazel fetch //src/main/java/build/buildfarm:buildfarm-server \
  && bazel fetch //src/main/java/build/buildfarm:buildfarm-operationqueue-worker
