% toolbox\MATLAB_SBML_Structure_Functions\Event
%
% The functions allow users to create and work with the SBML Event structure. 
%
%======================================================================
% SBMLEvent = Event_addEventAssignment(SBMLEvent, SBMLEventAssignment)
%======================================================================
% takes
% 1. SBMLEvent; an SBML Event structure
% 2. SBMLEventAssignment; an SBML EventAssignment structure
% returns
% 1. the SBML Event structure with the SBML EventAssignment structure added
%
%=========================================================
% Event = Event_create(level(optional), version(optional)
%=========================================================
% takes
% 1. level; an integer representing an SBML level (optional)
% 2. version; an integer representing an SBML version (optional)
% returns
% 1. a MATLAB_SBML Event structure of the appropriate level and version
%
%===================================
% delay = Event_getDelay(SBMLEvent)
%===================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the SBML Delay structure
%
%==============================================================
% eventAssignment = Event_getEventAssignment(SBMLEvent, index)
%==============================================================
% takes
% 1. SBMLEvent; an SBML Event structure
% 2. index; an integer representing the index of SBML EventAssignment structure
% returns
% 1. the SBML EventAssignment structure at the indexed position
%
%=============================
% id = Event_getId(SBMLEvent)
%=============================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the value of the id attribute
%
%==============================================================
% eventAssignment = Event_getListOfEventAssignments(SBMLEvent)
%==============================================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. an array of the eventAssignment structures
%
%=====================================
% metaid = Event_getMetaid(SBMLEvent)
%=====================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the value of the metaid attribute
%
%=================================
% name = Event_getName(SBMLEvent)
%=================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the value of the name attribute
%
%===============================================
% num = Event_getNumEventAssignments(SBMLEvent)
%===============================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the number of SBML EventAssignment structures present in the Event
%
%=========================================
% priority = Event_getPriority(SBMLEvent)
%=========================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the SBML Priority structure
%
%=======================================
% sboTerm = Event_getSBOTerm(SBMLEvent)
%=======================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the value of the sboTerm attribute
%
%===========================================
% timeUnits = Event_getTimeUnits(SBMLEvent)
%===========================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the value of the timeUnits attribute
%
%=======================================
% trigger = Event_getTrigger(SBMLEvent)
%=======================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the SBML Trigger structure
%
%=========================================================================
% useValuesFromTriggerTime = Event_getUseValuesFromTriggerTime(SBMLEvent)
%=========================================================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the value of the useValuesFromTriggerTime attribute
%
%=====================================
% value = Event_isSetDelay(SBMLEvent)
%=====================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. value = 
%  - 1 if the delay structure is set
%  - 0 otherwise
%
%==================================
% value = Event_isSetId(SBMLEvent)
%==================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. value = 
%  - 1 if the id attribute is set
%  - 0 otherwise
%
%======================================
% value = Event_isSetMetaid(SBMLEvent)
%======================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. value = 
%  - 1 if the metaid attribute is set
%  - 0 otherwise
%
%====================================
% value = Event_isSetName(SBMLEvent)
%====================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. value = 
%  - 1 if the name attribute is set
%  - 0 otherwise
%
%========================================
% value = Event_isSetPriority(SBMLEvent)
%========================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. value = 
%  - 1 if the priority structure is set
%  - 0 otherwise
%
%=======================================
% value = Event_isSetSBOTerm(SBMLEvent)
%=======================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. value = 
%  - 1 if the sboTerm attribute is set
%  - 0 otherwise
%
%=========================================
% value = Event_isSetTimeUnits(SBMLEvent)
%=========================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. value = 
%  - 1 if the timeUnits attribute is set
%  - 0 otherwise
%
%=======================================
% value = Event_isSetTrigger(SBMLEvent)
%=======================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. value = 
%  - 1 if the trigger structure is set
%  - 0 otherwise
%
%==================================================
% SBMLEvent = Event_setDelay(SBMLEvent, SBMLDelay)
%==================================================
% takes
% 1. SBMLEvent; an SBML Event structure
% 2. SBMLDelay; an SBML Delay structure
% returns
% 1. the SBML Event structure with the new value for the delay field
%
%========================================
% SBMLEvent = Event_setId(SBMLEvent, id)
%========================================
% takes
% 1. SBMLEvent; an SBML Event structure
% 2. id; a string representing the id to be set
% returns
% 1. the SBML Event structure with the new value for the id attribute
%
%================================================
% SBMLEvent = Event_setMetaid(SBMLEvent, metaid)
%================================================
% takes
% 1. SBMLEvent; an SBML Event structure
% 2. metaid; a string representing the metaid to be set
% returns
% 1. the SBML Event structure with the new value for the metaid attribute
%
%============================================
% SBMLEvent = Event_setName(SBMLEvent, name)
%============================================
% takes
% 1. SBMLEvent; an SBML Event structure
% 2. name; a string representing the name to be set
% returns
% 1. the SBML Event structure with the new value for the name attribute
%
%========================================================
% SBMLEvent = Event_setPriority(SBMLEvent, SBMLPriority)
%========================================================
% takes
% 1. SBMLEvent; an SBML Event structure
% 2. SBMLPriority; an SBML Priority structure
% returns
% 1. the SBML Event structure with the new value for the priority field
%
%==================================================
% SBMLEvent = Event_setSBOTerm(SBMLEvent, sboTerm)
%==================================================
% takes
% 1. SBMLEvent; an SBML Event structure
% 2. sboTerm; an integer representing the sboTerm to be set
% returns
% 1. the SBML Event structure with the new value for the sboTerm attribute
%
%======================================================
% SBMLEvent = Event_setTimeUnits(SBMLEvent, timeUnits)
%======================================================
% takes
% 1. SBMLEvent; an SBML Event structure
% 2. timeUnits; a string representing the timeUnits to be set
% returns
% 1. the SBML Event structure with the new value for the timeUnits attribute
%
%======================================================
% SBMLEvent = Event_setTrigger(SBMLEvent, SBMLTrigger)
%======================================================
% takes
% 1. SBMLEvent; an SBML Event structure
% 2. SBMLTrigger; an SBML Trigger structure
% returns
% 1. the SBML Event structure with the new value for the trigger field
%
%====================================================================================
% SBMLEvent = Event_setUseValuesFromTriggerTime(SBMLEvent, useValuesFromTriggerTime)
%====================================================================================
% takes
% 1. SBMLEvent; an SBML Event structure
% 2. useValuesFromTriggerTime; an integer (0/1) representing the value of useValuesFromTriggerTime to be set
% returns
% 1. the SBML Event structure with the new value for the useValuesFromTriggerTime attribute
%
%=========================================
% SBMLEvent = Event_unsetDelay(SBMLEvent)
%=========================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the SBML Event structure with the delay field unset
%
%======================================
% SBMLEvent = Event_unsetId(SBMLEvent)
%======================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the SBML Event structure with the id attribute unset
%
%==========================================
% SBMLEvent = Event_unsetMetaid(SBMLEvent)
%==========================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the SBML Event structure with the metaid attribute unset
%
%========================================
% SBMLEvent = Event_unsetName(SBMLEvent)
%========================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the SBML Event structure with the name attribute unset
%
%============================================
% SBMLEvent = Event_unsetPriority(SBMLEvent)
%============================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the SBML Event structure with the priority field unset
%
%===========================================
% SBMLEvent = Event_unsetSBOTerm(SBMLEvent)
%===========================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the SBML Event structure with the sboTerm attribute unset
%
%=============================================
% SBMLEvent = Event_unsetTimeUnits(SBMLEvent)
%=============================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the SBML Event structure with the timeUnits attribute unset
%
%===========================================
% SBMLEvent = Event_unsetTrigger(SBMLEvent)
%===========================================
% takes
% 1. SBMLEvent; an SBML Event structure
% returns
% 1. the SBML Event structure with the trigger field unset
%


%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->


