function FunctionDefinition = FunctionDefinition_create
%
%   FunctionDefinition_create 
%             returns 
%               a functionDefinition structure
%
%       FunctionDefinition = FunctionDefinition_create

%default level = 2
sbmlLevel = 2;
if (nargin > 0)
    error(sprintf('%s\n%s\n%s', 'FunctionDefinition_create(sbmlLevel)', 'requires no arguments', 'SEE help FunctionDefinition_create'));
end;

SBMLfieldnames = {'typecode', 'notes', 'annotation', 'id', 'name', 'math'};
Values = {'SBML_FUNCTION_DEFINITION', '', '', '', '', ''};

FunctionDefinition = cell2struct(Values, SBMLfieldnames, 2);