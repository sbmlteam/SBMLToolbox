function value = Substitute(original_formula, model)
% Substitute 
%       takes 
%           1) a string representation of a formula 
%           2) the SBMLModel structure
%       and returns 
%           the value calculated when all variables are substituted
%
%
%   EXAMPLE:
%           m = SBMLModel with species
%               with id = 'g' and initialConcentration = 3' 
%
%           value = Substitute('g*2', m)
%           
%                   = 6

%  Filename    :   Substitute.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   11-Feb-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright 2005-2007 California Institute of Technology.
% Copyright 2002-2005 California Institute of Technology and
%                     Japan Science and Technology Corporation.
% 
% This library is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
% and also available online as http://sbml.org/software/sbmltoolbox/license.html
%----------------------------------------------------------------------- -->
% This function was radically improved by Pieter Pareit

% handle easy case
value = str2double(original_formula);
if ~isnan(value)
    return;
end

% put everything in MATLAB and evaluate the formule
% (I'm not sure if all cases are handled, for instance if size is not set
% of compartment, should then be the volume taken?)
[Species, speciesValues] = GetSpecies(model);
[Parameters, paramValues] = GetAllParameters(model);
[Compartments, compValues] = GetCompartments(model);

if (model.SBML_level > 1 && ~isempty(model.time_symbol))
    assert(exist(model.time_symbol,'var')==false);
    assignin('caller',model.time_symbol,0);
end

for i = 1:length(Species)
    assert(exist(Species{i},'var')==false);
    assignin('caller',Species{i}, speciesValues(i));
end;
for i = 1:length(Parameters)
    assert(exist(Parameters{i},'var')==false);
    assignin('caller',Parameters{i}, paramValues(i));
end;
for i = 1:length(Compartments)
    assert(exist(Compartments{i},'var')==false);
    assignin('caller',Compartments{i}, compValues(i));
end;

% this replaces all rules in the original formula
formula = original_formula;
rule_applied = 1;
iterations_left = length(model.rule) + 1;
while rule_applied > 0 && iterations_left > 0
    rule_applied = 0;
    for rule = model.rule
        str = formula;
        exp = strcat('\<',rule.variable,'\>');
        repstr = rule.formula;
        formula = regexprep(str,exp,repstr);
        rule_applied = rule_applied + strcmp(str, formula)==false;
    end
    iterations_left = iterations_left - 1;
end
assert(rule_applied == 0, ...
    'Substitute(): Cyclic dependency of rules dedected');

try
    value = evalin('caller',formula);
catch
    error('Substitute(): Ill formed formula');
end

end


