##### Makefile for Scid for Unix operating systems.

# This file overwritten by configure

CXX = g++
CC = gcc
LINK = g++

# BINDIR: where the Scid programs are copied for "make install".

BINDIR = /usr/bin/

SHAREDIR = /usr/share/scid/

FONTDIR = /usr/share/fonts/truetype/Scid

### TCL_VERSION: Set this according to the version of Tcl/Tk you have
#   installed that you want Scid to use: 8.5 / 8.6 / ...

TCL_VERSION = 8.5

# TCL_INCLUDE, TCL_LIBRARY, TK_LIBRARY: these are the compiler options
#    needed for linking Scid with Tcl/Tk.  The program "./configure"
#    will try to determine them automatically, but if it cannot, you
#    can use the examples below for help in setting these variables.
#
# The settings determined by "./configure" are:

TCL_INCLUDE = -I/usr/local/include
TCL_LIBRARY = -L/usr/local/lib -ltcl$(TCL_VERSION)
TK_LIBRARY  = $(TCL_LIBRARY) -ltk$(TCL_VERSION) -L/usr/lib -lX11

### Solaris:
# TCL_INCLUDE = -I /usr/local/tcl/include
# TCL_LIBRARY = -L /usr/local/tcl/lib -ltcl$(TCL_VERSION) -ldl
# TK_LIBRARY  = $(TCL_LIBRARY) -ltk$(TCL_VERSION)

### FreeBSD:
# TCL_INCLUDE = -I /usr/local/include/tcl8.0 -I /usr/local/include/tk8.0
# TCL_LIBRARY = -L /usr/local/lib -ltcl80 -ldl
# TK_LIBRARY  = $(TCL_LIBRARY) -ltk80 -L /usr/X11/lib -lX11

### TB: Using Nalimov tablebases with Scid. Use "TB = -DSCID_USE_TB" for 
#      tablebase support, or just "TB = " for no tablebase capability.
#      Use "TB = -DSCID_USE_TB -DT41_INCLUDE" to include use of 4-1
#      (King + 3 pieces vs lone king) tablebases.

TB = -DSCID_USE_TB -DT41_INCLUDE

### SCIDFLAGS: Scid customization flags.
#      Use -DZLIB if your system does not have zlib and you need
#      to include the code in the src/zlib directory.
#      The default is to use the system zlib library.

SCIDFLAGS = 

### DEBUG: Defining the macro ASSERTIONS will turn on assertions, which
#       helps to track bugs after modifications, but the programs will run 
#       a little faster with assertions turned off.

DEBUG = #-DASSERTIONS

### WARNINGS: I always compile with all warnings on (-Wall), and all the
#       files should compile warning-free using g++.

WARNINGS = -Wall

#      On some systems, adding "-fno-rtti" and "-fno-exceptions" produces
#      smaller, faster programs since Scid does not use those C++ features.

CFLAGS = -O2 -fno-rtti -fno-exceptions $(WARNINGS) $(DEBUG)

CXXFLAGS = $(CFLAGS) $(SCIDFLAGS)

LDFLAGS = 

### LANGUAGES: List of additional Tcl files to include in Scid for
#       multi-language menu support.
#       By default, it is all the contributed languages, but you
#       can reduce the size of the Scid program by only specifying
#       the languages you want supported.

LANGUAGES = tcl/lang/deutsch.tcl tcl/lang/francais.tcl tcl/lang/italian.tcl tcl/lang/nederlan.tcl tcl/lang/spanish.tcl tcl/lang/portbr.tcl tcl/lang/swedish.tcl tcl/lang/norsk.tcl tcl/lang/polish.tcl tcl/lang/czech.tcl tcl/lang/hungary.tcl tcl/lang/serbian.tcl tcl/lang/russian.tcl


############################################################
#
# You should not need to edit anything below this line.
#
############################################################

### EXECS: executable programs compiled from C++ files.
#     Note: scidt and eco2epd are obsolete and not compiled by default.
#			PG : put back scidt has it appears to be useful in certain cases

EXECS= pgnscid tkscid tcscid scmerge scidlet scidt

