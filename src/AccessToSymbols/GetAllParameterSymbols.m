function varargout = GetAllParameterSymbols(SBMLModel)
% GetAllParameterSymbols takes a SBMLModel 
% and returns 
%           1) an array of symbols representing all parameters (both global and embedded) within the model 
%           2) an array of the values of each parameter
%           3) an array of character names of the symbols
%
% NOTE: if the values are not set then the value -1 is used
%--------------------------------------------------------------------------

%
%  Filename    : GetAllParameterSymbols.m
%  Description : % GetAllParameterSymbols takes a SBMLModel 
% and returns   1) an array of symbols representing all parameters (both global and embedded) within the model 
%               2) an array of the values of each parameter
%               3) an array of character names of the symbols
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
%  Revision    : $Id$
%  Source      : $Source $
%
%  Copyright 2003 California Institute of Technology, the Japan Science
%  and Technology Corporation, and the University of Hertfordshire
%
%  This library is free software; you can redistribute it and/or modify it
%  under the terms of the GNU Lesser General Public License as published
%  by the Free Software Foundation; either version 2.1 of the License, or
%  any later version.
%
%  This library is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%  documentation provided hereunder is on an "as is" basis, and the
%  California Institute of Technology, the Japan Science and Technology
%  Corporation, and the University of Hertfordshire have no obligations to
%  provide maintenance, support, updates, enhancements or modifications.  In
%  no event shall the California Institute of Technology, the Japan Science
%  and Technology Corporation or the University of Hertfordshire be liable
%  to any party for direct, indirect, special, incidental or consequential
%  damages, including lost profits, arising out of the use of this software
%  and its documentation, even if the California Institute of Technology
%  and/or Japan Science and Technology Corporation and/or University of
%  Hertfordshire have been advised of the possibility of such damage.  See
%  the GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with this library; if not, write to the Free Software Foundation,
%  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%
%  The original code contained here was initially developed by:
%
%      Sarah Keating
%      Science and Technology Research Centre
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):
%

% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('GetAllParameterSymbols(SBMLModel)\n%s', 'input must be an SBMLModel structure');
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
    [Symbol, Value, Char] = GetParameterSymbolsFromReaction(SBMLModel.reaction(i));
    
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
