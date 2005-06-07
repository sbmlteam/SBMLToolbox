      SBMLToolbox


      Sarah Keating
      Science and Technology Research Institute
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

At the command prompt change to directory 'SBMLToolbox/toolbox'

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

  1.  Change to the directory 'SBMLToolbox/toolbox'.

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
  all subdirectories are in your Matlab path.  
  For example, at the Matlab prompt:

    >> addpath('SBMLToolbox/toolbox');
    >> addpath('SBMLToolbox/toolbox/StoreModels');
    >> addpath('SBMLToolbox/toolbox/Validate_MATLAB_SBML_Structures');
    >> addpath('SBMLToolbox/toolbox/ViewModelComponents');
    >>  etc…

  You may wish to add these commands to your Matlab startup script in
  ${HOME}/matlab/startup.m


If you have any questions or problems with the above install
procedure, please email Ben Bornstein (bornstei@caltech.edu).  In a
future release of libsbml, this procedure will be integrated with the
top-level build ('configure') script.




------------
3.  Contents
------------

toolbox

  BuildTranslate_Win32 
		which builds the TranslateSBML executable
  TranslateSBML 
		which translates a sbml file into a matlab structure
  BuildOutput_Win32 
		which builds the TranslateSBML executable
  OutputSBML('SBML_MATLAB structure') 
		which translates a sbml-matlab structure and ouputs an sbml file

 toolbox\AccessModel

  This directory contains functions that allow the user to
               derive information from a SBML Model

   NOTE: Several functions listed here have been superceded by functions
   named in line with libSBML and thus will not be in the Full release
 
 CheckValues 
       takes an SBMLModel
           provides a GUI that allows the user to view and/or edit the values
           for the initial concentration of species and parameter values
       and returns
           1) an array of values for the initial concentration of the species
           2) an array of values for the parameters

 DetermineSpeciesRoleInReaction
       takes a SBML species and  reaction
       and determines where the species takes part in the reaction


 GetAllParameters 
       takes a SBMLModel 
       and returns 
           1) an array of character names representing all parameters (both global and embedded) within the model 
           2) an array of the values of each parameter

 GetAllParametersUnique 
       takes a SBMLModel 
       and returns 
           1) an array of character names representing all parameters (both global and embedded) within the model 
               (with reaction names appended)
           2) an array of the values of each parameter

 GetGlobalParameters 
       takes a SBMLModel 
       and returns 
           1) an array of character names representing all global parameters within the model 
           2) an array of the values of each parameter

 GetParameterFromReaction 
       takes a SBMLReaction 
       and returns 
           1) an array of character names representing all parameters defined 
               within the kinetic law of the reaction 
           2) an array of the values of each parameter

 GetParameterFromReactionUnique
       takes a SBMLReaction 
       and returns 
           1) an array of character names representing all parameters defined 
               within the kinetic law of the reaction 
               (with reaction names appended)
           2) an array of the values of each parameter

 GetRateLawsFromReactions 
       takes an SBMLModel 
       and returns
             1) an array of species names
             2) an array of the character representation of the rate laws
             for each species

 GetRateLawsFromRules 
       takes an SBMLModel 
       and returns
             1) an array of species names
             2) an array of the character representation of the rate laws
             for each species from rules

 GetSpecies 
       takes a SBMLModel 
       and returns 
           1) an array of character names of all species within the model 
           2) an array of the initial concentration values of each species

 GetSpeciesAlgebraicRules 
       takes an SBMLModel 
       and returns
             1) an array of species names
             2) an array of the character representation of each algebraic
             rule the species appears in

 GetSpeciesAssignmentRules 
       takes an SBMLModel 
       and returns
             1) an array of species names
             2) an array of the character representation of the
             concentration for each species assigned by rules

 GetStoichiometryMatrix 
       takes an SBML model 
       and returns 
           1) stoichiometry matrix
           2) an array of character names of all species within the model 

 IsSpeciesInReaction
       takes an SBML species and  reaction
       and determines where the species takes part in the reaction


