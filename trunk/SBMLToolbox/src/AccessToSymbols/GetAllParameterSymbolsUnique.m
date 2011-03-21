function varargout = GetAllParameterSymbolsUnique(SBMLModel)
% GetAllParameterSymbolsUnique takes an SBMLModel 
% and returns 
%           1) an array of symbols representing all parameters (both global
%           and embedded) within the model with reaction names appended
%           2) an array of the values of each parameter
%           3) an array of character names of the symbols
%
% NOTE: if the values are not set then the value NaN is used
%--------------------------------------------------------------------------

%
%  Filename    : GetAllParameterSymbolsUnique.m
%  Description : % GetAllParameterSymbolsUnique takes a SBMLModel 
%       and returns   1) an array of symbols representing all parameters (both
%                           global and embedded) within the model with reaction names appended
%                     2) an array of the values of each parameter
%                     3) an array of character names of the symbols
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

% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('GetAllParameterSymbolsUnique(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%------------------------------------------------------------
% get the global parameters
[ParamSyms, ParamValues, ParamChar] = GetGlobalParameterSymbols(SBMLModel);

% get number of parameters
NumParams = length(ParamSyms);
%------------------------------------------------------------
% get the number of reactions within the model
NumReactions = length(SBMLModel.reaction);

%------------------------------------------------------------
% loop through the list of reactions
for i = 1:NumReactions
    
    % get parameters within each reaction
    [Symbol, Value, Char] = GetParameterSymbolsFromReactionUnique(SBMLModel.reaction(i));
    
    % catch case where ParamSyms is empty at this stage
    if (NumParams == 0)
        ParamSyms = sym(ParamSyms);
    end;
    
    % add to existing arrays
    for j = 1:length(Symbol)
        NumParams = NumParams + 1;
        ParamSyms(NumParams) = Symbol(j);
        ParamValues(NumParams) = Value(j);
        ParamChar{NumParams} = Char{j};
    end;
    
end;

%--------------------------------------------------------------------------
% assign output

varargout{1} = ParamSyms;
varargout{2} = ParamValues;
varargout{3} = ParamChar;
