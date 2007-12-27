mkdir SBMLToolbox
cd SBMLToolbox
mkdir docs
mkdir toolbox
copy C:\SBMLToolbox\AUTHORS.txt AUTHORS.txt
copy C:\SBMLToolbox\COPYING.txt COPYING.txt
copy C:\SBMLToolbox\FUNDING.txt FUNDING.txt
copy C:\SBMLToolbox\NEWS.txt NEWS.txt
copy C:\SBMLToolbox\README.txt README.txt
copy C:\SBMLToolbox\VERSION.txt VERSION.txt
copy C:\SBMLToolbox\COPYING.html COPYING.html
cd docs
copy C:\SBMLToolbox\docs\Manual_SBMLToolbox.pdf Manual_SBMLToolbox.pdf
copy C:\SBMLToolbox\docs\MATLAB_SBML_Structure.pdf MATLAB_SBML_Structure.pdf
cd ..
cd toolbox
mkdir AccessModel
cd AccessModel
mkdir Test
cd ..
mkdir AccessToSymbols
cd AccessToSymbols
mkdir Test
cd ..
mkdir Convenience
cd Convenience
mkdir Test
cd ..
mkdir MATLAB_SBML_Structure_Functions
cd MATLAB_SBML_Structure_Functions
mkdir AlgebraicRule
mkdir AssignmentRule
mkdir Compartment
mkdir CompartmentType
mkdir CompartmentVolumeRule
mkdir Constraint
mkdir Delay
mkdir Event
mkdir EventAssignment
mkdir FunctionDefinition
mkdir InitialAssignment
mkdir KineticLaw
mkdir Model
mkdir ModifierSpeciesReference
mkdir Parameter
mkdir ParameterRule
mkdir RateRule
mkdir Reaction
mkdir Rule
mkdir Species
mkdir SpeciesConcentrationRule
mkdir SpeciesReference
mkdir SpeciesType
mkdir StoichiometryMath
mkdir Test
mkdir Trigger
mkdir Unit
mkdir UnitDefinition
cd ..
mkdir Simulation
cd Simulation
mkdir Test
cd ..
mkdir StoreModels
mkdir Test
cd Test
mkdir test-data
cd ..
mkdir Validate_MATLAB_SBML_Structures
cd Validate_MATLAB_SBML_Structures
mkdir Test
cd ..
mkdir ViewModelComponents
copy C:\SBMLToolbox\src\BuildOutput_Win32.m BuildOutput_Win32.m
copy C:\SBMLToolbox\src\OutputSBML.m OutputSBML.m
copy C:\SBMLToolbox\src\OutputSBML.c OutputSBML.c
copy C:\SBMLToolbox\src\OutputSBML.mexw32 OutputSBML.mexw32
copy C:\SBMLToolbox\src\Contents.m Contents.m
copy C:\SBMLToolbox\src\install.m install.m
copy C:\SBMLToolbox\src\SBMLToolbox.m SBMLToolbox.m
copy C:\SBMLToolbox\src\make.bat make.bat
copy C:\SBMLToolbox\src\test.xml test.xml

cd C:\SBMLToolbox\src\AccessModel
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\AccessModel
copy *.fig C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\AccessModel
cd Test
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\AccessModel\Test
copy *.xml C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\AccessModel\Test
cd ..
cd ..
cd AccessToSymbols
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\AccessToSymbols
cd Test
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\AccessToSymbols\Test
copy *.xml C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\AccessToSymbols\Test
cd ..
cd ..
cd Convenience
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Convenience
cd test
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Convenience\Test
copy *.xml C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Convenience\Test
cd ..
cd ..
cd Simulation
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Simulation
copy *.fig C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Simulation
cd Test
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Simulation\Test
copy *.xml C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Simulation\Test
cd ..
cd ..
cd StoreModels
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\StoreModels
copy *.fig C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\StoreModels
cd ..
cd Test
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Test
copy *.xml C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Test
cd test-data
copy *.xml C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Test\test-data
cd ..
cd ..
cd ValidationTests
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Validate_MATLAB_SBML_Structures
cd Test
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Validate_MATLAB_SBML_Structures\Test
copy *.xml C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Validate_MATLAB_SBML_Structures\Test
cd ..
cd ..
cd ViewModelComponents
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\ViewModelComponents
copy *.fig C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\ViewModelComponents
cd ..
cd MATLAB_SBML_Structure_Functions
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions
cd AlgebraicRule
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\AlgebraicRule
cd ..
cd AssignmentRule
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\AssignmentRule
cd ..
cd Compartment
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\Compartment
cd ..
cd CompartmentType
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\CompartmentType
cd ..
cd CompartmentVolumeRule
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\CompartmentVolumeRule
cd ..
cd Constraint
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\Constraint
cd ..
cd Delay
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\Delay
cd ..
cd Event
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\Event
cd ..
cd EventAssignment
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\EventAssignment
cd ..
cd FunctionDefinition
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\FunctionDefinition
cd ..
cd InitialAssignment
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\InitialAssignment
cd ..
cd KineticLaw
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\KineticLaw
cd ..
cd Model
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\Model
cd ..
cd ModifierSpeciesReference
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\ModifierSpeciesReference
cd ..
cd Parameter
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\Parameter
cd ..
cd ParameterRule
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\ParameterRule
cd ..
cd RateRule
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\RateRule
cd ..
cd Reaction
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\Reaction
cd ..
cd Rule
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\Rule
cd ..
cd Species
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\Species
cd ..
cd SpeciesConcentrationRule
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\SpeciesConcentrationRule
cd ..
cd SpeciesReference
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\SpeciesReference
cd ..
cd SpeciesType
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\SpeciesType
cd ..
cd StoichiometryMath
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\StoichiometryMath
cd ..
cd Test
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\Test
cd ..
cd Trigger
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\Trigger
cd ..
cd Unit
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\Unit
cd ..
cd UnitDefinition
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\UnitDefinition
cd ..













