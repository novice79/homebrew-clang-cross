#!/usr/bin/env bash

docker run --privileged --rm tonistiigi/binfmt --install arm64,arm
# docker buildx ls
add_pack=/tmp/ins_pack.sh
tee $add_pack <<- OUT
#!/bin/sh
tee /etc/apk/repositories <<- EOT
http://mirrors.ustc.edu.cn/alpine/v3.17/main
http://mirrors.ustc.edu.cn/alpine/v3.17/community
EOT
apk update
# use system provided zlib & openssl; while build boost myself
apk add g++ libc-dev linux-headers \
zlib-dev zlib-static \
openssl-dev openssl-libs-static
echo "installation finished. Wait for copy sysroot"
while true; do sleep 2;done
OUT
chmod +x $add_pack

sys=( 
   linux/arm/v6:armv6-alpine-linux-musl
   linux/arm/v7:armv7-alpine-linux-musl
   linux/arm64:aarch64-alpine-linux-musl
   linux/amd64:x86_64-alpine-linux-musl
)
for i in "${sys[@]}";do
    IFS=':' read -ra t <<< "$i"
    docker run -d --name sys \
    -v $add_pack:/ins_pack.sh \
    --platform "${t[0]}" \
    alpine /ins_pack.sh

    until [[ $(docker logs sys | tail -n 1) =~ "Wait for copy sysroot" ]]; do sleep 2; done
    mkdir -p ${t[1]}/{lib,usr}
    docker cp sys:/lib/ - | tar -x -C "${t[1]}/"
    rm -rf ${t[1]}/lib/{apk,firmware,mdev,modules-load.d,sysctl.d}
    docker cp sys:/usr/include "${t[1]}/usr"
    docker cp sys:/usr/lib - | tar -x -C "${t[1]}/usr"
    rm -rf ${t[1]}/usr/lib/{bfd-plugins,engines-3,modules-load.d,ossl-modules}
    find ${t[1]} -name "*.so*" | xargs rm -f
    docker rm -f sys
    echo "copy ${t[1]} sysroot finished"
done

# for i in *-musl/;do rm -rfv $i/lib; done