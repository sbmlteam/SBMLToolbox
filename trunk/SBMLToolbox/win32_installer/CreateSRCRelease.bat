mkdir SBMLToolbox_src
cd SBMLToolbox_src
cp C:\SBMLToolbox\AUTHORS.txt AUTHORS.txt
cp C:\SBMLToolbox\COPYING.txt COPYING.txt
cp C:\SBMLToolbox\FUNDING.txt FUNDING.txt
cp C:\SBMLToolbox\NEWS.txt NEWS.txt
cp C:\SBMLToolbox\README.txt README.txt
cp C:\SBMLToolbox\VERSION.txt VERSION.txt
cp C:\SBMLToolbox\COPYING.html COPYING.html
mkdir docs
mkdir toolbox
mkdir win32
cd docs
cp C:\SBMLToolbox\docs\Manual_SBMLToolbox.pdf Manual_SBMLToolbox.pdf
cp C:\SBMLToolbox\docs\MATLAB_SBML_Structure.pdf MATLAB_SBML_Structure.pdf
cd ..
cd win32
mkdir bin
mkdir include
cd bin
cp C:\libsbml-2.3.4-xerces\win32\bin\libsbml.dll libsbml.dll
cp C:\libsbml-2.3.4-xerces\win32\bin\libsbmlD.dll libsbmlD.dll
cp C:\libsbml-2.3.4-xerces\win32\bin\libsbml.lib libsbml.lib
cp C:\libsbml-2.3.4-xerces\win32\bin\libsbmlD.lib libsbmlD.lib
cp C:\libsbml-2.3.4-xerces\win32\bin\xerces-c_2_5_0.dll xerces-c_2_5_0.dll
cp C:\libsbml-2.3.4-xerces\win32\bin\xerces-c_2_5_0D.dll xerces-c_2_5_0D.dll
cp C:\libsbml-2.3.4-xerces\win32\bin\xerces-c_2.lib xerces-c_2.lib
cp C:\libsbml-2.3.4-xerces\win32\bin\xerces-c_2D.lib xerces-c_2D.lib
cd ..
cd include
mkdir sbml
cd sbml
mkdir common
mkdir math
mkdir util
mkdir validator
mkdir xml
cd C:\libsbml-2.3.4-xerces\win32\include\sbml
cp * C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\win32\include\sbml
cd common
cp * C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\win32\include\sbml\common
cd ..
cd math
cp * C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\win32\include\sbml\math
cd ..
cd util
cp * C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\win32\include\sbml\util
cd ..
cd validator
cp * C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\win32\include\sbml\validator
cd ..
cd xml
cp * C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\win32\include\sbml\xml
cd C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src
cd toolbox
mkdir AccessModel
cd AccessModel
mkdir test
cd..
mkdir AccessToSymbols
cd AccessToSymbols
mkdir test
cd..
mkdir Convenience
cd Convenience
mkdir test
cd..
mkdir MATLAB_SBML_Structure_Functions
cd MATLAB_SBML_Structure_Functions
mkdir AlgebraicRule
mkdir AssignmentRule
mkdir Compartment
mkdir CompartmentVolumeRule
mkdir Event
mkdir EventAssignment
mkdir FunctionDefinition
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
mkdir Unit
mkdir UnitDefinition
cd ..
mkdir Simulation
cd Simulation
mkdir test
cd..
mkdir StoreModels
mkdir test
cd test
mkdir test-data
cd ..
mkdir Validate_MATLAB_SBML_Structures
mkdir ViewModelComponents
cp C:\libsbml\src\bindings\matlab\TranslateSBML.m TranslateSBML.m
cp C:\libsbml\src\bindings\matlab\TranslateSBML.c TranslateSBML.c
cp C:\libsbml\src\bindings\matlab\CheckAndConvert.m CheckAndConvert.m
cp C:\SBMLToolbox_cvs\src\BuildOutput_Win32_src.m BuildOutput_Win32.m
cp C:\SBMLToolbox_cvs\src\BuildTranslate_Win32_src.m BuildTranslate_Win32.m
cp C:\SBMLToolbox_cvs\src\BuildRead_Win32_src.m BuildRead_Win32.m
cp C:\SBMLToolbox_cvs\src\OutputSBML.m OutputSBML.m
cp C:\SBMLToolbox_cvs\src\OutputSBML.c OutputSBML.c
cp C:\SBMLToolbox_cvs\src\ReadAndValidateSBML.m ReadAndValidateSBML.m
cp C:\SBMLToolbox_cvs\src\ReadAndValidateSBML.c ReadAndValidateSBML.c
cp C:\SBMLToolbox_cvs\src\Makefile Makefile
cp C:\SBMLToolbox_cvs\src\Contents.m Contents.m
cp C:\SBMLToolbox_cvs\src\install.m install.m
cp C:\SBMLToolbox_cvs\src\SBMLToolbox.m SBMLToolbox.m
cp C:\SBMLToolbox_cvs\src\make.bat make.bat
cp C:\SBMLToolbox_cvs\src\test.xml test.xml
rem test files
cd C:\libsbml\src\bindings\matlab\test
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\test
cd test-data
cp *.xml C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\test\test-data
cd C:\SBMLToolbox_cvs\src\Test
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\test
cd C:\SBMLToolbox_cvs\src\AccessModel
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\AccessModel
cp *.fig C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\AccessModel
cd Test
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\AccessModel\test
cp *.xml C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\AccessModel\test
cd ..
cd ..
cd AccessToSymbols
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\AccessToSymbols
cd Test
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\AccessToSymbols\test
cp *.xml C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\AccessToSymbols\test
cd ..
cd ..
cd Convenience
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\Convenience
cd Test
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\Convenience\test
cp *.xml C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\Convenience\test
cd ..
cd ..
cd Simulation
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\Simulation
cp *.fig C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\Simulation
cd Test
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\Simulation\test
cp *.xml C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\Simulation\test
cd ..
cd ..
cd StoreModels
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\StoreModels
cp *.fig C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\StoreModels
cd ..
cd ValidationTests
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\Validate_MATLAB_SBML_Structures
cd ..
cd ViewModelComponents
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\ViewModelComponents
cp *.fig C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\ViewModelComponents
cd ..
cd ..
cd libSBML API
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions
cd AlgebraicRule
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\AlgebraicRule
cd ..
cd AssignmentRule
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\AssignmentRule
cd ..
cd Compartment
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\Compartment
cd ..
cd CompartmentVolumeRule
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\CompartmentVolumeRule
cd ..
cd Event
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\Event
cd ..
cd EventAssignment
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\EventAssignment
cd ..
cd FunctionDefinition
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\FunctionDefinition
cd ..
cd KineticLaw
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\KineticLaw
cd ..
cd Model
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\Model
cd ..
cd ModifierSpeciesReference
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\ModifierSpeciesReference
cd ..
cd Parameter
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\Parameter
cd ..
cd ParameterRule
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\ParameterRule
cd ..
cd RateRule
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\RateRule
cd ..
cd Reaction
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\Reaction
cd ..
cd Rule
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\Rule
cd ..
cd Species
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\Species
cd ..
cd SpeciesConcentrationRule
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\SpeciesConcentrationRule
cd ..
cd SpeciesReference
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\SpeciesReference
cd ..
cd Unit
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\Unit
cd ..
cd UnitDefinition
cp *.m C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox_src\toolbox\MATLAB_SBML_Structure_Functions\UnitDefinition
cd ..













