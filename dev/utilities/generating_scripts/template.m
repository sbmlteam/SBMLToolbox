if (Level == 1) 
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'type', 'formula', ...
      'variable', 'species', 'compartment', 'name', 'units'};
    nNumberFields = 10;
elseif (Level == 2)
    if (Version == 1)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation','formula', ...
          'variable', 'species', 'compartment', 'name', 'units'};
        nNumberFields = 10;
    elseif (Version == 2)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'sboTerm', ...
          'formula', 'variable', 'species', 'compartment', 'name', 'units'};
        nNumberFields = 11;
    elseif (Version == 3)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'sboTerm', ...
          'formula', 'variable', 'species', 'compartment', 'name', 'units'};
        nNumberFields = 11;
    elseif (Version == 4)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'sboTerm', ...
          'formula', 'variable', 'species', 'compartment', 'name', 'units'};
        nNumberFields = 11;
    end;
elseif (Level == 3)
    if (Version == 1)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'sboTerm', ...
          'formula', 'variable', 'species', 'compartment', 'name', 'units'};
        nNumberFields = 11;
    end;
end;
