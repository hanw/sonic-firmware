//                              -*- Mode: Verilog -*-
// Filename        : sonic_ring_mmap.sv
// Description     : DMA address to RING address mapping
// Author          : Han Wang
// Created On      : Wed Nov 16 13:11:25 2011
// Last Modified By: Han Wang
// Last Modified On: Wed Nov 16 13:11:25 2011
// Update Count    : 0
// Status          : Unknown, Use with caution!

/*
 * DMA engine issues address for 128-bit block in rx_ring.
 * sonic_ring_mmap translates incoming address to addresses
 * for sync_ring and data_ring.
 * 
 * Assume we have 8192 128-bit blocks in the ring. The DMA
 * address is 15 bit width.
 * ----------------------------------------------------------------------
 * [14                              0]: entire 
 *                   [7             0]: address sync header segment
 * [14      10]                       : address page
 *             [9  8][7             0]: address data block, if [9:8]!=0. 
 * 
 * dma_addr[9] & dma_addr[8] : sel between sync_ring and data_ring
 * 
 * For instance, 
 * |      DMA Address       |     sync_ring address |  rd_ena   |    data_ring address   |  sel  |  
 *  0b000_0000_0000_0000           0b000_0000_0000       1          same as DMA address      0
 *  0b000_0000_0000_1000           0b000_0000_1000       1          same as DMA address      0
 *  0b000_0000_0001_0000           0b000_0000_0000       0          same as DMA address      1
 *  0b000_0001_0000_0000           0b000_0001_0000       1          same as DMA address      0
 *  0b000_0001_0001_0000           0b000_0001_0000       1          same as DMA address      1
 *  0b000_0011_0000_0000           0b000_0011_0000       1          same as DMA address      0
 * 
 * sync_ring_address = dma_address[14:8] | dma_address[3:0];
 * data_ring_address = dma_address;
 * sel = dma_address[7] | dma_address[6] | dma_address[5] | dma_address[4];
 * rd_ena to sync_ring can be const '1'.
 * wr_ena to sync_ring is controlled by blocksync.
 * rd_ena to data_ring can be const '1'.
 * wr_ena to data_ring is controlled by blocksync.
 * 
 * NOTE: consider the read latency.
 */

//-----------------------------------------------------------------------------------------
// Copyright 2011 Cornell University. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this list of
// conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
// of conditions and the following disclaimer in the documentation and/or other materials
// provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY CORNELL UNIVERSITY ''AS IS'' AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
// FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
// ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// The views and conclusions contained in the software and documentation are those of the
// authors and should not be interpreted as representing official policies, either expressed
// or implied, of Cornell University.
//------------------------------------------------------------------------------------------
