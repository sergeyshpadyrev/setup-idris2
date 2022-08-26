FROM ubuntu as base

ARG VERSION=v0.3.0

WORKDIR /src
RUN apt-get update && apt-get -y install build-essential git clang chezscheme
RUN git clone https://github.com/idris-lang/Idris2.git
WORKDIR /src/Idris2
RUN git checkout ${VERSION}
ENV SCHEME=scheme
RUN export PATH="${PATH}:/root/.idris2/bin" && make bootstrap && make install

FROM ubuntu
COPY --from=base /root/.idris2 /root/.idris2
ENV SCHEME=scheme
RUN apt-get update && apt-get -y install chezscheme
RUN echo 'export PATH="/root/.idris2/bin/:${PATH}"' >> "${HOME}/.bashrc" && echo 'alias idris=idris2' >> "${HOME}/.bashrc"
