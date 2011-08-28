function writeBatchFile
% write a batch file that calls markdown on the contents.txt files
% looping thru the MATLAB_SBML_Structure_Functions dir
% and then calling markdown for each of the other directories

Objects = {'AlgebraicRule', 'AssignmentRule', 'Compartment',  'CompartmentType', ...
   'CompartmentVolumeRule',  'Constraint',  'Delay', 'Event', 'EventAssignment', ...
    'FunctionDefinition', 'InitialAssignment', 'KineticLaw', 'LocalParameter', ...
     'Model', 'ModifierSpeciesReference', 'Parameter', 'ParameterRule', ...
      'Priority', 'RateRule', 'Reaction', 'Species', 'SpeciesConcentrationRule', ...
       'SpeciesReference', 'SpeciesType', 'StoichiometryMath', 'Trigger', ...
        'Unit', 'UnitDefinition', 'Rule'};


fo = fopen('write.bat', 'w');
fprintf(fo, 'cd "C:\\SBMLToolbox\\docs\\structure-functions"\n');

for i=1: length(Objects)
  name = Objects{i};
  low = strcat(lower(name(1)), name(2:end));
  fprintf(fo, 'perl C:\\Perl64\\lib\\Markdown.pl --html4tags C:\\SBMLToolbox\\src\\');
  fprintf(fo, 'MATLAB_SBML_Structure_Functions\\%s\\contents.txt > %s.html\n', name, low);
end;

fprintf(fo, 'cd ..\n');
fprintf(fo, 'perl C:\\Perl64\\lib\\Markdown.pl --html4tags C:\\SBMLToolbox\\src\\');
fprintf(fo, 'AccessModel\\contents.txt > accessmodel.html\n');
fprintf(fo, 'perl C:\\Perl64\\lib\\Markdown.pl --html4tags C:\\SBMLToolbox\\src\\');
fprintf(fo, 'Convenience\\contents.txt > convenience.html\n');
fprintf(fo, 'perl C:\\Perl64\\lib\\Markdown.pl --html4tags C:\\SBMLToolbox\\src\\');
fprintf(fo, 'MATLAB_SBML_Structure_Functions\\contents.txt > structure.html\n');
fprintf(fo, 'perl C:\\Perl64\\lib\\Markdown.pl --html4tags C:\\SBMLToolbox\\src\\');
fprintf(fo, 'MATLAB_SBML_Structure_Functions\\structFieldnames\\contents.txt > structureFields.html\n');
fprintf(fo, 'perl C:\\Perl64\\lib\\Markdown.pl --html4tags C:\\SBMLToolbox\\src\\');
fprintf(fo, 'Validate_MATLAB_SBML_Structures\\contents.txt > validation.html\n');
fprintf(fo, 'perl C:\\Perl64\\lib\\Markdown.pl --html4tags C:\\SBMLToolbox\\src\\');
fprintf(fo, 'Simulation\\contents.txt > simulation.html\n');

fclose(fo);

