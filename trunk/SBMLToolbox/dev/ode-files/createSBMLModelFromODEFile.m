function SBML = createSBMLModelFromODEFile(filename)

% hard code level and version
level = 3;
version = 1;

model = parseODEFile(filename);

% check that the model structure has all the information needed
if ~isfield(model, 'name') || ~isfield(model, 'xdotFuncs')
  reportProblem('ode function was not found');
elseif ~isfield(model, 'numVariables')
  reportProblem('number of variables was not found');
elseif ~isfield(model, 'initConds')
  reportProblem('initial conditions were not found');
elseif ~isfield(model, 'constantNames') || ~isfield(model, 'constantValues')
  reportProblem('constants were not found');
end;

SBML = Model_create(level, version);

for i = 1:length(model.constantNames)
  SBML = Model_createParameter(SBML);
  SBML.parameter(i) = Parameter_setId(SBML.parameter(i), model.constantNames{i});
  SBML.parameter(i) = Parameter_setValue(SBML.parameter(i), model.constantValues{i});
  SBML.parameter(i) = Parameter_setConstant(SBML.parameter(i),1);
end;

index = length(SBML.parameter);

for i = 1+index:model.numVariables+index
  SBML = Model_createParameter(SBML);
  SBML.parameter(i) = Parameter_setId(SBML.parameter(i), ...
                                      strcat(model.name, '_',num2str(i-index)));
  SBML.parameter(i) = Parameter_setValue(SBML.parameter(i), ...
                                      model.initConds(i-index));
  SBML.parameter(i) = Parameter_setConstant(SBML.parameter(i),0);
end;
 
for i = 1:model.numVariables
  RR = RateRule_create(level, version);
  RR = RateRule_setVariable(RR, strcat(model.name, '_',num2str(i)));
  RR = RateRule_setFormula(RR, model.xdotFuncs{i});
  SBML = Model_addRule(SBML, RR); 
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function reportProblem(problem)

error('%s\n%s%s\n%s\n%s\n%s\n%s', problem, 'the m file containing the odes must be tagged ', ...
  'with the following tags:', '% SBML - begin init conds', ...
  '% SBML - begin constants', '% SBML - begin ode declaration', ...
  '% SBML - begin ode function');