toolbox\AccessToSymbols
 toolbox\AccessToSymbols

 This directory provides functions that allow access to the Symbolic Math Toolbox
 
 FUNCTIONS INCLUDE:
 
 charFormula2sym
     converts a characater representation of a mathematical formula
   to a symbolic representation of that formula
   and returns 
       1) the symbolic representation of the formula as first output argument
       2) an array of the symbols used within the formula as second output
           argument
 
 CreateSymArray
    takes any symbolic expression or set of symbolic expressions
   and returns an array of the single symbolic expressions found in the input 

 GetAllParameterSymbols 
     takes a SBMLModel 
   and returns 
       1) an array of symbols representing all parameters (both global and embedded) within the model 
       2) an array of the values of each parameter
       3) an array of character names of the symbols
 
 GetAllParameterSymbolsUnique 
     takes a SBMLModel 
   and returns 
       1) an array of symbols representing all parameters 
           (both global and embedded) within the model with reaction names appended 
       2) an array of the values of each parameter
       3) an array of character names of the symbols
 
 GetDegree
     takes a symbolic polynomial and a single symbol
   and returns 
       the degree of the symbol in the polynomial

 GetEquilibrium 
     takes a SBMLModel 
   and returns 
       1) an array representing the equilibrium values of each species 
       2) a structure containing other equilibrium conditions

 GetGlobalParameterSymbols 
     takes a SBMLModel 
   and returns 
       1) an array of symbols representing all global parameters within the model 
       2) an array of the values of each parameter
       3) an array of character names of the symbols
 
 GetParameterSymbolsFromReaction 
     takes a SBMLReaction 
   and returns 
       1) an array of symbols representing all parameters defined 
               within the kinetic law of the reaction 
       2) an array of the values of each parameter
       3) an array of character names of the symbols
 
 GetParameterSymbolsFromReactionUnique 
     takes a SBMLReaction 
   and returns 
       1) an array of symbols representing all parameters defined 
               within the kinetic law of the reaction with reaction names
               appended
       2) an array of the values of each parameter
       3) an array of character names of the symbols
 
 GetSpeciesRateLaws 
     takes an SBML model 
   and returns 
       1) an array of species symbols
       2) an array of symbolic representations of the rate law for each species
 
 GetSpeciesSymbols 
     takes a SBMLModel 
   and returns 
       1) an array of symbols representing all species within the model 
       2) an array of the initial concentration values of each species
       3) an array of character names of the symbols
 
 GetStoichiometryMatrixSyms(SBMLModel) 
     takes an SBML model 
    and returns 
        1) stoichiometry matrix
        2) an array of symbols respresenting each species in same order
           as the stoichiometry matrix treats them

 PlotSelectedTimeCourse  
     takes an SBML model 
    and plots the time course of user selected species to equilibrium

 PlotTimeCourse  
     takes an SBML model 
    and plots the time course of the species to equilibrium

toolbox\Convenience

 This directory contains functions useful to the simulation of an SBML model


 FUNCTIONS INCLUDE:
   CheckValidUnitKind 
       takes a string representing a unit kind and returns 1 if it is valid 0 otherwise

   isIntegralNumber 
       takes a number n and returns 1 if it is an integer 0 otherwise (may
       of matlab type double)

   LoseWhiteSpace            
       takes an array of characters and returns the array with any white space removed

   PairBrackets              
       takes a string and returns an array of indices of each pair of brackets
       ordered from the opening bracket index

   RemoveDuplicates          
       takes any array and returns it with any duplicates removed

   SubstituteFunction 
       takes a string representation of a formula and an SBMLFunctionDefinition structure defining the formula
       and returns the formula with the function substituted




 toolbox\MATLAB_SBML_Structure_Functions

  This directory contains functions that allow the user to
               manipulate a MATLAB_SBML Model structure

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


 FUNCTIONS INCLUDE:
   AnalyseSpecies  
       takes a matlab sbml model structure and outputs a
       structure detailing the species and how they are manipulated within the
       model

   DealWithPiecewise              
       takes a string representation of a formula that contains the MathML
       piecewise function and returns an array of the three components of the 
       piecewise function which can then be written as an if else statement
 
   DisplayODEFunction             
       takes a matlab sbml model structure and a number of optional arguments 
       and can plot the results of the ode45 solver (ode15s if stiff) and output
       a comma seperated variable (CSV) file of the simulation results

   GetArgumentsFromLambdaFunction 
       takes a string representation of a formula that contains the MathML lambda function 
       and returns an array of the components of the lambda function
       which can then be used to substitute arguments where the function has been applied

   SelectSpecies                  
       takes an SBML Model, displays a GUI that allows the user to add/remove species from a list
       and returns an array of Species selected by the user

   WriteEventAssignmentFunction   
       takes a matlab sbml model structure and outputs a file defining a function 
       that assigns values following an event (for use with the event option in matlabs ode solvers)

   WriteEventHandlerFunction      
       takes a matlab sbml model structure and outputs a file defining a function 
       that handles an event (for use with the event option in matlabs ode solvers)

   WriteODEFunction               
       takes a matlab sbml model structure and outputs a file defining a function 
       for use with matlabs ode solvers


