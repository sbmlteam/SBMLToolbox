function SBMLParameterRule = ParameterRule_setName(SBMLParameterRule, name)
%
%   ParameterRule_setName 
%             takes  1) an SBMLParameterRule structure 
%             and    2) a string representing the name to be set
%
%             and returns 
%               the parameterRule with the name set
%
%       SBMLParameterRule = ParameterRule_setName(SBMLParameterRule, 'name')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_ParameterRule(SBMLParameterRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_ParameterRule(SBMLParameterRule, sbmlLevel))
    error(sprintf('%s\n%s', 'ParameterRule_setName(SBMLParameterRule, name)', 'first argument must be an SBML parameterRule structure'));
elseif (~ischar(name))
    error(sprintf('ParameterRule_setName(SBMLParameterRule, name)\n%s', 'second argument must be a string representing the name of the parameterRule'));
end;

SBMLParameterRule.name = name;
