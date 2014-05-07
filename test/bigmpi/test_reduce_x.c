#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <string.h>
#include <strings.h>

#include <mpi.h>
#include "bigmpi.h"
#include "verify_buffer.h"

#ifdef BIGMPI_MAX_INT
const MPI_Count test_int_max = BIGMPI_MAX_INT;
#else
#include <limits.h>
const MPI_Count test_int_max = INT_MAX;
#endif

/* Yes, it is technically unsafe to cast MPI_Count to MPI_Aint or size_t without checking,
 * given that MPI_Count might be 128b and MPI_Aint and size_t might be 64b, but BigMPI
 * does not aspire to support communication of more than 8 EiB messages at a time. */

int main(int argc, char * argv[])
{
    MPI_Init(&argc, &argv);

    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (size<2) {
        printf("Use 2 or more processes. \n");
        MPI_Finalize();
        return 1;
    }

    int l = (argc > 1) ? atoi(argv[1]) : 2;
    int m = (argc > 2) ? atoi(argv[2]) : 17777;
    MPI_Count n = l * test_int_max + m;

    double * sbuf = NULL;
    double * rbuf = NULL;

    MPI_Aint bytes = n*sizeof(double);
    MPI_Alloc_mem(bytes, MPI_INFO_NULL, &sbuf);
    MPI_Alloc_mem(bytes, MPI_INFO_NULL, &rbuf);

    for (MPI_Count i=0; i<n; i++) {
        sbuf[i] = (double)rank;
    }
    for (MPI_Count i=0; i<n; i++) {
        rbuf[i] = 0.0;
    }

    /* collective communication */
    MPIX_Reduce_x(sbuf, rbuf, n, MPI_DOUBLE, MPI_SUM, 0 /* root */, MPI_COMM_WORLD);

    if (rank==0) {
        double val = (double)size*(size+1.)/2.;
        size_t errors = verify_doubles(rbuf, n, val);
        if (errors) return errors;
    }

    MPI_Free_mem(sbuf);
    MPI_Free_mem(rbuf);

    if (rank==0) {
        printf("SUCCESS\n");
    }

    MPI_Finalize();

    return 0;
}