### SCIDOBJS: not all the .o files that make up Scid, just the standard ones 
#     that most of the programs include.

SCIDOBJS= src/misc.o src/index.o src/date.o src/namebase.o src/position.o \
      src/game.o src/gfile.o src/matsig.o src/bytebuf.o src/textbuf.o \
      src/myassert.o src/stralloc.o src/mfile.o src/dstring.o src/pgnparse.o \
      src/stored.o src/movelist.o \
      src/polyglot/attack.o src/polyglot/board.o src/polyglot/book.o \
      src/polyglot/book_make.o src/polyglot/book_merge.o src/polyglot/colour.o \
      src/polyglot/fen.o src/polyglot/game.o src/polyglot/hash.o \
      src/polyglot/io.o src/polyglot/line.o src/polyglot/list.o src/polyglot/main.o src/polyglot/move.o \
      src/polyglot/move_do.o src/polyglot/move_gen.o src/polyglot/move_legal.o src/polyglot/option.o \
      src/polyglot/parse.o src/polyglot/pgn.o src/polyglot/piece.o src/polyglot/random.o \
      src/polyglot/san.o src/polyglot/search.o src/polyglot/square.o src/polyglot/util.o

### ZLIBOBJS: object files in the zlib compression library.

ZLIBOBJS= src/zlib/adler32.o src/zlib/compress.o src/zlib/crc32.o \
      src/zlib/gzio.o src/zlib/uncompr.o src/zlib/deflate.o src/zlib/trees.o \
      src/zlib/zutil.o src/zlib/inflate.o src/zlib/infblock.o \
      src/zlib/inftrees.o src/zlib/infcodes.o src/zlib/infutil.o \
      src/zlib/inffast.o
       
### ZLIB: Should be "-lz" if your system has zlib, "" otherwise.

ZLIB = -lz

### OBJS: Will be "$(SCIDOBJS)", "$(POLYGLOTOBJS)", and also "$(ZLIBOBJS)" if they are
#      needed on your system.

OBJS= $(SCIDOBJS)

### TCLS: all the .tcl files that make up "scid".

TCLS= \
  tcl/start.tcl \
  tcl/config.tcl \
  tcl/bitmaps.tcl \
  tcl/language.tcl \
  tcl/utils.tcl \
    tcl/utils/date.tcl tcl/utils/font.tcl tcl/utils/graph.tcl tcl/utils/history.tcl \
    tcl/utils/pane.tcl tcl/utils/sound.tcl tcl/utils/string.tcl tcl/utils/tooltip.tcl \
    tcl/utils/validate.tcl tcl/utils/win.tcl \
  tcl/misc/misc.tcl tcl/htext.tcl \
  tcl/file.tcl \
    tcl/file/finder.tcl tcl/file/bookmark.tcl tcl/file/recent.tcl tcl/file/epd.tcl \
    tcl/file/spellchk.tcl tcl/file/maint.tcl \
  tcl/edit.tcl \
  tcl/game.tcl \
    tcl/game/browser.tcl \
  tcl/windows.tcl \
    tcl/windows/gamelist.tcl tcl/windows/pgn.tcl tcl/windows/book.tcl \
    tcl/windows/comment.tcl tcl/windows/eco.tcl \
    tcl/windows/stats.tcl tcl/windows/tree.tcl tcl/windows/crosstab.tcl \
    tcl/windows/pfinder.tcl tcl/windows/tourney.tcl tcl/windows/switcher.tcl \
  tcl/search/search.tcl \
    tcl/search/board.tcl tcl/search/header.tcl tcl/search/material.tcl \
  tcl/contrib/ezsmtp/ezsmtp.tcl \
    tcl/tools/email.tcl \
    tcl/tools/import.tcl \
    tcl/tools/optable.tcl tcl/tools/preport.tcl tcl/tools/pinfo.tcl \
    tcl/tools/analysis.tcl tcl/tools/comp.tcl tcl/tools/wbdetect.tcl \
    tcl/tools/reper.tcl tcl/tools/graphs.tcl tcl/tools/tablebase.tcl tcl/tools/ptracker.tcl \
  tcl/help/help.tcl tcl/help/tips.tcl \
  tcl/menus.tcl tcl/board.tcl tcl/move.tcl tcl/main.tcl tcl/tools/correspondence.tcl \
    tcl/lang/english.tcl $(LANGUAGES) \
  tcl/end.tcl tcl/tools/tacgame.tcl tcl/tools/sergame.tcl tcl/tools/calvar.tcl tcl/tools/fics.tcl tcl/tools/tactics.tcl \
  tcl/tools/uci.tcl tcl/tools/novag.tcl tcl/misc/flags.tcl tcl/tools/inputengine.tcl


