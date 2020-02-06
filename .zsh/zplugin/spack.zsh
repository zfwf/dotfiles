# spack
zinit ice wait lucid as'program' pick'bin/spack' \
  atclone'./bin/spack bootstrap; \
          ./bin/spack install lmod coreutils automake autoconf openssl \
          libyaml readline libxslt libtool unixodbc unzip curl libevent jq \
          tig mosh axel; \
         ' \
  atpull'%atclone' \
  atload'. $PWD/share/spack/setup-env.sh'
zinit light spack/spack


