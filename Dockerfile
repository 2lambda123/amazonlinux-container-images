FROM alpine:3.17 AS verify
RUN apk add --no-cache curl tar xz

RUN ROOTFS=$(curl -sfOJL -w "amzn2-container-raw-2.0.20240503.0-x86_64.tar.xz" "https://amazon-linux-docker-sources.s3.amazonaws.com/amzn2/2.0.20240503.0/amzn2-container-raw-2.0.20240503.0-x86_64.tar.xz") \
  && echo '4d2d93673cbef1694507761e4dc9c843359373eaf73e88f8048a1c26d28ed0ad  amzn2-container-raw-2.0.20240503.0-x86_64.tar.xz' >> /tmp/amzn2-container-raw-2.0.20240503.0-x86_64.tar.xz.sha256 \
  && cat /tmp/amzn2-container-raw-2.0.20240503.0-x86_64.tar.xz.sha256 \
  && sha256sum -c /tmp/amzn2-container-raw-2.0.20240503.0-x86_64.tar.xz.sha256 \
  && mkdir /rootfs \
  && tar -C /rootfs --extract --file "${ROOTFS}"

FROM scratch AS root
COPY --from=verify /rootfs/ /

CMD ["/bin/bash"]
