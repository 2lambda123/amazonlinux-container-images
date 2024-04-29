FROM alpine:3.17 AS verify
RUN apk add --no-cache curl tar xz

RUN ROOTFS=$(curl -sfOJL -w "al2023-container-2023.4.20240429.0-arm64.tar.xz" "https://amazon-linux-docker-sources.s3.amazonaws.com/al2023/2023.4.20240429.0/al2023-container-2023.4.20240429.0-arm64.tar.xz") \
  && echo '43ff59925397b911284cf9c47f347742cbed18760bac274bfd1bb2871d8caeff  al2023-container-2023.4.20240429.0-arm64.tar.xz' >> /tmp/al2023-container-2023.4.20240429.0-arm64.tar.xz.sha256 \
  && cat /tmp/al2023-container-2023.4.20240429.0-arm64.tar.xz.sha256 \
  && sha256sum -c /tmp/al2023-container-2023.4.20240429.0-arm64.tar.xz.sha256 \
  && mkdir /rootfs \
  && tar -C /rootfs --extract --file "${ROOTFS}"

FROM scratch AS root
COPY --from=verify /rootfs/ /

CMD ["/bin/bash"]
