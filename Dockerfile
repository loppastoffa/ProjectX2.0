# Use a base image with Ubuntu, which is similar to the CI environment
FROM ubuntu:latest

#Default directory
WORKDIR /ProjectX

RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip git cmake libclang-rt-dev libclang-dev curl clang llvm lcov default-jdk zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN which clang

RUN curl -L https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64 -o /usr/local/bin/bazel && \
    chmod +x /usr/local/bin/bazel

RUN which bazel
RUN bazel --version

RUN curl -OL https://golang.org/dl/go1.21.0.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz && \
    export PATH=$PATH:/usr/local/go/bin && \
    go version

# Add Go to the path (to ensure it’s available in subsequent Docker commands)
ENV PATH="/usr/local/go/bin:${PATH}"

# Install development libraries (libcap-dev) for building libminijail
RUN apt-get update && \
    apt-get install -y libcap-dev build-essential


RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ouspg/ProjectX2/main/install.sh)"

#Provide your repository link below
RUN git clone https://github.com/loppastoffa/ProjectX2.0.git

WORKDIR /ProjectX/ProjectX2.0
RUN ls -a

CMD ["sh", "-c", "cifuzz run test --use-sandbox=false > /ProjectX/ProjectX2.0/fuzzing.log 2>&1 && cat /ProjectX/ProjectX2.0/fuzzing.log"]
