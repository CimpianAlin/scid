//////////////////////////////////////////////////////////////////////
//
//  FILE:       bytebuf.h
//              ByteBuffer class.
//
//  Part of:    Scid (Shane's Chess Information Database)
//  Version:    0.2
//
//  Notice:     Copyright (c) 1999  Shane Hudson.  All rights reserved.
//
//  Author:     Shane Hudson (sgh@users.sourceforge.net)
//
//////////////////////////////////////////////////////////////////////

// The ByteBuffer class is used to read and write binary buffers.
// It is primarily used in Scid for storing in-memory the contents of
// a game as it is represented on-disk in the gamedata file (gfile).


#ifndef SCID_BYTEBUF_H
#define SCID_BYTEBUF_H

#include "common.h"
#include <string.h>


class ByteBuffer
{
 private:
    //----------------------------------
    //  TextBuffer:  Data Structures
    //----------------------------------

    uint   ReadPos;
    uint   ByteCount;
    uint   BufferSize;
    byte * Buffer;
    byte * Current;
    byte * AllocatedBuffer;
    byte * ExternalBuffer;

    errorT Err;
    
    //----------------------------------
    //  TextBuffer:  Public Functions
    //----------------------------------
 public:
    ByteBuffer(uint length) : BufferSize(length), AllocatedBuffer(new byte[length]) { Empty(); }
    ~ByteBuffer() { delete[] AllocatedBuffer; }

/*
 * ProvideExternal is super dangerous:
 * - GFile::ReadGame will change "data" when reading another game
 * - At that point reading or __writing__ to the bytebuffer will create havoc
 * For example calling GFile::ReadGame(&bytebuffer, ...) followed by GFile::AddGame(&bytebuffer)
 * is __very__ bad
 */
    void ProvideExternal (byte * data, uint length);

    errorT Status ()      { return Err; }
    uint   GetByteCount() { return ByteCount; }
    void   BackToStart ();
    void   Skip (uint value);
    byte   GetByte () {
        ASSERT(Current != NULL);
        if (ReadPos >= ByteCount) { Err = ERROR_BufferRead; return 0; }
        byte b = *Current;
        Current++; ReadPos++;
        return b;
    }
    void   GetFixedString (char *str, uint length);
    uint   GetTerminatedString (char **str);
    void   CopyTo (byte * target) {
        memcpy( target , Buffer, ByteCount);
    }

/*
 * Writing to a bytebuffer is very error-prone
 * - Empty() must be called to be sure that Buffer points to the internal buffer
 *   and to clear the Error Flag;
 * - Status() must be called after every Put
 */
    void Empty ();
    void PutByte (byte value) {
        ASSERT(Current != NULL);
        ASSERT(Buffer == AllocatedBuffer);
        if (Buffer == AllocatedBuffer  && ByteCount >= BufferSize) {
            Err = ERROR_BufferFull; return;
        }
        *Current = value;
        Current++; ByteCount++;
    }
    void PutFixedString (const char *str, uint length);
    void PutTerminatedString (const char *str);


private:
	ByteBuffer(const ByteBuffer&);
	ByteBuffer& operator=(const ByteBuffer&);
};

#endif  // #ifndef SCID_BYTEBUF_H

//////////////////////////////////////////////////////////////////////
//  EOF: bytebuf.h
//////////////////////////////////////////////////////////////////////
