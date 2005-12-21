Notes on creating a SBMLToolbox release

1. Download and install the latest libsbml

2. The CreateRelease batch file uses C:\libsbml-2.3.4-xerces
for the win32 libraries and includes: change to reflect latest release

3. Build the matlab dlls

4. Edit inno-script to latest version

5. Running CreateRelease and then the inno script creates 
the windows installer

6. Running CreateSRCRelease creates the directory structure
that can be zipped for src release