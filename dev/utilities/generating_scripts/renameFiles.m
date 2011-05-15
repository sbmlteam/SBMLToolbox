function renameFiles

caps = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

files = dir;

for i = 1:length(files)
  if (files(i).isdir == 0)
    oldname = files(i).name;
    start = ismember(oldname(1), caps);
    if start == 1
      writeFile(oldname);     
    end;   
  end;
end;

function writeFile(oldname)

newname = strcat(lower(oldname(1)), oldname(2:end));

fold = fopen(oldname, 'r');
ftemp = fopen('temp.m', 'w');

oldn = oldname(1:end-2);
newn = newname(1:end-2);

line = fgetl(fold);

newline = strrep(line, oldn, newn);

fprintf(ftemp, '%s\n', newline);

while ~feof(fold)
  fprintf(ftemp, '%s\n', fgetl(fold));
end;

fclose(fold);
fclose(ftemp);

delete(oldname);

ftemp = fopen('temp.m', 'r');
fnew = fopen(newname, 'w');


while ~feof(fold)
  fprintf(ftemp, '%s\n', fgetl(fold));
end;

fclose(fnew);
fclose(ftemp);

delete('temp.m');

