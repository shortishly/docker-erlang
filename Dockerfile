FROM centos
MAINTAINER Peter Morgan <peter.james.morgan@gmail.com>

ENV ERLANG_VERSION 17.5
ENV ERLANG_LOCATION /opt/erlang/$ERLANG_VERSION

RUN yum -y update && yum -y install \
    gcc \
    make \
    openssl-devel \
    ncurses-devel \
    perl \
    tar \
    wget

WORKDIR /root

RUN wget https://raw.githubusercontent.com/spawngrid/kerl/master/kerl
RUN chmod +x ./kerl
RUN ./kerl update releases

RUN ./kerl build $ERLANG_VERSION $ERLANG_VERSION
RUN ./kerl install $ERLANG_VERSION $ERLANG_LOCATION
RUN ./kerl cleanup all
RUN rm -f .kerl/archives/*.tar.gz

ENV PATH $ERLANG_LOCATION/bin:$PATH

RUN yum -y erase \
    gcc \
    openssl-devel \
    ncurses-devel \
    perl \
    tar \
    wget

RUN yum clean all
