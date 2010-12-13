function testToolbox

disp ('Start ...');
pwd
success = 1;
m = [];
try
  disp('Reading model');
  m = TranslateSBML('test.xml');
  disp('TranslateSBML success');
catch
  success = 0;
  disp('TranslateSBML failed');
end;

if (success == 1)
  if (isempty(m))
    disp('Model not read');
    success = 0;
  else
    disp('Model read successful');
  end;
end;

if (success == 1)
  disp('Checking path ...');
  try
    isM = isSBML_Model(m);
    disp('Path success');
  catch
    disp('Path failed');
    success = 0;
  end;
end;

if (success == 1)
  disp('Checking valid model ...');
  if (isM == 1)
    disp('Valid model');
  elseif (isM == 0)
    disp('Invalid model');
    success = 0;
  else
    disp('Unexpected value in validation');
    success = 0;
  end;
end;


if (success == 1)
  try
    disp('Writing model ...');
    OutputSBML(m, 'out.xml');
    disp('OutputSBML success');
  catch
    disp('OutputSBML failed');
    success = 0;
  end;
end;

if (success == 1)
  disp('All tests passed');
else
  disp('Failed');
end;

