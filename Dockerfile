FROM alpine:3.17 AS verify
RUN apk add --no-cache curl tar xz

RUN ROOTFS=$(curl -sfOJL -w "amzn2-container-raw-2.0.20240503.0-arm64.tar.xz" "https://amazon-linux-docker-sources.s3.amazonaws.com/amzn2/2.0.20240503.0/amzn2-container-raw-2.0.20240503.0-arm64.tar.xz") \
  && echo 'd3224eeadbc5a55ad0e3669eaeff96008e2dd4bb4e638ef496c489b5d4e7feb7  amzn2-container-raw-2.0.20240503.0-arm64.tar.xz' >> /tmp/amzn2-container-raw-2.0.20240503.0-arm64.tar.xz.sha256 \
  && cat /tmp/amzn2-container-raw-2.0.20240503.0-arm64.tar.xz.sha256 \
  && sha256sum -c /tmp/amzn2-container-raw-2.0.20240503.0-arm64.tar.xz.sha256 \
  && mkdir /rootfs \
  && tar -C /rootfs --extract --file "${ROOTFS}"

FROM scratch AS root
COPY --from=verify /rootfs/ /

CMD ["/bin/bash"]
