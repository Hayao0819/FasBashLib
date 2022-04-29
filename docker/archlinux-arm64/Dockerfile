FROM agners/archlinuxarm
#RUN echo 'Server = https://mirrors.kernel.org/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
#RUN reflector --protocol https -c Japan --sort rate --save /etc/pacman.d/mirrorlist
RUN pacman -Sy --noconfirm git curl grep awk glibc mkinitcpio bash coreutils jq
COPY . /FasBashLib
WORKDIR /FasBashLib
ENTRYPOINT ["bash", "./bin/Test-Run.sh"]
CMD []
