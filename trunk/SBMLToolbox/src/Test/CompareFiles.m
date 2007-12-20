function y = CompareFiles(file1, file2)

fid1 = fopen(file1);
fid2 = fopen(file2);
y = 1;
while (~feof(fid1) || ~feof(fid2))
  line1 = fgetl(fid1);
  line2 = fgetl(fid2);

  if (~strcmp(line1, line2))
    disp(sprintf('%s is Not equal to %s', line1, line2));
     y = 0;
     return;
  end;
end;
