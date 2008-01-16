## Filename    : Makefile
## Description : Builds the SBMLToolbox interface under Unix
## Author(s)   : SBML Team <sbml-team@caltech.edu>
## Organization: California Institute of Technology
## Created     : 2004-05-31
## Revision    : $Id$
## Source      : $Source$
##
##<!---------------------------------------------------------------------------
## This file is part of SBMLToolbox.  Please visit http://sbml.org for more
## information about SBML, and the latest version of SBMLToolbox.
##
## Copyright 2005-2007 California Institute of Technology.
## Copyright 2002-2005 California Institute of Technology and
##                     Japan Science and Technology Corporation.
## 
## This library is free software; you can redistribute it and/or modify it
## under the terms of the GNU Lesser General Public License as published by
## the Free Software Foundation.  A copy of the license agreement is provided
## in the file named "LICENSE.txt" included with this software distribution
## and also available online as http://sbml.org/software/sbmltoolbox/license.html
##----------------------------------------------------------------------- -->*/


MEX       = mex
XCFLAGS   = $(CFLAGS)
XLDFLAGS  = $(LDFLAGS)  -L/usr/local/lib
XCPPFLAGS = $(CPPFLAGS) -I/usr/local/include
LIBS      = -lsbml

programs = \
	   	OutputSBML.mexglx				

all: $(programs)


OutputSBML.mexglx: OutputSBML.c
	$(MEX) $(XCFLAGS) $(XCPPFLAGS) $(XLDFLAGS) $^ $(LIBS)


clean:
	/bin/rm -f $(programs) *~
