FROM craftship/lein:2.6.1

MAINTAINER Craftship Ltd "hello@craftship.io"

ENV DATOMIC_VERSION 0.9.5385
ENV DATOMIC_HOME /opt/datomic-pro-$DATOMIC_VERSION

ONBUILD ADD .credentials /tmp/.credentials

ONBUILD RUN curl -u $(cat /tmp/.credentials) -SL https://my.datomic.com/repo/com/datomic/datomic-pro/$DATOMIC_VERSION/datomic-pro-$DATOMIC_VERSION.zip -o /tmp/datomic.zip \
  && unzip /tmp/datomic.zip -d /opt \
  && rm -f /tmp/datomic.zip

ONBUILD ADD config $DATOMIC_HOME/config

WORKDIR $DATOMIC_HOME

ENTRYPOINT ["bin/transactor"]

EXPOSE 4334 4335 4336
