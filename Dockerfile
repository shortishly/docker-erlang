FROM centos
MAINTAINER Peter Morgan <peter.james.morgan@gmail.com>

ENV ERLANG_VERSION 17.4

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
RUN ./kerl install $ERLANG_VERSION /opt/erlang/$ERLANG_VERSION
RUN ./kerl cleanup all
RUN rm -f .kerl/archives/*.tar.gz

ENV PATH /opt/erlang/$ERLANG_VERSION/bin:$PATH

RUN yum -y erase \
    gcc \
    openssl-devel \
    ncurses-devel \
    perl \
    tar \
    wget

RUN yum clean all
