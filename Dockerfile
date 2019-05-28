FROM ubuntu:18.04 as build

RUN apt-get update && apt-get -y install \
  libcurl4-openssl-dev \
  gcc \
  xdg-utils \
  make \
  curl \
  git \
  xz-utils \
  libsqlite3-dev \
  wget coreutils gnupg pkg-config
  
RUN curl https://dlang.org/install.sh | bash -s

#RUN git clone https://github.com/abraunegg/onedrive/releases/tag/v2.3.3
RUN git clone https://github.com/abraunegg/onedrive.git

RUN /bin/bash -c "source ~/dlang/dmd-*/activate && cd onedrive && ./configure && make && make install"

FROM ubuntu:18.04

RUN apt-get update && apt-get -y install \
  libcurl4-openssl-dev \
  libsqlite3-dev

COPY --from=build /usr/local/bin/onedrive /usr/local/bin/onedrive

RUN mkdir /root/.config

COPY ./onedrive.conf /root/.config/onedrive/config
ADD ./start.sh /root/

RUN apt-get clean

CMD /root/start.sh