### SCRIPTS:
# Small extra programs. Most are written in Tcl using tcscid, but
# a few contributed ones may be in Python or other languages.

SCRIPTS= sc_addmove sc_epgn sc_spell sc_eco sc_import sc_remote sc_tree scidpgn pgnfix spliteco

####################

### Type "make" or "make all" to make all programs:

all: all_scid all_engines

all_scid: scid $(SCRIPTS) $(EXECS)

all_engines: phalanx toga

phalanx:
	cd engines/phalanx/ && $(MAKE) && cd ../../

toga:
	cd engines/toga/src/ && $(MAKE) && cd ../../

### To copy all executables to $BINDIR, with read and execute permission 
#   for all users, and put extra files in $SHAREDIR, type "make install".

install: install_scid install_engines

install_scid: all_scid
	install -m 755 -d $(SHAREDIR)
	install -m 755 -d $(BINDIR)
	install -m 755 -d $(SHAREDIR)/data/
	install -m 755 scid $(SCRIPTS) $(EXECS) $(BINDIR)
	install -m 644 -p scid.eco $(SHAREDIR)/data/
	install -m 644 -p spelling.ssp $(SHAREDIR)
	install -m 755 -d $(SHAREDIR)/books
	install -m 666 ./books/* $(SHAREDIR)/books/
	install -m 755 -d $(SHAREDIR)/bases
	install -m 666 ./bases/* $(SHAREDIR)/bases/
	install -m 755 -d $(SHAREDIR)/html
	cp -r ./html/* $(SHAREDIR)/html/
	chmod -R 0777 $(SHAREDIR)/html/*
	@if [ "`id -u`" -eq 0 ]; then \
		install -m 755 -d $(FONTDIR); \
		install -m 644 -p fonts/*.ttf $(FONTDIR); \
	else \
		install -m 755 -d ~/.fonts; \
		install -m 644 -p fonts/*.ttf ~/.fonts; \
	fi
	@if [ ! -z "`which fc-cache`" ]; then \
		if [ "`id -u`" -eq 0 ]; then \
 			fc-cache -fv $(FONTDIR); \
		else \
			fc-cache -fv ~/.fonts; \
		fi; \
	else \
		echo "Don't know how to setup truetype fonts (fc-cache not available)."; \
		echo "Please contact your system administrator."; \
	fi

install_engines: all_engines
	install -m 755 -d $(SHAREDIR)/engines
	install -m 755 -d $(SHAREDIR)/engines/phalanx
	install -m 666 ./engines/phalanx/eco.phalanx $(SHAREDIR)/engines/phalanx
	install -m 644 ./engines/phalanx/HISTORY $(SHAREDIR)/engines/phalanx
	install -m 644 ./engines/phalanx/pbook.phalanx $(SHAREDIR)/engines/phalanx
	install -m 644 ./engines/phalanx/README $(SHAREDIR)/engines/phalanx
	install ./engines/phalanx/phalanx $(BINDIR)
	install -m 755 -d $(SHAREDIR)/engines/toga
	install -m 644 ./engines/toga/copying.txt $(SHAREDIR)/engines/toga
	install -m 644 ./engines/toga/readme.txt $(SHAREDIR)/engines/toga
	install ./engines/toga/src/fruit $(BINDIR)

uninstall:
	rm -rf $(SHAREDIR)/engines
	rm -rf $(SHAREDIR)/books
	rm -rf $(SHAREDIR)/bases
	rm -rf $(SHAREDIR)/data/
	rm -f $(SHAREDIR)/data/scid.eco
	rm -f $(SHAREDIR)/spelling.ssp
	rm -f $(BINDIR)/scid $(BINDIR)/sc_addmove $(BINDIR)/sc_epgn
	rm -f $(BINDIR)/sc_spell $(BINDIR)/sc_eco $(BINDIR)/sc_import
	rm -f $(BINDIR)/sc_remote $(BINDIR)/sc_tree $(BINDIR)/scidpgn
	rm -f $(BINDIR)/pgnfix $(BINDIR)/spliteco
	rm -f $(BINDIR)/pgnscid $(BINDIR)/tkscid $(BINDIR)/tcscid
	rm -f $(BINDIR)/scmerge $(BINDIR)/scidlet
	rm -f $(BINDIR)/phalanx $(BINDIR)/fruit
	rm -rf $(SHAREDIR)/html
	@if [ "`id -u`" -eq 0 ]; then \
		for f in `ls fonts/*.ttf`; do \
			rm -f $(FONTDIR)/`basename $$f`; \
		done; \
		if [ ! -z "`which fc-cache`" ]; then \
			fc-cache -fv $(FONTDIR); \
		fi; \
		if [ "`find $(FONTDIR) -type d -empty`" = "$(FONTDIR)" ]; then \
			rmdir $(FONTDIR); \
		fi; \
	else \
		for f in `ls fonts/*.ttf`; do \
			rm -f ~/.$$f; \
		done; \
		if [ ! -z "`which fc-cache`" ]; then \
			fc-cache -fv ~/.fonts; \
		fi; \
		if [ "`find ~/.fonts -type d -empty`" = "`ls -d ~/.fonts`" ]; then \
			rmdir ~/.fonts; \
		fi; \
	fi

### To remove Scid files placed in the BINDIR and SHAREDIR directories,
#   type "make distclean".

distclean:
	cd $(BINDIR) && rm -f $(EXECS) $(SCRIPTS)
	-rm -f $(SHAREDIR)/scid.eco

clean:
	rm -f game.* tkscid.so tkscid.dll position.* src/*.o src/zlib/*.o src/zlib/*.a src/polyglot/*.o $(EXECS) scid $(SCRIPTS)
	cd engines/phalanx/ && make clean && cd ../../
	cd engines/toga/src/ && make clean && cd ../../../

strip:
	strip $(EXECS)

### To compress scid and executables with gzexe: type "make gzexe".

gzexe:
	gzexe $(EXECS) scid


scid: $(TCLS)
	rm -f ./scid
	cat $(TCLS) > ./scid
	chmod +x scid

### Some of these targets are totally unused, and need sorting out. S.A

sc_addmove: scripts/sc_addmove.tcl
	cp scripts/sc_addmove.tcl ./sc_addmove
	chmod +x sc_addmove

sc_epgn: scripts/sc_epgn.tcl
	cp scripts/sc_epgn.tcl ./sc_epgn
	chmod +x sc_epgn

sc_spell: scripts/sc_spell.tcl
	cp scripts/sc_spell.tcl ./sc_spell
	chmod +x sc_spell

sc_eco: scripts/sc_eco.tcl
	cp scripts/sc_eco.tcl ./sc_eco
	chmod +x sc_eco

sc_import: scripts/sc_import.tcl
	cp scripts/sc_import.tcl ./sc_import
	chmod +x sc_import

sc_remote: scripts/sc_remote.tk
	cp scripts/sc_remote.tk ./sc_remote
	chmod +x sc_remote

sc_tree: scripts/sc_tree.tcl
	cp scripts/sc_tree.tcl ./sc_tree
	chmod +x sc_tree

sc_maketree: scripts/sc_maketree.tcl
	cp scripts/sc_maketree.tcl ./sc_maketree
	chmod +x sc_maketree

scidpgn: scripts/scidpgn.tcl
	cp scripts/scidpgn.tcl ./scidpgn
	chmod +x scidpgn

spliteco: scripts/spliteco.tcl
	cp scripts/spliteco.tcl ./spliteco
	chmod +x spliteco

tbstats: scripts/tbstats.tcl
	cp scripts/tbstats.tcl ./tbstats
	chmod +x tbstats

wmtest: scripts/wmtest.tk
	cp scripts/wmtest.tk ./wmtest
	chmod +x wmtest

pgnfix: scripts/pgnfix.py
	cp scripts/pgnfix.py ./pgnfix
	chmod +x pgnfix

eco2pgn: scripts/eco2pgn.py
	cp scripts/eco2pgn.py ./eco2pgn
	chmod +x eco2pgn

twic2pgn: scripts/twic2pgn.py
	cp scripts/twic2pgn.py ./twic2pgn
	chmod +x twic2pgn

scmerge: src/scmerge.o src/misc.o src/index.o src/date.o src/namebase.o \
          src/gfile.o src/bytebuf.o src/textbuf.o src/myassert.o \
          src/stralloc.o src/position.o
	$(LINK) $(LDFLAGS) -o scmerge src/scmerge.o $(OBJS) $(ZLIB)

pgnscid: src/pgnscid.o $(OBJS)
	$(LINK) $(LDFLAGS) -o pgnscid src/pgnscid.o $(OBJS) $(ZLIB)

scidlet: src/scidlet.o src/engine.o src/recog.o src/misc.o src/position.o \
          src/dstring.o src/movelist.o src/myassert.o
	$(LINK) $(LDFLAGS) -o scidlet src/scidlet.o src/engine.o src/recog.o src/misc.o src/position.o src/movelist.o src/dstring.o src/myassert.o

scidt: src/scidt.o $(OBJS)
	$(LINK) $(LDFLAGS) -o scidt src/scidt.o $(OBJS) $(ZLIB)

tkscid: src/tkscid.o $(OBJS) src/tree.o src/filter.o src/pbook.o src/crosstab.o \
          src/spellchk.o src/probe.o src/optable.o src/engine.o src/recog.o
	$(LINK) $(LDFLAGS) -o tkscid src/tkscid.o $(OBJS) src/tree.o src/filter.o src/pbook.o src/crosstab.o src/spellchk.o src/probe.o src/optable.o src/engine.o src/recog.o $(ZLIB) $(TK_LIBRARY)

tcscid: src/tcscid.o $(OBJS) src/tree.o src/filter.o src/pbook.o src/crosstab.o \
          src/spellchk.o src/probe.o src/optable.o src/engine.o src/recog.o
	$(LINK) $(LDFLAGS) -o tcscid src/tcscid.o $(OBJS) src/tree.o src/filter.o src/pbook.o src/crosstab.o src/spellchk.o src/probe.o src/optable.o src/engine.o src/recog.o $(ZLIB) $(TCL_LIBRARY)

# eco2epd is now optional extra program NOT compiled by default, since
# scid now reads the .eco file format directly.

eco2epd: src/eco2epd.o $(OBJS) src/pbook.o
	$(LINK) $(LDFLAGS) -o eco2epd src/eco2epd.o $(OBJS) src/pbook.o $(ZLIB)

### Rules to create .o files from .cpp files:

src/tcscid.o: src/tkscid.cpp
	$(CXX) $(CXXFLAGS) $(TCL_INCLUDE) -DTCL_ONLY -o src/tcscid.o -c src/tkscid.cpp

src/tkscid.o: src/tkscid.cpp
	$(CXX) $(CXXFLAGS) $(TCL_INCLUDE) -o src/tkscid.o -c src/tkscid.cpp

### The endgame tablebase code in the egtb/ subdirectory (not written by me)

src/probe.o: src/probe.cpp src/egtb/tbindex.cpp src/egtb/tbdecode.c
	$(CXX) $(CXXFLAGS) $(TB) -o src/probe.o -c src/probe.cpp

### Generic rule for all other .cpp files:

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(TCL_INCLUDE) -o $@ -c $<

### Rule for compiling zlib source files:

src/zlib/%.o: src/zlib/%.c
	$(CC) $(CFLAGS) -o $@ -c $<

### End of Makefile