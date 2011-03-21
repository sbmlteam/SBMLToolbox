function y = SolveAnalytically(SBMLModel)
% SolveAnalytically takes an SBMLModel 
% and returns 
%           1) a structure detailing each species and the resulting anaytical solution 
%
% NOTE: This function requires the MATLAB Symbolic Toolbox
%--------------------------------------------------------------------------

%
%  Filename    : SolveAnalytically.m
%  Description : % SolveAnalytically takes a SBMLModel 
% and returns   1) an array of symbols representing all parameters (both global and embedded) within the model 
%               2) an array of the values of each parameter
%               3) an array of character names of the symbols
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  $Id: ASTNode.h 8088 2008-08-21 14:32:27Z mhucka $
%  $HeadURL: https://sbml.svn.sourceforge.net/svnroot/sbml/trunk/libsbml/src/math/ASTNode.h $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->

% catch errors in input
symbolicToolboxPresent = false;
toolboxes = ver;
for i=1:length(toolboxes)
  if (strcmp(toolboxes(i).Name, 'Symbolic Math Toolbox'))
    symbolicToolboxPresent = true;
  end;
end;
if (~symbolicToolboxPresent)
  error('SolveAnalytically(SBMLModel) requires the Symbolic Math Toolbox');
end;
% check first input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('SolveAnalytically(SBMLModel)\n%s', 'first argument must be an SBMLModel structure');
end;

Species = AnalyseSpecies(SBMLModel);

% write out species changes
for i=1:length(Species)
  if (Species(i).ChangedByReaction == 1)
    for fd = 1:Model_getNumFunctionDefinitions(SBMLModel)
      newFormula = SubstituteFunction(Species(i).KineticLaw{1}, Model_getFunctionDefinition(SBMLModel, fd));
      if (~isempty(newFormula))
        Species(i).KineticLaw{1} = newFormula;
      end;
    end;
    if (Species(i).isConcentration == 1)
      eqn{i} = sprintf('D%s = %s/%s', Species(i).Name{1}, Species(i).KineticLaw{1}, Species(i).compartment);
    else
      eqn{i} = sprintf('D%s = %s', Species(i).Name{1}, Species(i).KineticLaw{1});
    end;
  elseif (Species(i).ChangedByRateRule == 1)
    for fd = 1:Model_getNumFunctionDefinitions(SBMLModel)
      newFormula = SubstituteFunction(Species(i).RateRule{1}, Model_getFunctionDefinition(SBMLModel, fd));
      if (~isempty(newFormula))
        Species(i).RateRule{1} = newFormula;
      end;
    end;
    eqn{i} = sprintf('D%s = %s', Species(i).Name{1}, Species(i).RateRule{1});
  elseif (Species(i).ChangedByAssignmentRule == 1)
    for fd = 1:Model_getNumFunctionDefinitions(SBMLModel)
      newFormula = SubstituteFunction(Species(i).AssignmentRule{1}, Model_getFunctionDefinition(SBMLModel, fd));
      if (~isempty(newFormula))
        Species(i).AssignmentRule{1} = newFormula;
      end;
    end;
    eqn{i} = sprintf('D%s = %s', Species(i).Name{1}, Differentiate(SBMLModel, Species(i).AssignmentRule{1}));
  elseif (Species(i).ConvertedToAssignRule == 1)
    for fd = 1:Model_getNumFunctionDefinitions(SBMLModel)
      newFormula = SubstituteFunction(Species(i).ConvertedRule{1}, Model_getFunctionDefinition(SBMLModel, fd));
      if (~isempty(newFormula))
        Species(i).ConvertedRule{1} = newFormula;
      end;
    end;
    eqn{i} = sprintf('D%s = %s', Species(i).Name{1}, Differentiate(SBMLModel, Species(i).ConvertedRule{1}));
  else
    eqn{i} = sprintf('D%s = 0', Species(i).Name{1});
  end;
  eqn{i} = SubstituteConstants(eqn{i}, SBMLModel);
  val{i} = sprintf('%s(0) = %g', Species(i).Name{1}, Species(i).initialValue);
end;
if (~isempty(SBMLModel.time_symbol))
  y = dsolve(eqn{1:end}, val{1:end}, SBMLModel.time_symbol);
else
  y = dsolve(eqn{1:end}, val{1:end});
end;


function newRule = Differentiate(m, rule)

species = GetSpecies(m);

r = rule;
for i=1:length(species)
  r = strrep(r, species(i), strcat(species(i), '(t)'));
end;

for i=1:length(m.compartment)
  if (m.compartment(i).constant ~= 1)
    r = strrep(r, m.compartment(i).id, strcat(m.compartment(i).id, '(t)'));
  end;
end;

for i=1:length(m.parameter)
  if (m.parameter(i).constant ~= 1)
    r = strrep(r, m.parameter(i).id, strcat(m.parameter(i).id, '(t)'));
  end;
end;

syms t;
symr = sym(r{1});
newsymr = diff(symr, t);
newRule = char(newsymr);
