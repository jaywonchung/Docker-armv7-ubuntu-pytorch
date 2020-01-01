# Docker-armv7-ubuntu-pytorch

Dockerfile and pip wheels used to build images in https://hub.docker.com/r/jaywonchung/armv7-ubuntu-pytorch.

Pulling this image gives you:
1. Ubuntu 19.04
2. Python3.7 -> `python3`
3. Pip for `python3` -> `pip3`
4. Pytorch 1.2.0 and torchvision 0.4.0 for `python3`

Wheels for torch 1.2.0 and torchvision 0.4.0 were downloaded from https://github.com/nmilosev/pytorch-arm-builds. That is, for other versions of pytorch or torchvision, you can just swap the wheels in the `wheels` directory and change the file names in `Dockerfile`. Many thanks to @nmilosev for the fantastic repository!

# Why Ubuntu 19.04?

It had to be Ubuntu 19.04, because 1) the libc6 and libstdc++6 versions the torch/torchvision wheels were made with only comes with Ubuntu 19.04 or higher, and 2) the wheels require python 3.7 which is the default `python3` only in Ubuntu 19.04 or higher. Just proceeding with `FROM ubuntu:18.04` will basically give you two problems due to 1) and 2) respectively:  
1) Dependency errors (e.g. missing GLIBC_2.29) on running `import torch`. Refer to https://github.com/lhelontra/tensorflow-on-arm/issues/13#issuecomment-489296444 and https://packages.ubuntu.com/disco/armhf/libc6/download. I tried this, and got torch running, but it broke the system.
2) You will have to manually install python 3.7 (`apt-get install Python3.7 Python3.7-dev Python3.7-distutils`) and manage packages so that they do not mix with the default python 3.6 on Ubuntu 18.04 (I did this by having `python3` point to `/usr/bin/python3.7` using `update-alternatives`, and then running `get-pip.py` with `python3`.). None of the convenient python package + dependency installations (e.g. `apt-get install python3-pillow`) will work. You can instead install the packages using the wheels for PyYaml, Pillow, and NumPy in the `wheels` directory. I created those wheels myself on an armhf device by building from source.
