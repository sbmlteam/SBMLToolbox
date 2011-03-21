function varargout = GetParameterSymbolsFromReaction(SBMLReaction)
% GetParameterSymbolsFromReaction takes an SBMLReaction 
% and returns 
%           1) an array of symbols representing all parameters defined 
%               within the kinetic law of the reaction 
%           2) an array of the values of each parameter
%           3) an array of character names of the symbols
%
% NOTE: if the values are not set then the value NaN is used

%--------------------------------------------------------------------------
%
%  Filename    : GetParameterSymbolsFromReaction.m
%  Description : GetParameterSymbolsFromReaction takes a SBMLReaction 
% and returns   1) an array of symbols representing all parameters defined 
%               within the kinetic law of the reaction 
%               2) an array of the values of each parameter
%               3) an array of character names of the symbols
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
%  Revision    : $Id$
%  Source      : $Source $
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

% check input is an SBML reaction and determine level
Level = 1;
if (~isSBML_Reaction(SBMLReaction, 1))
    Level = 2;
    if(~isSBML_Reaction(SBMLReaction, 2))
        Version = 2;
        if (~isSBML_Reaction(SBMLReaction, 2, 2))
            SBMLVersion = 3;
            if (~isSBML_Reaction(SBMLReaction, 2, 3))
        error('GetParameterSymbolsFromReaction(SBMLReaction)\n%s', 'input must be an SBMLReaction structure');
            end;
        end;
    end;
end;

%------------------------------------------------------------
% determine the number of parameters within the reaction

% catch case with no kinetic law
if (isempty(SBMLReaction.kineticLaw))
    NumParams = 0;
else
    NumParams = length(SBMLReaction.kineticLaw.parameter);
end;

%------------------------------------------------------------
% loop through the list of parameters
for i = 1:NumParams
    
    %determine the name or id of the parameter
    if (Level == 1)
        name = SBMLReaction.kineticLaw.parameter(i).name;
    else
        if (isempty(SBMLReaction.kineticLaw.parameter(i).id))
            name = SBMLReaction.kineticLaw.parameter(i).name;
        else
            name = SBMLReaction.kineticLaw.parameter(i).id;
        end;
    end;
    
    % create a symbol from the name
    % save into an array of symbols
    % and array of the character names
    SymbolArray(i) = sym(name);
    
    CharArray{i} = name;
    
    % put the value into the array
    Values(i) = SBMLReaction.kineticLaw.parameter(i).value;
    
end;

%--------------------------------------------------------------------------
% assign output

if (NumParams ~= 0)
    varargout{1} = SymbolArray;
    varargout{2} = Values;
    varargout{3} = CharArray;
else
    varargout{1} = [];
    varargout{2} = [];
    varargout{3} = [];
end;
