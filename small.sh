#!/bin/sh
BINARYSEL=$1
BINARY=""
READS="smallreads.fastq.gz"
REF="smallref.fa.gz"
INDEX="smallref.fa.gz.bwt"
REFURL="https://github.com/smikkelsendk/bwa-benchmark/raw/main/smallbenchmark/"
BINARYURL="https://github.com/smikkelsendk/bwa-for-arm/raw/master/bin/"
OS=$(uname)
ARCH=$(uname -m)
if [ $? -eq 0 ]
then
echo "Detected ${OS}-${ARCH}"
   BINARYSEL="${OS}-${ARCH}"
fi
if [ "$BINARYSEL" = "" ]
then
   echo "First argument must be name of archichture"
   exit 1
fi

case $BINARYSEL in

  "Linux-x86_64")
    BINARY="bwa0717-x64"
    ;;

  "Linux-i686")
    BINARY="bwa0717-i686"
    ;;

  "Linux-aarch64")
    BINARY="bwa0717-aarch64"
    ;;

  "Linux-armv7l")
    BINARY="bwa0717-aarch32-armv7"
    ;;

  "Darwin-x86_64")
    BINARY="bwa0717-mac-x64"
    ;;

  "Darwin-arm64")
    BINARY="bwa0717-mac-aarch64"
    ;;

  *)
    echo "Unknown binary. aborting"
    exit 1
    ;;
esac

if [ ! -f $REF ]
then
   wget "${REFURL}${REF}"
fi

if [ ! -f $READS ]
then
   wget "${REFURL}${READS}"
fi


BINARYURL="${BINARYURL}${BINARY}.tar.gz"

if [ ! -f $BINARY ]
then
   wget "$BINARYURL"
   gunzip "${BINARY}.tar.gz"
   tar xf "${BINARY}.tar"
   rm "${BINARY}.tar"
fi


#index
if [ ! -f $INDEX ]
then
./$BINARY index $REF
fi

if [ "$OS" = "Linux" ]; then
CORES=$(grep -c ^processor /proc/cpuinfo)
fi

if [ "$OS" = "Darwin" ]; then
CORES=$(sysctl -n hw.ncpu)
fi

if [ "$CORES" -gt "0" ]; then
echo "Cores $CORES"
else
   echo "Core detection failed. Using up to 4 cores"
   CORES=4
fi

#benchmark 1 core
./$BINARY aln -t 1 $REF $READS  > /dev/null 2>output.txt
OUTPUT=$(grep "Real time" output.txt)
echo "1 core: $OUTPUT"

if [ "$CORES" -gt "1" ]; then
#cooldown
sleep 20
#benchmark 2 core
./$BINARY aln -t 2 $REF $READS  > /dev/null 2>output.txt
OUTPUT=$(grep "Real time" output.txt)
echo "2 cores: $OUTPUT"
fi

if [ "$CORES" -gt "3" ]; then
#cooldown
sleep 20
#benchmark 4 core
./$BINARY aln -t 4 $REF $READS  > /dev/null 2>output.txt
OUTPUT=$(grep "Real time" output.txt)
echo "4 cores: $OUTPUT"
fi

if [ "$CORES" -gt "7" ]; then
#cooldown
sleep 20
#benchmark 8 core
./$BINARY aln -t 8 $REF $READS  > /dev/null 2>output.txt
OUTPUT=$(grep "Real time" output.txt)
echo "8 cores: $OUTPUT"
fi

if [ "$CORES" -gt "8" ]; then
#cooldown
sleep 20
#benchmark max cores
./$BINARY aln -t $CORES $REF $READS  > /dev/null 2>output.txt
OUTPUT=$(grep "Real time" output.txt)
echo "$CORES cores: $OUTPUT"
fi

rm output.txt