toolbox\StoreModels

 This directory contains functions to save and load SBML models
   from the data file SBML_Models.mat
   and functions to browse the data file


 FUNCTIONS INCLUDE:

   SaveSBMLModel(Model) 
       checks that the structure supplied is of the correct form
       creates "SBML_Models.mat" if the file does not already exist
       write the model to the data file as the next element

   LoadSBMLModel(input, level) 
       returns a model from "SBML_Models.mat" where
       input can be an integer relating to the number of the model within the data file
       or the Name field of the model requested
       and level is the SBML level (either 1 or 2)

   ListSBMLModels 
       returns a list of the saved models with index, level and names

   DeleteSBMLModel(input, level) 
       deletes a model from "SBML_Models.mat" where
       input can be an integer relating to the number of the model within the data file
       or the Name field of the model requested 
       and level is the SBML level (either 1 or 2)

   ViewModel(Model) 
       raises a GUI that illustrate the SBML model 'Model'

   BrowseSBML_Models 
       calls BrowseModels which enables a GUI that browses the Matlab data file SBML_Models.dat
       If an output argument is specified then a model can be loaded from the data file 
       This GUI also allows models to be deleted from the data file 

   BrowseModels(number) 
       raises a GUI that browses the data file SBML_Models.dat
       called from BrowseSBML_Models

   AlreadyExists
       raises a modal GUI that prompts user for overwrite permission for a
       model name that already exists within the SBML_Models data file


 toolbox\Validate_MATLAB_SBML_Structures
 
 isSBML_XXX(SBMLStructure, Level)
 Functions that return TRUE(1) if SBMLStructure is a structure of type XXX
 FALSE (0) if SBMLStructure is 
                           NOT a structure
                    OR     does not contain the appropriate fields to be of
                           type XXX and Level of SBML
                    OR     does not have the correct Typecode string

 Functions include

 isSBML_Model(SBMLStructure) 
   identifies the level from the model structure

 isSBML_AlgebraicRule(SBMLStructure, Level)
 isSBML_AssignmentRule(SBMLStructure, Level)
 isSBML_Compartment(SBMLStructure, Level) 
 isSBML_CompartmentVolumeRule(SBMLStructure, Level)
 isSBML_Event(SBMLStructure, Level) 
 isSBML_EventAssignment(SBMLStructure, Level) 
 isSBML_FunctionDefinition(SBMLStructure, Level) 
 isSBML_KineticLaw(SBMLStructure, Level) 
 isSBML_ModifierSpeciesReference(SBMLStructure, Level) 
 isSBML_Parameter(SBMLStructure, Level) 
 isSBML_ParameterRule(SBMLStructure, Level)
 isSBML_Reaction(SBMLStructure, Level) 
 isSBML_Rule(SBMLStructure, Level) 
 isSBML_Species(SBMLStructure, Level) 
 isSBML_SpeciesConcentrationRule(SBMLStructure, Level) 
 isSBML_SpeciesReference(SBMLStructure, Level) 
 isSBML_Unit(SBMLStructure, Level) 
 isSBML_UnitDefinition(SBMLStructure, Level) 


toolbox\ViewModelComponents
 toolbox\ViewModelComponents

 Functions to drive GUIs to view MATLAB_SBML model component structures

   ViewXXX produces a GUI to display the fields and values of component XXX

 Functions include

   ViewCompartment        
   ViewEvent              
   ViewEventAssignment    
   ViewFunctionDefinition 
   ViewKineticLaw         
   ViewParameter          
   ViewReaction           
   ViewRule               
   ViewSpecies            
   ViewSpeciesReference   
   ViewUnit               
   ViewUnitDefinition    
 


------------------------------------------
4.  Licensing, Copyrights and Distribution
------------------------------------------

The terms of redistribution for this software are stated in the file
COPYING.txt.




-------------------------------------------
  File author: S. Keating
Last Modified: 2005/05/07 
-------------------------------------------
