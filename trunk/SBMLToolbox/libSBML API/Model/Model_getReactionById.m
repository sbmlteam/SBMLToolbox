function reaction = Model_getReactionById(SBMLModel, id)
%
%   Model_getReactionById 
%             takes  1) an SBMLModel structure 
%             and    2) a string representing the id of the reaction to be found
%
%             and returns 
%               the reaction structure with the matching id 
%               or an empty structure if no such reaction exists
%               
%       reaction = Model_getReactionById(SBMLModel, 'id')

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getReactionById(SBMLModel, id)', 'first argument must be an SBML model structure'));
elseif (~ischar(id))
    error(sprintf('%s\n%s', 'Model_getReactionById(SBMLModel, id)', 'second argument must be a string'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getReactionById(SBMLModel, id)', 'no id field in a level 1 model'));   
end;

reaction = [];

for i = 1:length(SBMLModel.reaction)
    if (strcmp(id, SBMLModel.reaction(i).id))
        reaction = SBMLModel.reaction(i);
        return;
    end;
end;