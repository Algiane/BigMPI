#
# Copyright (C) 2014. See LICENSE in top-level directory.
#

check_PROGRAMS += test/test_bcast_x \
		  test/test_allreduce_x \
		  test/test_alltoall_x \
		  test/test_assert_x \
		  test/test_bcast_x \
		  test/test_contig_x \
		  test/test_gather_x \
		  test/test_isend_irecv_x \
		  test/test_reduce_x \
		  test/test_rma_x \
		  test/test_rma2_x \
		  test/test_scatter_x \
		  test/test_send_recv_x \
		  test/test_sendrecv_x

test          = test/test_bcast_x \
		test/test_allreduce_x \
		test/test_alltoall_x \
		test/test_assert_x \
		test/test_bcast_x \
		test/test_contig_x \
		test/test_gather_x \
		test/test_isend_irecv_x \
		test/test_reduce_x \
		test/test_rma_x \
		test/test_rma2_x \
		test/test_scatter_x \
		test/test_send_recv_x \
		test/test_sendrecv_x

XFAIL_test    = test/test_assert_x

test_test_bcast_x_LDADD = libbigmpi.la
test_test_allreduce_x_LDADD = libbigmpi.la
test_test_alltoall_x_LDADD = libbigmpi.la
test_test_assert_x_LDADD = libbigmpi.la
test_test_contig_x_LDADD = libbigmpi.la
test_test_gather_x_LDADD = libbigmpi.la
test_test_isend_irecv_x_LDADD = libbigmpi.la
test_test_reduce_x_LDADD = libbigmpi.la
test_test_rma_x_LDADD = libbigmpi.la
test_test_rma2_x_LDADD = libbigmpi.la
test_test_scatter_x_LDADD = libbigmpi.la
test_test_send_recv_x_LDADD = libbigmpi.la
test_test_sendrecv_x_LDADD = libbigmpi.la
