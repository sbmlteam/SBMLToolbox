function constant = Parameter_getConstant(SBMLParameter)
%
%   Parameter_getConstant 
%             takes an SBMLParameter structure 
%
%             and returns 
%               the constant of the parameter as an integer
%
%       constant = Parameter_getConstant(SBMLParameter)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_getConstant(SBMLParameter)', 'argument must be an SBML parameter structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Parameter_getConstant(SBMLParameter)', 'no constant field in a level 1 model'));    
end;

constant = SBMLParameter.constant;
