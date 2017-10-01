#!/bin/bash
#
# Daredevil Kernel compilation script for ubertc compilation
#
# Copyright (C) 2017 Pablo Fraile Alonso (Github aka: Pablito2020)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>


# Set Colors! (some of there aren't used, but if you like, you can add it in the echo lines.)
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
green='\033[0;32m'
red='\033[0;31m'
nocol='\033[0m'
orange='\033[0;33m'
light_red='\033[1;31m'
purple='\033[0;35m'

# Say info about the kernel and the script in terminal
echo -e "${orange}####################################################"
echo -e "${orange}#      INFO ABOUT THE DAREDEVIL KERNEL SCRIPT      #"
echo -e "${orange}####################################################"
echo -e "${orange}#                                                  #"
echo -e "${orange}#                  KERNEL INFO:                    #"
echo -e "${orange}#                                                  #"
echo -e "${orange}#             DEVICE: BQ AQUARIS E4.5              #"
echo -e "${orange}#               DEVICE AKA: krillin                #"
echo -e "${orange}#          LINUX KERNEL VERSION: 3.10.107          #"
echo -e "${orange}#                DAREDEVIL VERSION: N              #"
echo -e "${orange}#           KERNEL TOOLCHAIN: LINARO 7.X           #"
echo -e "${orange}#                                                  #"
echo -e "${orange}####################################################"
echo -e "${orange}#                                                  #"
echo -e "${orange}#                  SCRIPT INFO:                    #"
echo -e "${orange}#             DEVELOPER: PABLITO2020               #"
echo -e "${orange}#         THANKS TO: ASSUSDAN AND ARIAFAN          #"
echo -e "${orange}#                                                  #"
echo -e "${orange}####################################################"

# If the ubertc toolchain 6.0 doesn't exist, clone it. 
# If exists, export the toolchain path
if [ ! -f ../arm-linaro-linux-androideabi/bin/arm-linaro-linux-androideabi-addr2line ]
then
    echo -e "####################################"
    echo -e "#   LINARO TOOLCHAIN NOT FOUND!    #"
    echo -e "####################################"
cd ..
git clone https://github.com/Pablito2020/linaro-7.x.git
mv android_kernel_bq_krillin Daredevil
cd Daredevil
export ARCH=arm CROSS_COMPILE=../arm-linaro-linux-androideabi-addr2line/bin/arm-linaro-linux-androideabi-
else
export ARCH=arm CROSS_COMPILE=../arm-linaro-linux-androideabi/bin/arm-linaro-linux-androideabi-
fi

# User and Build Host
export KBUILD_BUILD_USER=pablito
export KBUILD_BUILD_HOST=linuxmachine

# Read the lineage/AOSP DEFCONFIG
echo -e "${orange} CONFIGURE KRILLIN.."
make lineage_krillin_defconfig

# Build zImage (Thanks to Joel for the all command)
echo -e "${orange} BUILD DAREDEVIL KERNEL FOR KRILLIN.."
make -j4

# Check if there are errors in the kernel
if [ ! -f arch/arm/boot/zImage ]
then
    echo -e "${red}############################"
    echo -e "${red}#        BUILD ERROR!      #"
    echo -e "${red}############################"
else

# If the kernel compiles succesfully
echo -e "${green} #########################################"
echo -e "${green} #                                       #"
echo -e "${green} # SUCCESSFULLY BUILDED DAREDEVIL KERNEL #"
echo -e "${green} #        $[$SECONDS / 60]' minutes '$[$SECONDS % 60]' seconds'       #" 
echo -e "${green} #                                       #"
echo -e "${green} #########################################"
fi

# Build worktime ( added in line 59 for now.)
# echo $[$SECONDS / 60]' minutes '$[$SECONDS % 60]' seconds' 

