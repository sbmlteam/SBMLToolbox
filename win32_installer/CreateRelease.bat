rmdir /S SBMLToolbox

mkdir SBMLToolbox
cd SBMLToolbox

copy C:\SBMLToolbox\AUTHORS.txt AUTHORS.txt
copy C:\SBMLToolbox\COPYING.txt COPYING.txt
copy C:\SBMLToolbox\FUNDING.txt FUNDING.txt
copy C:\SBMLToolbox\NEWS.txt NEWS.txt
copy C:\SBMLToolbox\README.txt README.txt
copy C:\SBMLToolbox\VERSION.txt VERSION.txt
copy C:\SBMLToolbox\COPYING.html COPYING.html
copy C:\SBMLToolbox\LICENSE.txt LICENSE.txt
copy C:\SBMLToolbox\LICENSE.html LICENSE.html

mkdir docs
mkdir toolbox


cd docs
mkdir structure
mkdir structure-functions

copy C:\SBMLToolbox\docs\*.html
copy C:\SBMLToolbox\docs\style.css style.css

cd structure
copy C:\SBMLToolbox\docs\structure\*.html

cd ..
cd structure-functions
copy C:\SBMLToolbox\docs\structure-functions\*.html

cd ..
cd ..

cd toolbox

mkdir AccessModel
cd AccessModel
mkdir Test
cd ..

mkdir Convenience
cd Convenience
mkdir Test
cd ..

mkdir MATLAB_SBML_Structure_Functions
cd MATLAB_SBML_Structure_Functions
mkdir structFieldnames
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
mkdir LocalParameter
mkdir Model
mkdir ModifierSpeciesReference
mkdir Parameter
mkdir ParameterRule
mkdir Priority
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

mkdir Validate_MATLAB_SBML_Structures
cd Validate_MATLAB_SBML_Structures
mkdir Test
cd ..

mkdir Test
cd Test
mkdir test-data
cd ..

rem top level files

copy C:\SBMLToolbox\src\install.m install.m
copy C:\SBMLToolbox\src\Contents.m Contents.m
copy C:\SBMLToolbox\src\install.m install.m
copy C:\SBMLToolbox\src\SBMLToolbox.m SBMLToolbox.m
copy C:\SBMLToolbox\src\test.xml test.xml

cd C:\SBMLToolbox\src\AccessModel
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\AccessModel
cd Test
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\AccessModel\Test

cd ..
cd ..
cd Convenience
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Convenience
cd test
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Convenience\Test

cd ..
cd ..
cd Simulation
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Simulation
cd Test
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Simulation\Test

cd ..
cd ..
cd Test
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Test
cd test-data
copy *.xml C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Test\test-data

cd ..
cd ..
cd Validate_MATLAB_SBML_Structures
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Validate_MATLAB_SBML_Structures
cd Test
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\Validate_MATLAB_SBML_Structures\Test


cd ..
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
cd Priority
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\Priority
cd ..
cd structFieldnames
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\structFieldnames
cd ..
cd LocalParameter
copy *.m C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\MATLAB_SBML_Structure_Functions\LocalParameter
cd ..













