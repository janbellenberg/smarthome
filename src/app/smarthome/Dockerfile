# FLUTTER BUILD
FROM openjdk:8 as flutter-builder
# load flutter project
WORKDIR /root/smarthome

#load flutter sdk
ARG FLUTTER_SDK_CHANNEL="stable"
ARG FLUTTER_SDK_VERSION="2.2.3"
ENV FLUTTER_SDK_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_SDK_VERSION}-${FLUTTER_SDK_CHANNEL}.tar.xz"

RUN wget -q -O "flutter.tar.xz" "${FLUTTER_SDK_URL}" \
  && tar --extract --file="flutter.tar.xz" --directory="/root" \
  && rm flutter.tar.xz

# load flutter project
COPY . .

# run build
RUN ./../flutter/bin/flutter build web --csp --web-renderer html

# NGINX 
FROM nginx:1.21.1-alpine as nginx

COPY --from=flutter-builder /root/smarthome/build/web /var/www/html
EXPOSE 80
