function RunTest

cd ..;
cd AccessModel;
cd Test;
disp('Performing tests in AccessModel directory');
RunTest;
cd ..;

v = ver('symbolic');
% only run if symbolic toolbox is intalled
if (~isempty(v))
  cd ..;
  cd AccessToSymbols;
  cd Test;
  disp('Performing tests in AccessToSymbols directory');
  RunTest;
  cd ..;
end;

cd ..;
cd Convenience;
cd Test;
disp('Performing tests in Convenience directory');
RunTest;
cd ..;

cd ..;
cd MATLAB_SBML_Structure_Functions;
cd Test;
disp('Performing tests in MATLAB_SBML_Structure_Functions directory');
TestCreate;
cd ..;

cd ..;
cd Simulation;
cd Test;
disp('Performing tests in Simulation directory');
RunTest;
cd ..;

cd ..;
cd cd Validate_MATLAB_SBML_Structures;
cd Test;
disp('Performing tests in cd Validate_MATLAB_SBML_Structures directory');
RunTest;
cd ..;

cd ..;
cd Test;