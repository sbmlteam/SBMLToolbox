function varargout = BrowseSBML_Models
% varargout = BrowseSBML_Models enables a GUI that browses the MATLAB data file SBML_Models.dat
% If an output argument is specified then a model can be loaded from the data file 
% into the output argument; the close option remains disabled until the
% load has been completed
%
% If no output argument is specified then the load function is disabled
%
% This GUI also allows models to be deleted from the data file 

%  Filename    :   BrowseSBML_Models.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright 2005-2007 California Institute of Technology.
% Copyright 2002-2005 California Institute of Technology and
%                     Japan Science and Technology Corporation.
% 
% This library is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
% and also available online as http://sbml.org/software/sbmltoolbox/license.html
%----------------------------------------------------------------------- -->


% check whether file exists
%   probably want to this elsewhere
fId = fopen('SBML_Models.mat');
if (fId == -1)
    error('SBML_Models.mat not found');
else
    fclose(fId);
end;

if (nargout == 0)
    BrowseModels(0);
elseif(nargout == 1)
    varargout{1} = BrowseModels(1);
else
    error('Too many output arguments')
end;
