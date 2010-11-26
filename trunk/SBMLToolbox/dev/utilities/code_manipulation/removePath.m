function removePath()

%check we are in the right directory
files = dir();

for i= 1:length(files)
  if (strcmp(files(i).name, 'AccessModel'))
    break;
  end;
end;

if (i == length(files))
  error('Need to be in the toolbox directory');
end;

dirs_to_delete = genpath(pwd());

rmpath(dirs_to_delete);

savepath();
