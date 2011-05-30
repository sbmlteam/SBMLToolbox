function subsFormula = SubstituteConstants(OriginalFormula, SBMLModel)
% SubstituteConstants 
%       takes 
%           1) a string representation of a formula 
%           2) the SBMLModel structure
%       and returns 
%           a string representing the formula with the ids of any constants
%           within the model substituted
%
%
%    EXAMPLE:
%          Consider m to be an SBMLModel containing a parameter
%               with id = 'g' and value = 3' 
%
%          subsFormula = SubstituteConstants('2 * g * S1', SBMLModel)
%           
%          subsFormula = '2 * 3 * S1'
%

%
%  Filename    : SubstituteConstants.m
%  Description :  SubstituteConstants takes 
%           1) a string representation of a formula 
%           2) the SBMLModel structure
%       and returns 
%           a string representing the formula with the ids of any constants
%           within the model substituted
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

%check arguments are appropriate

if (~ischar(OriginalFormula))
    error('SubstituteConstants(OriginalFormula, SBMLModel)\n%s', 'first argument must be a character array representing a formula');
elseif (~isSBML_Model(SBMLModel))
    error('SubstituteConstants(OriginalFormula, SBMLModel)\n%s', 'second argument must be an SBML model structure');
end;


subsFormula = OriginalFormula;

[Comp, comp_values] = GetCompartments(SBMLModel);
for i=1:length(SBMLModel.compartment)
  if (SBMLModel.SBML_level == 1)
    if (~isnan(comp_values(i)))
      subsFormula = strrep(subsFormula, SBMLModel.compartment(i).name, sprintf('%g', comp_values(i)));
    end;    
  elseif (SBMLModel.compartment(i).constant == 1)
    if (~isnan(comp_values(i)))
      subsFormula = strrep(subsFormula, SBMLModel.compartment(i).id, sprintf('%g', comp_values(i)));
    end;
  end;
end;

[Param, param_values] = GetGlobalParameters(SBMLModel);
for i=1:length(SBMLModel.parameter)
  if (SBMLModel.SBML_level == 1)
    if (~isnan(param_values(i)))
      subsFormula = strrep(subsFormula, SBMLModel.parameter(i).name, sprintf('%g', param_values(i)));
    end;
  elseif (SBMLModel.parameter(i).constant == 1)
    if (~isnan(param_values(i)))
      subsFormula = strrep(subsFormula, SBMLModel.parameter(i).id, sprintf('%g', param_values(i)));
    end;
  end;
end;

[Species, species_values] = GetSpecies(SBMLModel);
for i=1:length(SBMLModel.species)
  if (SBMLModel.SBML_level > 1 && SBMLModel.species(i).constant == 1)
    if (~isnan(species_values(i)))
      subsFormula = strrep(subsFormula, SBMLModel.species(i).id, sprintf('%g', species_values(i)));
    end;
  end;
end;
