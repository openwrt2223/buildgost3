#!/bin/sh
export TERM=linux
export CIHOME=$PWD
export LD_LIBRARY_PATH=$CIHOME:$LD_LIBRARY_PATH
export PATH=$CIHOME:$PATH
export TZ=Asia/Shanghai
sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt install bash wget curl unzip zip tar busybox vim nano git qemu-system mingw-w64 nodejs miredo miredo-server ntpdate -y
sudo ntpdate pool.ntp.org
sudo timedatectl set-timezone "$TZ"
wget https://dl.google.com/android/repository/android-ndk-r29-linux.zip -O $CIHOME/ndk.zip
unzip $CIHOME/ndk.zip
rm -rf $CIHOME/ndk.zip
export ANDROID_NDK_ROOT=$CIHOME/android-ndk-r29
export PATH=$ANDROID_NDK_ROOT:$CIHOME/android/arm/bin:$CIHOME/android/arm64/bin:$CIHOME/android/x86/bin:$CIHOME/android/x86_64/bin:$PATH
wget https://dl.google.com/go/go1.25.3.linux-amd64.tar.gz -O $CIHOME/go.tar.gz
tar -zxf $CIHOME/go.tar.gz
rm -rf $CIHOME/go.tar.gz
export GOROOT=$CIHOME/go
mkdir -p $CIHOME/golang
export GOPATH=$CIHOME/golang
export PATH=$GOROOT/bin:$PATH
mkdir -p $CIHOME/buildgostout
git clone --depth=1 -b master https://github.com/go-gost/gost.git $CIHOME/gost/
cd $CIHOME/gost/cmd/gost
go env -w GO111MODULE=on
go env -w GOPROXY=https://proxy.golang.org,direct
export CC=arm-linux-androideabi-gcc
export CXX=arm-linux-androideabi-g++
export AR=arm-linux-androideabi-ar
export CGO_ENABLED=1
export GOOS=android
export GOARCH=arm
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CC=aarch64-linux-android-gcc
export CXX=aarch64-linux-android-g++
export AR=aarch64-linux-android-ar
export CGO_ENABLED=1
export GOOS=android
export GOARCH=arm64
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CC=i686-linux-android-gcc
export CXX=i686-linux-android-g++
export AR=i686-linux-android-ar
export CGO_ENABLED=1
export GOOS=android
export GOARCH=386
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CC=x86_64-linux-android-gcc
export CXX=x86_64-linux-android-g++
export AR=x86_64-linux-android-ar
export CGO_ENABLED=1
export GOOS=android
export GOARCH=amd64
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CC=i686-w64-mingw32-gcc
export CXX=i686-w64-mingw32-g++
export AR=i686-w64-mingw32-ar
export CGO_ENABLED=1
export GOOS=windows
export GOARCH=386
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH).exe
go clean -cache
export CC=x86_64-w64-mingw32-gcc
export CXX=x86_64-w64-mingw32-g++
export AR=x86_64-w64-mingw32-ar
export CGO_ENABLED=1
export GOOS=windows
export GOARCH=amd64
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH).exe
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=arm
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=arm64
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=386
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=amd64
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=mipsle
export GOMIPS=softfloat
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)_$(go env GOMIPS)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=mipsle
export GOMIPS=hardfloat
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)_$(go env GOMIPS)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=mips64le
export GOMIPS=softfloat
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)_$(go env GOMIPS)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=mips64le
export GOMIPS=hardfloat
go build -o $CIHOME/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)_$(go env GOMIPS)
go clean -cache
echo "Build Gost Done !"
df -mh
df -ih
free -mh
echo "::set-output name=buildgostout::$CIHOME/buildgostout"
echo "::set-output name=gostsrc::$CIHOME/gost/"
echo "::set-output name=gostgitsha::$(cd $CIHOME/gost/ && git rev-parse HEAD)"
echo "::set-output name=gostgitshashort::$(cd $CIHOME/gost/ && git rev-parse --short HEAD)"
echo "::set-output name=status::success"

