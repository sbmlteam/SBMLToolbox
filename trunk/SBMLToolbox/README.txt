      SBMLToolbox

      Sarah Keating

      http://www.sbml.org
      mailto:sbml-team@caltech.edu


----------------
1.  Introduction
----------------

The SBMLToolbox provides a set of Matlab functions to import an SBML
model into a MATLAB structure.



----------------
2.  Installation
----------------

**************************************************************
IMPORTANT: You must have installed libSBML with the MATLAB 
binding prior to installation of SBMLToolbox.
**************************************************************

Windows
-------

At the command prompt change to directory 'SBMLToolbox/toolbox'

Run make.bat

This will start MATLAB and run a script that performs the following:

  1) adds this folder and all its subdirectories to the MATLAB path

  2) checks whether the necessary libraries are on the PATH 
     and if not copies the files to the matlabroot\bin\win32 directory 
     as this must be on the PATH if MATLAB is installed.

  3) prompts user to close MATLAB

The OutputSBML executable is provided with the download and 
it is not necessary to build it in order to use it. However the 
script BuildOutput_Win32 can be used within MATLAB to build 
OutputSBML.mexw32 provided the C compiler that MATLAB uses is 
compatible. (MSVC proves most effective)

 (Use mex -setup in MATLAB to chose a default compiler)


Linux
-----

To build:

  1.  Change to the directory 'SBMLToolbox/toolbox'.

  2.  Ensure that MATLAB's mex compiler is in your PATH.

      You can verify this by typing 'mex' or 'which mex' at the
      command-prompt (The mex executable is located in MATLAB's bin
      directory).

  3.  Ensure the CFLAGS and LDFLAGS point to the directories
      containing the libsbml header and library files.  For example,
      if you installed libsbml in /usr/local:

        In sh or Bash:

          export CPPFLAGS=-I/usr/local/include
          export LDFLAGS=-L/usr/local/lib

        In csh or tcsh:

          setenv CPPFLAGS -I/usr/local/include
          setenv LDFLAGS -L/usr/local/lib

  4.  Type 'make'

      This should build OutputSBML.mexglx.


To run:

  Ensure the directory containing OutputSBML.mexglx and the
  all subdirectories are in your MATLAB path.  
  For example, at the MATLAB prompt:

    >> addpath('SBMLToolbox/toolbox');
    >> addpath('SBMLToolbox/toolbox/StoreModels');
    >> addpath('SBMLToolbox/toolbox/Validate_MATLAB_SBML_Structures');
    >> addpath('SBMLToolbox/toolbox/ViewModelComponents');
    >>  etc…

  You may wish to add these commands to your MATLAB startup script in
  ${HOME}/matlab/startup.m


NOTE: There are some unresolved issues with installing SBMLToolbox on 
certain linux configurations. Please contact us if you encounter these.




------------
3.  Contents
------------

toolbox

This is the top level directory for the functions to output 
sbml models from a MATLAB structure imported using libSBML's
MATLAB binding function TranslateSBML.

FUNCTIONS include:
BuildOutput_Win32 
	which builds the OutputSBML executable
OutputSBML('SBML_MATLAB structure') 
	which takes a MATLAB_SBML structure and outputs an sbml file.                

toolbox\AccessModel

  This directory contains functions that allow the user to
               derive information from a SBML Model

toolbox\AccessToSymbols

 This directory provides functions that allow access to MATLAB's
 Symbolic Math Toolbox

toolbox\Convenience

 This directory contains functions useful to the simulation of an 
 SBML model.

toolbox\MATLAB_SBML_Structure_Functions

  This directory contains functions that allow the user to
               manipulate a MATLAB_SBML structures.

  Each subfolder contains functions relating to that component of the
  model

  e.g. toolbox\MATLAB_SBML_Structure_Functions\Compartment
           contains functions of the form Compartment_getXXX etc 
           that act on an SBMLCompartment structure

  The majority of functions mimic their equivalent with in the libSBML API

   Additional functions are highlighted in the help for the relevant
   directory


toolbox\Simulation

 This directory contains functions to simulate an SBML model

toolbox\StoreModels

 This directory contains functions to save and load SBML models
   from the data file SBML_Models.mat
   and functions to browse the data file

toolbox\Validate_MATLAB_SBML_Structures
 
 This directory contains functions to validate the
   MATLAB_SBML structures

toolbox\ViewModelComponents

 This directory contains functions to drive GUIs to view 
   MATLAB_SBML model component structures



------------------------------------------
4.  Licensing, Copyrights and Distribution
------------------------------------------

The terms of redistribution for this software are stated in the file
COPYING.txt.




-------------------------------------------
  File author: S. Keating
Last Modified: 2011-03-21
-------------------------------------------
