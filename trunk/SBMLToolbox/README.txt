      SBMLToolbox


      Sarah Keating
      Science and Technology Research Centre
      University of Hertfordshire
      Hatfield, AL10 9AB
      United Kingdom

      http://www.sbml.org
      mailto:sbml-team@caltech.edu


----------------
1.  Introduction
----------------

The SBMLToolbox provides a set of Matlab functions to import an SBML
model into a Matlab structure.




----------------
2.  Installation
----------------


Windows
-------

At the command prompt change to directory 'SBMLToolbox/src'

Run make.bat

This will start Matlab and run a script that performs the following

  1) adds this folder and all its subdirectories to the Matlab path

  2) checks whether the necessary libraries are on the PATH 
     and if not copies the files to the matlabroot\bin\win32 directory 
     as this must be on the PATH if matlab is installed.

  3) prompts user to close Matlab

The TranslateSBML executable is provided with the download and it is not necessary to build it in order to use it. However the script BuildTranslate_Win32 can be used within matlab to build TranslateSBML.dll provided the C compiler that Matlab uses is compatible (Working on this!)

 (Use mex -setup in MATLAB to chose a default compiler)


Linux
-----

To build:

  1.  Change to the directory 'SBMLToolbox/src'.

  2.  Ensure that Matlab's mex compiler is in your PATH.

      You can verify this by typing 'mex' or 'which mex' at the
      command-prompt (The mex executable is located in Matlab's bin
      directory).

  3.  Ensure the CFLAGS and LDFLAGS point to the directories
      containing the libsbml header and library files.  For example,
      if you installed libsbml in /usr/local:

        In sh or Bash:

          export CFLAGS=-I/usr/local/include
          export LDLAGS=-L/usr/local/lib

        In csh or tcsh:

          setenv CFLAGS -I/usr/local/include
          setenv LDLAGS -L/usr/local/lib

  4.  Type 'make'

      This should build TranslateSBML.mexglx.


To run:

  Ensure the directory containing TranslateSBML.mexglx and the
  StoreModels, ValidationTexts and ViewModelComponents subdirectories
  are in your Matlab path.  For example, at the Matlab prompt:

    >> addpath('SBMLToolbox/src');
    >> addpath('SBMLToolbox/src/StoreModels');
    >> addpath('SBMLToolbox/src/ValidationTests');
    >> addpath('SBMLToolbox/src/ViewModelComponents');

  You may wish to add these commands to your Matlab startup script in
  ${HOME}/matlab/startup.m


If you have any questions or problems with the above install
procedure, please email Ben Bornstein (bornstei@caltech.edu).  In a
future release of libsbml, this procedure will be integrated with the
top-level build ('configure') script.




------------
3.  Contents
------------

BuildTranslate_Win32 
Builds the TranslateSBML executable

TranslateSBML('filename') 
Translates a SBML file into a Matlab structure


ValidationTests
---------------

A set of functions that check whether the Matlab structure supplied
corresponds to the SBML_MATLAB structure for that type.


StoreModels
-----------

SaveSBMLModel(Model) 

Checks that the structure supplied is of the correct form creates
"SBML_Models.mat" if the file does not already exist writes the model
to the data file as the next element.


LoadSBMLModel(input, level) 

Returns a model from "SBML_Models.mat" where input can be an integer
relating to the number of the model within the data file or the Name
field of the model requested and level is the SBML level (either 1 or 2).


ListSBMLModels 

Returns a list of the saved models with index, level and names


DeleteSBMLModel(input, level) 

Deletes a model from "SBML_Models.mat" where input can be an integer
relating to the number of the model within the data file or the Name
field of the model requested and level is the SBML level (either 1 or 2).


ViewModel(Model) 

Raises a GUI that illustrate the SBML model 'Model'


BrowseSBML_Models 

Calls BrowseModels which enables a GUI that browses the Matlab data
file SBML_Models.dat If an output argument is specified then a model
can be loaded from the data file This GUI also allows models to be
deleted from the data file.


BrowseModels(number) 

Called from BrowseSBML_Models


AlreadyExists

Called from BrowseModels raises a modal GUI that prompts user for
overwrite permission for a model name that already exists within the
SBML_Models data file.


ViewModelComponents
-------------------

A set of GUIs that allows all components of the model and their
corresponding values to be viewed.

AccessToSymbols
---------------

A set of functions that allow access to MATLAB's Symbolic Toolbox.


------------------------------------------
4.  Licensing, Copyrights and Distribution
------------------------------------------

The terms of redistribution for this software are stated in the file
COPYING.txt.




-------------------------------------------
  File author: S. Keating
Last Modified: 2004/03/29 
-------------------------------------------
