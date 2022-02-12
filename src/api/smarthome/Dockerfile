## JAVA BUILD ##
FROM maven:3.6.3-openjdk-11-slim as maven-builder

WORKDIR /root/smarthome
COPY /src/api/smarthome .

RUN mvn -q clean package

## WILDFLY ##
FROM alpine:3 as wildfly

LABEL maintainer="Jan Bellenberg"
LABEL version="1.0.0"
WORKDIR /root/smarthome

ENV WILDFLY_VERSION=24.0.0
ENV ZONE=Europe/Berlin

# install packages
RUN apk update && apk add --no-cache curl openjdk11-jre

# download and setup wildfly
RUN curl https://download.jboss.org/wildfly/$WILDFLY_VERSION.Final/wildfly-$WILDFLY_VERSION.Final.zip --output ./wildfly.zip && \
  unzip wildfly.zip && \
  mv ./wildfly-$WILDFLY_VERSION.Final/ ./wildfly/ && \ 
  ./wildfly/bin/add-user.sh -u 'admin' -p 'gXg33Ep4urGp6bF2' && \
  rm wildfly.zip

# set time zone
RUN apk add --no-cache tzdata && \
  cp /usr/share/zoneinfo/$ZONE /etc/localtime && \
  echo $ZONE > /etc/timezone && \
  apk del tzdata

# copy configuration files
COPY ./config/wildfly/mysql ./wildfly/modules/system/layers/base/com/mysql/main
COPY --from=maven-builder /root/smarthome/target/SmartHome.war ./wildfly/standalone/deployments/SmartHome.war

CMD ["./wildfly/bin/standalone.sh"]