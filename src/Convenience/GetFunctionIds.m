function FunctionIds = GetFunctionIds(SBMLModel)

%-------------------------------------------------------------------
% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('GetFunctionIds(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;
   
FunctionIds = {};
if (SBMLModel.SBML_level == 2)
    for i = 1:length(SBMLModel.functionDefinition)
        FunctionIds{i} = SBMLModel.functionDefinition(i).id;
    end;
end;

