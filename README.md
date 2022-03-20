# bwa-benchmark
Benchmarking of devices using BWA (Burrows-Wheeler Aligner) 
## How to run benchmark on Android
- Download and install Termux from F-Droid https://f-droid.org/en/packages/com.termux/
- Install wget and proot
- Download benchmark script using wget
- Run *proot -0*
- Run benchmark script (*sh small.sh* / *sh large.sh*)

## How to run on linux/mac
- Download benchmark script
- Run benchmark script (*sh small.sh* / *sh large.sh*)

## Benchmark (small)
| Model | CPU | Arch | OS | Kernel| #Threads|  1 thread (sec) | 2 threads (sec) | 4 threads (sec)  | 8 threads (sec) | All threads (sec)|
|--|--|--|--|--|--|--|--|--|--|--|
| Raspberry Pi Zero 2|  RP3A0 |aarch64 | Raspberry Pi OS (bullseye) | 5.10.92 | 4 |521 | 277 |163|
| Raspberry Pi 400 | BCM2711| aarch64 | Ubuntu 20.04.4 LTS | 5.4.0 | 4 | 210 | 111 | 63
| LG G5 |  Snapdragon 820| aarch64 | Android 11 (LineageOS) | 3.18.113 | 4 | 311 | 143 | 88
| Xiao Mi 9T Pro |  Snapdragon 855 | aarch64 | Android 11 (stock) | 4.14.180 | 8 | 119| 63 | 35 | 27
| Motorola Moto G200 5G |  Snapdragon 888+ 5G | aarch64 | Android 11 (stock) | 5.4.86 | 8 | 53 | 35 | 20 | 16
| PC |  I9-12900k | x86_64 | Fedora 35 | 5.16.15 | 24 |36|19|10|6|4


## Benchmark (large)
| Model | CPU | Arch | OS | Kernel| #Threads|   4 threads (sec)  | 8 threads (sec) | All threads (sec)|
|--|--|--|--|--|--|--|--|--|
| Raspberry Pi 400 | BCM2711| aarch64 | Ubuntu 20.04.4 LTS | 5.4.0 | 4 | 466
| LG G5 |  Snapdragon 820| aarch64 | Android 11 (LineageOS) | 3.18.113 | 4 |  342 | 
| Xiao Mi 9T Pro |  Snapdragon 855 | aarch64 | Android 11 (stock) | 4.14.180 | 8 | 140 | 102
| Motorola Moto G200 5G |  Snapdragon 888+ 5G | aarch64 | Android 11 (stock) | 5.4.86 | 8 | 118 | 90
| PC |  I9-12900k | x86_64 | Fedora 35 | 5.16.15 | 24 | 45 | 25 | 18

