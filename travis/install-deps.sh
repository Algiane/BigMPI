#!/bin/sh
# This configuration file was taken originally from the mpi4py project
# <http://mpi4py.scipy.org/>, and then modified for Julia

set -e
set -x

os="$1"
MPI_IMPL="$2"

case "$os" in
    Darwin)
        brew update
        case "$MPI_IMPL" in
            mpich|mpich3)
                brew install cmake mpich
                ;; 
            openmpi)
                brew install cmake openmpi
                ;;
            *)
                echo "Unknown MPI implementation: $MPI_IMPL"
                exit 1
                ;;
        esac
    ;;

    Linux)
        sudo apt-get update -q
        case "$MPI_IMPL" in
            mpich1)
                sudo apt-get install -q cmake gfortran mpich-shmem-bin libmpich-shmem1.0-dev
                ;;
            mpich2)
                sudo apt-get install -q cmake gfortran mpich2 libmpich2-3 libmpich2-dev
                ;;
            mpich|mpich3)
                sudo apt-get install -q cmake gfortran libcr0 default-jdk
                wget -q http://www.cebacad.net/files/mpich/ubuntu/mpich-3.2b3/mpich_3.2b3-1ubuntu_amd64.deb
                sudo dpkg -i ./mpich_3.1-1ubuntu_amd64.deb
                # rm -f ./mpich_3.1-1ubuntu_amd64.deb
                ;;
            openmpi)
                sudo apt-get install -q cmake gfortran openmpi-bin openmpi-common libopenmpi-dev
                ;;
            *)
                echo "Unknown MPI implementation: $MPI_IMPL"
                exit 1
                ;;
        esac
        ;;

    *)
        echo "Unknown operating system: $os"
        exit 1
        ;;
esac
