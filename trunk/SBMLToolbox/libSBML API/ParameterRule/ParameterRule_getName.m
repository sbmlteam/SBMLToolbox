function name = ParameterRule_getName(SBMLParameterRule)
%
%   ParameterRule_getName 
%             takes an SBMLParameterRule structure 
%
%             and returns 
%               the name of the parameterRule as a string
%
%       name = ParameterRule_getName(SBMLParameterRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_ParameterRule(SBMLParameterRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_ParameterRule(SBMLParameterRule, sbmlLevel))
    error(sprintf('%s\n%s', 'ParameterRule_getName(SBMLParameterRule)', 'argument must be an SBML parameterRule structure'));
end;

name = SBMLParameterRule.name;
