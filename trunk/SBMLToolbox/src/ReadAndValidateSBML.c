/**
* Filename    : ReadAndValidateSBML.c
* Description : MATLAB code for translating SBML document into MATLAB structure
* Author(s)   : SBML Team <sbml-team@caltech.edu>
* Organization: University of Hertfordshire STRC
* Created     : 2005-11-10
* Revision    : $Id$
* Source      : $Source$
*
* Copyright 2003 California Institute of Technology, the Japan Science
* and Technology Corporation, and the University of Hertfordshire
*
* This library is free software; you can redistribute it and/or modify it
* under the terms of the GNU Lesser General Public License as published
* by the Free Software Foundation; either version 2.1 of the License, or
* any later version.
*
* This library is distributed in the hope that it will be useful, but
* WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
* MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
* documentation provided hereunder is on an "as is" basis, and the
* California Institute of Technology, the Japan Science and Technology
* Corporation, and the University of Hertfordshire have no obligations to
* provide maintenance, support, updates, enhancements or modifications.  In
* no event shall the California Institute of Technology, the Japan Science
* and Technology Corporation or the University of Hertfordshire be liable
* to any party for direct, indirect, special, incidental or consequential
* damages, including lost profits, arising out of the use of this software
* and its documentation, even if the California Institute of Technology
* and/or Japan Science and Technology Corporation and/or University of
* Hertfordshire have been advised of the possibility of such damage.  See
* the GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this library; if not, write to the Free Software Foundation,
* Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
*
* The original code contained here was initially developed by:
*
*     Sarah Keating
*     Science and Technology Research Centre
*     University of Hertfordshire
*     Hatfield, AL10 9AB
*     United Kingdom
*
*     http://www.sbml.org
*     mailto:sbml-team@caltech.edu
*
* Contributor(s): Ben Bornstein
*/


#include <stdio.h>
#include <string.h>

#include <mex.h>
#include <matrix.h>

#include "sbml/SBMLReader.h"
#include "sbml/SBMLTypes.h"
#include "xml/ParseMessage.h"
#include "util/util.h"


void GetUnitDefinition     (Model_t *, unsigned int, unsigned int);
void GetCompartment        (Model_t *, unsigned int, unsigned int);
void GetParameter          (Model_t *, unsigned int, unsigned int);
void GetReaction           (Model_t *, unsigned int, unsigned int);
void GetSpecies            (Model_t *, unsigned int, unsigned int);
void GetRule           (Model_t *, unsigned int, unsigned int);
void GetFunctionDefinition (Model_t *, unsigned int, unsigned int);
void GetEvent              (Model_t *, unsigned int, unsigned int);

void GetUnit (UnitDefinition_t *, unsigned int, unsigned int);

void GetReactants  (Reaction_t *, unsigned int, unsigned int);
void GetProducts   (Reaction_t *, unsigned int, unsigned int);
void GetKineticLaw (Reaction_t *, unsigned int, unsigned int);
void GetModifier   (Reaction_t *, unsigned int, unsigned int);

void GetKineticLawParameters (KineticLaw_t *, unsigned int, unsigned int);

void GetEventAssignment (Event_t *, unsigned int, unsigned int);

mxArray * CreateIntScalar (int);
char    * TypecodeToChar  (SBMLTypeCode_t);

static mxArray * mxSpeciesReturn             = NULL;
static mxArray * mxCompartReturn             = NULL;
static mxArray * mxParameterReturn           = NULL;
static mxArray * mxUnitReturn                = NULL;
static mxArray * mxUnitDefReturn             = NULL;
static mxArray * mxReactionReturn            = NULL;
static mxArray * mxReactantReturn            = NULL;
static mxArray * mxProductReturn             = NULL;
static mxArray * mxKineticLawReturn          = NULL;
static mxArray * mxKineticLawParameterReturn = NULL;
static mxArray * mxListRuleReturn            = NULL;
static mxArray * mxFunctionDefReturn         = NULL;
static mxArray * mxEventReturn               = NULL;
static mxArray * mxModifierReturn            = NULL;
static mxArray * mxEventAssignReturn         = NULL;

static mxArray * mxCSymbolTime               = NULL;

/**
* NAME:        mexFunction
*
* PARAMETERS:  int     nlhs     -  number of output arguments  
*              mxArray *plhs[]  -  output arguments
*              int     nrhs     -  number of input arguments
*              mxArray *prhs[]  -  input arguments
*
* RETURNS:    
*
* FUNCTION:    MATLAB standard dll export function
*              any returns are made through the mxArray * prhs
*/
void
mexFunction (int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  /* variables */
  char *pacFilename, *pacTempString1, *pacTempString2;
  int nBufferLen, nStatus, nBuflen;
  FILE *fp;
  mxArray * mxFilename[2], * mxExt[1];

  int nNoFields_l1v1 = 12;
  int nNoFields_l2v1 = 16;

  const char *field_names_l1v1[] =
  {
    "typecode",
    "notes",
    "annotation",
    "SBML_level",
    "SBML_version",
    "name",
    "unitDefinition",
    "compartment",
    "species",
    "parameter",
    "rule",
    "reaction"
  };

  const char *field_names_l2v1[] =
  {
    "typecode",
    "notes",
    "annotation",
    "SBML_level",
    "SBML_version",
    "name",
    "id",
    "functionDefinition",
    "unitDefinition",
    "compartment",
    "species",
    "parameter",
    "rule",
    "reaction",
    "event",
    "time_symbol"
  };

  int dims[2] = {1, 1};

  SBMLDocument_t *sbmlDocument;
  Model_t *sbmlModel;
  const char * pacName;
  const char * pacId = NULL;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacTypecode;
  unsigned int unSBMLLevel;
  unsigned int unSBMLVersion;

  unsigned int errors = 0;
  mxArray * mxErrors[1];
  char * pacErrors, * pacError;
  unsigned int i;

  mxArray *mxPrompt[2], *mxReply[1];
  char *pacPrompt = "Do you want to load the model anyway? Enter y/n ";
  char *pacReply;

  /**
   * check number and type of arguments
   * cannot write to more than one output argument
   */
  if (nlhs > 1)
  {
    mexErrMsgTxt("Too many output arguments.");
  }

  /** 
   * need the name of the sbml file to translate
   * can supply by name
   * or user can browse the system
   */

  /* argument supplied */
  if (nrhs > 0)
  {
    /**
     * MUST be one input argument
     * a row vector of type string
     * i.e. the filename containing the sbml to be read
     */
    if ((nrhs != 1) || (mxIsChar(prhs[0]) != 1) || (mxGetM(prhs[0]) != 1))
    {
      mexErrMsgTxt("Usage: = TranslateSBML(filename)");
    }

    /**
     * get length of input string 
     * allocate memory and copy to a C string
     */
    nBufferLen  = (mxGetM(prhs[0]) * mxGetN(prhs[0])) + 1;
    pacFilename = (char *) mxCalloc(nBufferLen, sizeof(char));
    nStatus     = mxGetString(prhs[0], pacFilename, nBufferLen);

    if (nStatus != 0)
    {
      mexErrMsgTxt("Not enough space to read filename");
    }

    /* check that the file exists */
    fp = fopen( pacFilename, "r");
    if(fp == NULL)
    {
      mexErrMsgTxt( "File does not exist on this path" );
    }
    else
    {
      fclose(fp);
    }
  }
  /* no argument supplied - browse */
  else
  {
    /* extension to look for */
    mxExt[0] = mxCreateString(".xml");
    nStatus  = mexCallMATLAB(2, mxFilename, 1, mxExt, "uigetfile");

    if (nStatus != 0)
    {
      mexErrMsgTxt("Failed to read filename");
    }

    /* get the filename returned */
    nBuflen = (mxGetM(mxFilename[0])*mxGetN(mxFilename[0])+1);
    pacTempString1 = (char *) mxCalloc(nBuflen, sizeof(char));
    nStatus = mxGetString(mxFilename[0], pacTempString1, nBuflen);

    if (nStatus != 0)
    {
      mexErrMsgTxt("Cannot copy filename");
    }

    nBufferLen = (mxGetM(mxFilename[1])*mxGetN(mxFilename[1])+1);
    pacTempString2 = (char *) mxCalloc(nBufferLen, sizeof(char));
    nStatus = mxGetString(mxFilename[1], pacTempString2, nBufferLen);

    if (nStatus != 0)
    {
      mexErrMsgTxt("Cannot copy path");
    }

    pacFilename = (char *) mxCalloc(nBufferLen+nBuflen, sizeof(char));
    strcpy(pacFilename, pacTempString2);
    strcat(pacFilename, pacTempString1);

    /* check that the file exists */
    fp = fopen( pacFilename, "r");
    if(fp == NULL)
    {
      mexErrMsgTxt( "File does not exist on this path" );
    }
    else
    {
      fclose(fp);
    }
  }

  sbmlDocument = readSBML(pacFilename);

  /* check for errors in the sbml document */
  errors = SBMLDocument_getNumWarnings(sbmlDocument) + SBMLDocument_getNumErrors(sbmlDocument) +
  SBMLDocument_getNumFatals(sbmlDocument);

  errors += SBMLDocument_checkConsistency(sbmlDocument);

  /**
   *  if errors occur report these 
   *  promt user as to whether to import the model    
   */

  if (errors != 0)
  {
    pacErrors = (char *) mxCalloc(errors * 100, sizeof(char));
    pacError  = (char *) mxCalloc(100, sizeof(char));
    
    mxPrompt[0]= mxCreateString(pacPrompt);
    mxPrompt[1]= mxCreateString("s");

    sprintf(pacErrors, "\n%s","*********************\nThis model contains errors\n");

    for (i = 0; i < SBMLDocument_getNumWarnings(sbmlDocument); i++)
    {
      sprintf(pacError, "%u: (%u) %s\n", ParseMessage_getLine(SBMLDocument_getWarning(sbmlDocument, i)),
      ParseMessage_getId(SBMLDocument_getWarning(sbmlDocument, i)), 
      ParseMessage_getMessage(SBMLDocument_getWarning(sbmlDocument, i)));
      pacErrors = safe_strcat(pacErrors, pacError);
    }

    for (i = 0; i < SBMLDocument_getNumErrors(sbmlDocument); i++)
    {
      sprintf(pacError, "%u: (%u) %s\n", ParseMessage_getLine(SBMLDocument_getError(sbmlDocument, i)),
      ParseMessage_getId(SBMLDocument_getError(sbmlDocument, i)), 
      ParseMessage_getMessage(SBMLDocument_getError(sbmlDocument, i)));
      pacErrors = safe_strcat(pacErrors, pacError);
    }

    for (i = 0; i < SBMLDocument_getNumFatals(sbmlDocument); i++)
    {
      sprintf(pacError, "%u: (%u) %s\n", ParseMessage_getLine(SBMLDocument_getFatal(sbmlDocument, i)),
      ParseMessage_getId(SBMLDocument_getFatal(sbmlDocument, i)), 
      ParseMessage_getMessage(SBMLDocument_getFatal(sbmlDocument, i)));
      pacErrors = safe_strcat(pacErrors, pacError);
    }

    mxErrors[0] = mxCreateString(pacErrors);

    mexCallMATLAB(0, NULL, 1, mxErrors, "disp");
    mexCallMATLAB(1, mxReply, 2, mxPrompt, "input");

    nBufferLen = (mxGetM(mxReply[0])*mxGetN(mxReply[0])+1);
    pacReply = (char *) mxCalloc(nBufferLen, sizeof(char));
    mxGetString(mxReply[0], pacReply, nBufferLen);

  }
  else
  {
    pacReply = (char *)mxCalloc(3,sizeof(char));
    pacReply = "y";
  }


  if (strcmp_insensitive(pacReply, "y") == 0) 
  {
    sbmlModel = SBMLDocument_getModel(sbmlDocument);

    pacName        = Model_getName(sbmlModel);
    pacTypecode    = TypecodeToChar(SBase_getTypeCode((SBase_t*) sbmlModel));
    pacNotes       = SBase_getNotes((SBase_t*) sbmlModel);
    pacAnnotations = SBase_getAnnotation((SBase_t*) sbmlModel);

    if (pacName == NULL)
    {
      pacName = "";
    }
    if (pacTypecode == NULL)
    {
      pacTypecode = "";
    }
    if (pacNotes == NULL)
    {
      pacNotes = "";
    }
    if (pacAnnotations == NULL)
    {
      pacAnnotations = "";
    }

    unSBMLLevel   = SBMLDocument_getLevel(sbmlDocument);
    unSBMLVersion = SBMLDocument_getVersion(sbmlDocument);

    GetCompartment   (sbmlModel, unSBMLLevel, unSBMLVersion);
    GetParameter     (sbmlModel, unSBMLLevel, unSBMLVersion);
    GetSpecies       (sbmlModel, unSBMLLevel, unSBMLVersion);
    GetUnitDefinition(sbmlModel, unSBMLLevel, unSBMLVersion);
    GetReaction      (sbmlModel, unSBMLLevel, unSBMLVersion);
    GetRule      (sbmlModel, unSBMLLevel, unSBMLVersion);

    if (unSBMLLevel == 2)
    {
      pacId = Model_getId(sbmlModel);
      GetFunctionDefinition(sbmlModel, unSBMLLevel, unSBMLVersion);
      GetEvent(sbmlModel, unSBMLLevel, unSBMLVersion);

      if (pacId == NULL)
      {
        pacId = "";
      }
    }

    if (unSBMLLevel == 1)
    {
      plhs[0] = mxCreateStructArray(2, dims, nNoFields_l1v1, field_names_l1v1);
    }
    else if (unSBMLLevel == 2 && unSBMLVersion == 1)
    {
      plhs[0] = mxCreateStructArray(2, dims, nNoFields_l2v1, field_names_l2v1);
    }

    mxSetField( plhs[0], 0, "typecode", mxCreateString(pacTypecode) ); 
    mxSetField( plhs[0], 0, "name"    , mxCreateString(pacName)     );

    if (unSBMLLevel == 2)
    {
      mxSetField(plhs[0], 0, "id", mxCreateString(pacId));
    }

    mxSetField( plhs[0], 0, "SBML_level"      , CreateIntScalar(unSBMLLevel)   ); 
    mxSetField( plhs[0], 0, "SBML_version"    , CreateIntScalar(unSBMLVersion) );
    mxSetField( plhs[0], 0, "notes"      , mxCreateString(pacNotes)       );
    mxSetField( plhs[0], 0, "annotation", mxCreateString(pacAnnotations) );

    if (unSBMLLevel == 2)
    {
      mxSetField(plhs[0], 0,"functionDefinition", mxFunctionDefReturn);
    }

    mxSetField( plhs[0], 0, "unitDefinition", mxUnitDefReturn   );
    mxSetField( plhs[0], 0, "compartment"   , mxCompartReturn   );
    mxSetField( plhs[0], 0, "species"       , mxSpeciesReturn   );
    mxSetField( plhs[0], 0, "parameter"     , mxParameterReturn );
    mxSetField( plhs[0], 0, "rule"          , mxListRuleReturn  );
    mxSetField( plhs[0], 0, "reaction"      , mxReactionReturn  );

    if (unSBMLLevel == 2)
    {
      mxSetField(plhs[0], 0, "event", mxEventReturn);
    mxSetField(plhs[0], 0, "time_symbol", mxCSymbolTime);
  }
}


/**
* NAME:       TypecodeToChar
*
* PARAMETERS: SBMLTypeCode_t typecode 
*
* RETURNS:    char *
*
* FUNCTION:   converts typecode to humanly readable string
*/
char *
TypecodeToChar (SBMLTypeCode_t typecode)
{
  char * pacTypecode;

  switch (typecode)
  {
    case SBML_COMPARTMENT:
      pacTypecode = "SBML_COMPARTMENT";
    break;

    case SBML_EVENT:
      pacTypecode = "SBML_EVENT";
    break;

    case SBML_EVENT_ASSIGNMENT:
      pacTypecode = "SBML_EVENT_ASSIGNMENT";
    break;

    case SBML_FUNCTION_DEFINITION:
      pacTypecode = "SBML_FUNCTION_DEFINITION";
    break;

    case SBML_KINETIC_LAW:
      pacTypecode = "SBML_KINETIC_LAW";
    break;

    case SBML_MODEL:
      pacTypecode = "SBML_MODEL";
    break;

    case SBML_PARAMETER:
      pacTypecode = "SBML_PARAMETER";
    break;

    case SBML_REACTION:
      pacTypecode = "SBML_REACTION";
    break;

    case SBML_SPECIES:
      pacTypecode = "SBML_SPECIES";
    break;

    case SBML_SPECIES_REFERENCE:
      pacTypecode = "SBML_SPECIES_REFERENCE";
    break;

    case SBML_MODIFIER_SPECIES_REFERENCE:
      pacTypecode = "SBML_MODIFIER_SPECIES_REFERENCE";
    break;    

    case SBML_UNIT_DEFINITION:
      pacTypecode = "SBML_UNIT_DEFINITION";
    break;

    case SBML_UNIT:
      pacTypecode = "SBML_UNIT";
    break;

    case SBML_ASSIGNMENT_RULE:
      pacTypecode = "SBML_ASSIGNMENT_RULE";
    break;

    case SBML_ALGEBRAIC_RULE:
      pacTypecode = "SBML_ALGEBRAIC_RULE";
    break;

    case SBML_RATE_RULE:
      pacTypecode = "SBML_RATE_RULE";
    break;

    case SBML_SPECIES_CONCENTRATION_RULE:
      pacTypecode = "SBML_SPECIES_CONCENTRATION_RULE";
    break;

    case SBML_COMPARTMENT_VOLUME_RULE:
      pacTypecode = "SBML_COMPARTMENT_VOLUME_RULE";
    break;

    case SBML_PARAMETER_RULE:
      pacTypecode = "SBML_PARAMETER_RULE";
    break;

    default:
      pacTypecode = "ERROR";
    break;
  }

  return pacTypecode;
}

/**
* NAME:       CreateIntScalar
*
* PARAMETERS: int Value 
*
* RETURNS:    mxArray *
*
* FUNCTION:   emulates the function mxCreateDoubleScalar
*             creates an UINT32 array with one element
*             assigns Value to the element
*/
mxArray *
CreateIntScalar (int nValue)
{
  mxArray * pArray;
  int * panData;

  pArray = mxCreateNumericMatrix(1,1,mxINT32_CLASS, mxREAL);
  panData = (int *)mxGetData(pArray);
  panData[0] = nValue;

  return pArray;
}


/**
* NAME:       GetSpecies
*
* PARAMETERS: Pointer to a model
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the species mxArray structure
*             populates the structure with all the species in the model
*
*/
void
GetSpecies ( Model_t      *pModel,  
             unsigned int unSBMLLevel, 
             unsigned int unSBMLVersion )
{
  int n = Model_getNumSpecies(pModel);
  int dims[2] = {1, n};

  /* fields within a species structure */
  const int nNoFields_l1 = 11;
  const char *field_names_l1[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "name", 
    "compartment",
    "initialAmount", 
    "units",
    "boundaryCondition", 
    "charge",
    "isSetInitialAmount", 
    "isSetCharge"};

  const int nNoFields_l2 = 17;
  const char *field_names_l2[] = {	
    "typecode",		
    "notes", 
    "annotation",
    "name", 
    "id", 
    "compartment",
    "initialAmount", 
    "initialConcentration", 
    "substanceUnits",
    "spatialSizeUnits", 
    "hasOnlySubstanceUnits", 
    "boundaryCondition", 
    "charge", 
    "constant",
    "isSetInitialAmount", 
    "isSetInitialConcentration", 
    "isSetCharge"};

  /* values */
  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacName;
  const char * pacId = NULL;
  const char * pacCompartment;
  const char * pacUnits;
  const char * pacSpatialSizeUnits = NULL;

  double dInitialAmount;
  double dInitialConcentration;

  int nHasOnlySubsUnits;
  int nBoundaryCondition;
  int nCharge;
  int nConstant;

  unsigned int unIsSetInit;
  unsigned int unIsSetInitConc;
  unsigned int unIsSetCharge;

  int i;
  Species_t *pSpecies;

  double dZero = 0.0;

  /* create the structure array */
  if (unSBMLLevel == 1) {
    mxSpeciesReturn = mxCreateStructArray(2, dims, nNoFields_l1, field_names_l1);
  }
  else if (unSBMLLevel == 2) {
    mxSpeciesReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);
  }

  for (i = 0; i < n; i++) {
    /* determine the values */
    pSpecies            = Model_getSpecies(pModel, i);
    pacTypecode         = TypecodeToChar(SBase_getTypeCode((SBase_t*) pSpecies));
    pacNotes            = SBase_getNotes((SBase_t*) pSpecies);
    pacAnnotations      = SBase_getAnnotation((SBase_t*) pSpecies);
    pacName             = Species_getName(pSpecies);
    pacCompartment      = Species_getCompartment(pSpecies);
    dInitialAmount      = Species_getInitialAmount(pSpecies);
    nBoundaryCondition  = Species_getBoundaryCondition(pSpecies);
    nCharge             = Species_getCharge(pSpecies);
    unIsSetInit         = Species_isSetInitialAmount(pSpecies);
    unIsSetCharge       = Species_isSetCharge(pSpecies);

    /* record any unset values as NAN */
    if (unIsSetInit == 0) {
      dInitialAmount = 0.0/dZero;
    }

    if (unIsSetCharge == 0) {
      /* if charge is not set it is assumed to be zero */
      nCharge = 0;
    }

    if (unSBMLLevel == 1) {
      pacUnits = Species_getUnits(pSpecies);
    }
    else if (unSBMLLevel == 2) {
      pacId                 = Species_getId(pSpecies);
      dInitialConcentration = Species_getInitialConcentration(pSpecies);
      pacUnits              = Species_getSubstanceUnits(pSpecies);
      pacSpatialSizeUnits   = Species_getSpatialSizeUnits(pSpecies);
      nHasOnlySubsUnits     = Species_getHasOnlySubstanceUnits(pSpecies);
      nConstant             = Species_getConstant(pSpecies);
      unIsSetInitConc       = Species_isSetInitialConcentration(pSpecies);

      /* record any unset values as NAN */

      if (unIsSetInitConc == 0) {
        dInitialConcentration = 0.0/dZero;
      }
    }

    /**
     * check for NULL strings - Matlab doesnt like creating 
     * a string that is NULL
     */
    if (pacName == NULL) {
      pacName = "";
    }
    if (pacId == NULL) {
      pacId = "";
    }
    if (pacCompartment == NULL) {
      pacCompartment = "";
    }
    if (pacUnits == NULL) {
      pacUnits = "";
    }
    if (pacSpatialSizeUnits == NULL) {
      pacSpatialSizeUnits = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }

    /* put into structure */
    mxSetField(mxSpeciesReturn, i, "typecode",   mxCreateString(pacTypecode)); 
    mxSetField(mxSpeciesReturn, i, "notes",      mxCreateString(pacNotes));
    mxSetField(mxSpeciesReturn, i, "annotation", mxCreateString(pacAnnotations));
    mxSetField(mxSpeciesReturn, i, "name",       mxCreateString(pacName)); 
    
    if (unSBMLLevel == 2) {
      mxSetField(mxSpeciesReturn, i, "id",  mxCreateString(pacId)); 
    }

    mxSetField(mxSpeciesReturn, i, "compartment",   mxCreateString(pacCompartment)); 
    mxSetField(mxSpeciesReturn, i, "initialAmount", mxCreateDoubleScalar(dInitialAmount)); 
    
    if (unSBMLLevel == 1) {
      mxSetField(mxSpeciesReturn, i, "units",              mxCreateString(pacUnits)); 
      mxSetField(mxSpeciesReturn, i, "boundaryCondition",  CreateIntScalar(nBoundaryCondition)); 
      mxSetField(mxSpeciesReturn, i, "charge",             CreateIntScalar(nCharge)); 
      mxSetField(mxSpeciesReturn, i, "isSetInitialAmount", CreateIntScalar(unIsSetInit)); 
    }
    else if (unSBMLLevel == 2) {
      mxSetField(mxSpeciesReturn, i, "initialConcentration",      mxCreateDoubleScalar(dInitialConcentration)); 
      mxSetField(mxSpeciesReturn, i, "substanceUnits",            mxCreateString(pacUnits)); 
      mxSetField(mxSpeciesReturn, i, "spatialSizeUnits",          mxCreateString(pacSpatialSizeUnits)); 
      mxSetField(mxSpeciesReturn, i, "hasOnlySubstanceUnits",     CreateIntScalar(nHasOnlySubsUnits)); 
      mxSetField(mxSpeciesReturn, i, "boundaryCondition",         CreateIntScalar(nBoundaryCondition)); 
      mxSetField(mxSpeciesReturn, i, "charge",                    CreateIntScalar(nCharge)); 
      mxSetField(mxSpeciesReturn, i, "constant",                  CreateIntScalar(nConstant)); 
      mxSetField(mxSpeciesReturn, i, "isSetInitialAmount",        CreateIntScalar(unIsSetInit)); 
      mxSetField(mxSpeciesReturn, i, "isSetInitialConcentration", CreateIntScalar(unIsSetInitConc)); 
    }
    mxSetField(mxSpeciesReturn, i, "isSetCharge", CreateIntScalar(unIsSetCharge)); 
  }
}


/**
* NAME:       GetUnitDefinition
*
* PARAMETERS: Pointer to a model
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the unit definition mxArray structure
*             populates the structure with all the unit definition in the model
*
*/
void
GetUnitDefinition ( Model_t      *pModel,
                    unsigned int unSBMLLevel,
                    unsigned int unSBMLVersion )
{
  int n = Model_getNumUnitDefinitions(pModel);
  int dims[2] = {1, n};

  /* fields within a unit definition structure */
  const int nNoFields_l1 = 5;
  const char * field_names_l1[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "name", 
    "unit"};
  
  const int nNoFields_l2 = 6;
  const char * field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "name", 
    "id", 
    "unit"};

  /* values */
  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacName;
  const char * pacId = NULL;

  UnitDefinition_t *pUnitDefinition;
  int i;

  /**
   * create the structure array 
   * n instances
   */
  if (unSBMLLevel == 1) {
    mxUnitDefReturn = mxCreateStructArray(2, dims, nNoFields_l1, field_names_l1);
  }
  else if (unSBMLLevel == 2) {
    mxUnitDefReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);
  }

  for (i = 0; i < n; i++) {
    /* determine the values */
    pUnitDefinition = Model_getUnitDefinition(pModel, i);
    pacTypecode     = TypecodeToChar(SBase_getTypeCode((SBase_t*) pUnitDefinition));
    pacNotes        = SBase_getNotes((SBase_t*) pUnitDefinition);
    pacAnnotations  = SBase_getAnnotation((SBase_t*) pUnitDefinition);
    pacName         = UnitDefinition_getName(pUnitDefinition);

    GetUnit(pUnitDefinition, unSBMLLevel, unSBMLVersion);

    if (unSBMLLevel == 2) {
      pacId = UnitDefinition_getId(pUnitDefinition);
    }

    /**
     * check for NULL strings - Matlab doesnt like creating 
     * a string that is NULL
     */
    if (pacName == NULL) {
      pacName = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }
    if (pacId == NULL) {
      pacId = "";
    }

    /* put into structure */
    mxSetField(mxUnitDefReturn, i, "typecode",    mxCreateString(pacTypecode)); 
    mxSetField(mxUnitDefReturn, i, "notes",       mxCreateString(pacNotes));
    mxSetField(mxUnitDefReturn, i, "annotation",  mxCreateString(pacAnnotations));
    mxSetField(mxUnitDefReturn, i, "name",        mxCreateString(pacName)); 
    if (unSBMLLevel == 2) {
      mxSetField(mxUnitDefReturn, i, "id",        mxCreateString(pacId)); 
    }
    mxSetField(mxUnitDefReturn, i, "unit",        mxUnitReturn); 

    mxUnitReturn = NULL;
  }
}


/**
* NAME:       GetCompartment
*
* PARAMETERS: Pointer to a model
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the compartment mxArray structure
*             populates the structure with all the compartment in the model
*
*/
void
GetCompartment ( Model_t      *pModel,
                 unsigned int unSBMLLevel,
                 unsigned int unSBMLVersion )
{
  int n = Model_getNumCompartments(pModel);
  int dims[2] = {1, n};

  /* fields within a compartment structure */
  const int nNoFields_l1 = 8;
  const char *field_names_l1[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "name", 
    "volume",
    "units", 
    "outside", 
    "isSetVolume"};

  const int nNoFields_l2 = 12;
  const char *field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "name", 
    "id", 
    "spatialDimensions", 
    "size",
    "units", 
    "outside", 
    "constant", 
    "isSetSize", 
    "isSetVolume"};

  /* field values */
  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacName;
  const char * pacId = NULL;
  const char * pacUnits;
  const char * pacOutside;

  double dVolume;
  double dSize;

  unsigned int unSpatialDimensions;
  unsigned int unIsSetVolume;
  unsigned int unIsSetSize;

  int nConstant;

  Compartment_t *pCompartment;
  int i;

  double dZero = 0.0;

  /* create the structure array  */
  if (unSBMLLevel == 1) {
    mxCompartReturn = mxCreateStructArray(2, dims, nNoFields_l1, field_names_l1);
  }
  else if (unSBMLLevel == 2) {
    mxCompartReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);
  }

  for (i = 0; i < n; i++) {
    /* determine the values */
    pCompartment    = Model_getCompartment(pModel, i);
    pacTypecode     = TypecodeToChar(SBase_getTypeCode((SBase_t*) pCompartment));
    pacNotes        = SBase_getNotes((SBase_t*) pCompartment);
    pacAnnotations  = SBase_getAnnotation((SBase_t*) pCompartment);
    pacName         = Compartment_getName(pCompartment);
    pacUnits        = Compartment_getUnits(pCompartment);
    pacOutside      = Compartment_getOutside(pCompartment);
    unIsSetVolume   = Compartment_isSetVolume(pCompartment);
    
    if (unSBMLLevel == 1) {
      dVolume = Compartment_getVolume(pCompartment);

      /* record any unset values as NAN */
      if (unIsSetVolume == 0) {
        dVolume = 0.0/dZero;
      }
    }
    else if (unSBMLLevel == 2) {
      pacId               = Compartment_getId(pCompartment);
      unSpatialDimensions = Compartment_getSpatialDimensions(pCompartment);
      dSize               = Compartment_getSize(pCompartment);
      nConstant           = Compartment_getConstant(pCompartment);
      unIsSetSize         = Compartment_isSetSize(pCompartment);

      /* record any unset values as NAN */
      if (unIsSetSize == 0) {
        dSize = 0.0/dZero;
      }
    }

    /**
     * check for NULL strings - Matlab doesnt like creating 
     * a string that is NULL
     */
    if (pacName == NULL) {
      pacName = "";
    }
    if (pacId == NULL) {
      pacId = "";
    }
    if (pacUnits == NULL) {
      pacUnits = "";
    }
    if (pacOutside == NULL) {
      pacOutside = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }

    /* put into structure */
    mxSetField(mxCompartReturn, i, "typecode",   mxCreateString(pacTypecode)); 
    mxSetField(mxCompartReturn, i, "notes",      mxCreateString(pacNotes));
    mxSetField(mxCompartReturn, i, "annotation", mxCreateString(pacAnnotations));
    mxSetField(mxCompartReturn, i, "name",       mxCreateString(pacName)); 

    if (unSBMLLevel == 1) {
      mxSetField(mxCompartReturn, i, "volume",   mxCreateDoubleScalar(dVolume)); 
    }
    else if (unSBMLLevel == 2) {
      mxSetField(mxCompartReturn, i, "id",                mxCreateString(pacId)); 
      mxSetField(mxCompartReturn, i, "spatialDimensions", CreateIntScalar(unSpatialDimensions)); 
      mxSetField(mxCompartReturn, i, "size",              mxCreateDoubleScalar(dSize)); 
    }

    mxSetField(mxCompartReturn, i, "units",   mxCreateString(pacUnits)); 
    mxSetField(mxCompartReturn, i, "outside", mxCreateString(pacOutside)); 

    if (unSBMLLevel == 2) {
      mxSetField(mxCompartReturn, i, "constant",  CreateIntScalar(nConstant)); 
      mxSetField(mxCompartReturn, i, "isSetSize", CreateIntScalar(unIsSetSize)); 
    }

    mxSetField(mxCompartReturn, i, "isSetVolume",CreateIntScalar(unIsSetVolume)); 
  }
}


/**
* NAME:       GetParameter
*
* PARAMETERS: Pointer to a model
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the parameter mxArray structure
*             populates the structure with all the parameters in the model
*/
void
GetParameter ( Model_t      *pModel,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion )
{
  int n = Model_getNumParameters(pModel);
  int dims[2] = {1, n};

  /* fields within a parameter structure */
  const int nNoFields_l1 = 7;
  const char *field_names_l1[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "name", 
    "value",
    "units",
    "isSetValue"};

  const int nNoFields_l2 = 9;
  const char *field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "name", 
    "id", 
    "value",
    "units", 
    "constant", 
    "isSetValue"};

  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacName;
  const char * pacId = NULL;
  const char * pacUnits;

  double dValue;

  unsigned int unIsSetValue;

  int nConstant;

  Parameter_t *pParameter;

  int i;
  double dZero =0.0;    

  /* create the structure array  */
  if (unSBMLLevel == 1) {
    mxParameterReturn = mxCreateStructArray(2, dims, nNoFields_l1, field_names_l1);
  }
  else if (unSBMLLevel == 2) {
    mxParameterReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);
  }

  for (i = 0; i < n; i++) {
    /* determine the values */
    pParameter      = Model_getParameter(pModel, i);
    pacTypecode     = TypecodeToChar(SBase_getTypeCode((SBase_t*) pParameter));
    pacNotes        = SBase_getNotes((SBase_t*) pParameter);
    pacAnnotations  = SBase_getAnnotation((SBase_t*) pParameter);
    pacName         = Parameter_getName(pParameter);
    dValue          = Parameter_getValue(pParameter);
    pacUnits        = Parameter_getUnits(pParameter);
    unIsSetValue    = Parameter_isSetValue(pParameter);

    /* record any unset values as NAN */
    if (unIsSetValue == 0) {
      dValue = 0.0/dZero;
    }
    
    if (unSBMLLevel == 2) {
      pacId = Parameter_getId(pParameter);
      nConstant = Parameter_getConstant(pParameter);
    }

    /**
     * check for NULL strings - Matlab doesnt like creating 
     * a string that is NULL
     */
    if (pacName == NULL) {
      pacName = "";
    }
    if (pacUnits == NULL) {
      pacUnits = "";
    }
    if (pacId == NULL) {
      pacId = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }

    /* put into structure */
    mxSetField(mxParameterReturn, i, "typecode",    mxCreateString(pacTypecode)); 
    mxSetField(mxParameterReturn, i, "notes",       mxCreateString(pacNotes));
    mxSetField(mxParameterReturn, i, "annotation",  mxCreateString(pacAnnotations));
    mxSetField(mxParameterReturn, i, "name",        mxCreateString(pacName)); 
    
    if (unSBMLLevel == 2) {
      mxSetField(mxParameterReturn, i, "id",        mxCreateString(pacId)); 
    }

    mxSetField(mxParameterReturn, i, "value",       mxCreateDoubleScalar(dValue)); 
    mxSetField(mxParameterReturn, i, "units",       mxCreateString(pacUnits)); 

    if (unSBMLLevel == 2) {
      mxSetField(mxParameterReturn, i, "constant",  CreateIntScalar(nConstant)); 
    }

    mxSetField(mxParameterReturn, i, "isSetValue",  CreateIntScalar(unIsSetValue)); 
  }
}


/**
* NAME:       GetReaction
*
* PARAMETERS: Pointer to a model
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the reaction mxArray structure
*             populates the structure with all the reactions in the model
*
*/
void GetReaction ( Model_t      *pModel,
                   unsigned int unSBMLLevel,
                   unsigned int unSBMLVersion )
{
  int n = Model_getNumReactions(pModel);
  int dims[2] = {1, n};

  /* fields within a reaction structure */
  const int nNoFields_l1 = 9;
  const char *field_names_l1[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "name", 
    "reactant",
    "product", 
    "kineticLaw",
    "reversible", 
    "fast"};

  const int nNoFields_l2 = 12;
  const char *field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "name", 
    "id", 
    "reactant",
    "product", 
    "modifier", 
    "kineticLaw",
    "reversible", 
    "fast", 
    "isSetFast"};

  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacName;
  const char * pacId = NULL;

  int nReversible;
  int nFast;

  unsigned int unIsSetFast;

  Reaction_t *pReaction;

  int i;

  int nZero = 0;

  /* create the structure array */
  if (unSBMLLevel == 1) {
    mxReactionReturn = mxCreateStructArray(2, dims, nNoFields_l1, field_names_l1);
  }
  else if (unSBMLLevel == 2) {
    mxReactionReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);
  }

  for (i = 0; i < n; i++) {
    /* determine the values */
    pReaction       = Model_getReaction(pModel, i);
    pacTypecode     = TypecodeToChar(SBase_getTypeCode((SBase_t*) pReaction));
    pacNotes        = SBase_getNotes((SBase_t*) pReaction);
    pacAnnotations  = SBase_getAnnotation((SBase_t*) pReaction);
    pacName         = Reaction_getName(pReaction);
    nReversible     = Reaction_getReversible(pReaction);
    nFast           = Reaction_getFast(pReaction);
    
    GetReactants( pReaction, unSBMLLevel, unSBMLVersion);
    GetProducts(  pReaction, unSBMLLevel, unSBMLVersion);
    GetKineticLaw(pReaction, unSBMLLevel, unSBMLVersion);

    if (unSBMLLevel == 2) {
      pacId = Reaction_getId(pReaction);
      unIsSetFast = Reaction_isSetFast(pReaction);
      GetModifier(pReaction, unSBMLLevel, unSBMLVersion);   

      /* record any unset values as not specified */
      if (unIsSetFast == 0) {
      /* since in level 2 the fast field is optional a 
      value of -1 indicates that the user has chosen not to set */
        nFast = -1;
      }
    }

    /**
     * check for NULL strings - Matlab doesnt like creating 
     * a string that is NULL
     */
    if (pacName == NULL) {
      pacName = "";
    }
    if (pacId == NULL) {
      pacId = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }

    /* put into structure */
    mxSetField(mxReactionReturn, i, "typecode",   mxCreateString(pacTypecode)); 
    mxSetField(mxReactionReturn, i, "notes",      mxCreateString(pacNotes));
    mxSetField(mxReactionReturn, i, "annotation", mxCreateString(pacAnnotations));
    mxSetField(mxReactionReturn, i, "name",       mxCreateString(pacName)); 
    
    if (unSBMLLevel == 2) {
      mxSetField(mxReactionReturn, i, "id",       mxCreateString(pacId)); 
    }

    mxSetField(mxReactionReturn, i, "reactant",   mxReactantReturn); 
    mxSetField(mxReactionReturn, i, "product",    mxProductReturn); 
    
    if (unSBMLLevel == 2) {
      mxSetField(mxReactionReturn, i, "modifier", mxModifierReturn); 
    }
    
    mxSetField(mxReactionReturn, i, "kineticLaw", mxKineticLawReturn); 
    mxSetField(mxReactionReturn, i, "reversible", CreateIntScalar(nReversible)); 
    mxSetField(mxReactionReturn, i, "fast",       CreateIntScalar(nFast)); 
    
    if (unSBMLLevel == 2) {
      mxSetField(mxReactionReturn, i, "isSetFast", CreateIntScalar(unIsSetFast)); 
    }

    mxReactantReturn   = NULL;
    mxProductReturn    = NULL;
    mxKineticLawReturn = NULL;
    mxModifierReturn   = NULL;
  }
}


/**
* NAME:       GetUnit
*
* PARAMETERS: Pointer to a unit definition
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the unit mxArray structure
*             populates the structure with all the units in the unit definition
*/
void
GetUnit ( UnitDefinition_t *pUnitDefinition,
          unsigned int     unSBMLLevel,
          unsigned int     unSBMLVersion )
{
  int n = UnitDefinition_getNumUnits(pUnitDefinition);
  int dims[2] = {1, n};

  /* fields within a unit structure */
  const int nNoFields_l1 = 6;
  const char *field_names_l1[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "kind", 
    "exponent",
    "scale"};

  const int nNoFields_l2 = 8;
  const char *field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "kind", 
    "exponent", 
    "scale", 
    "multiplier", 
    "offset"};

  /* values */
  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacUnitKind;
  
  int nExponent;
  int nScale;
  
  double dMultiplier;
  double dOffset;

  Unit_t *pUnit;
  int i;

  /* create the structure array */
  if (unSBMLLevel == 1) {
    mxUnitReturn = mxCreateStructArray(2, dims, nNoFields_l1, field_names_l1);
  }
  else if (unSBMLLevel == 2) {
    mxUnitReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);
  }

  for (i = 0; i < n; i++) {
    /* determine the values */
    pUnit           = UnitDefinition_getUnit(pUnitDefinition, i);
    pacTypecode     = TypecodeToChar(SBase_getTypeCode((SBase_t*) pUnit));
    pacNotes        = SBase_getNotes((SBase_t*) pUnit);
    pacAnnotations  = SBase_getAnnotation((SBase_t*) pUnit);
    pacUnitKind     = UnitKind_toString(Unit_getKind(pUnit));
    nExponent       = Unit_getExponent(pUnit);
    nScale          = Unit_getScale(pUnit);

    if (unSBMLLevel == 2) {
      dMultiplier   = Unit_getMultiplier(pUnit);
      dOffset       = Unit_getOffset(pUnit);
    }

    /**
     * check for NULL strings - Matlab doesnt like creating 
     * a string that is NULL
     */
    if (pacUnitKind == NULL) {
      pacUnitKind = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }

    /* put into structure */
    mxSetField(mxUnitReturn, i, "typecode",   mxCreateString(pacTypecode)); 
    mxSetField(mxUnitReturn, i, "notes",      mxCreateString(pacNotes));
    mxSetField(mxUnitReturn, i, "annotation", mxCreateString(pacAnnotations));
    mxSetField(mxUnitReturn, i, "kind",       mxCreateString(pacUnitKind)); 
    mxSetField(mxUnitReturn, i, "exponent",   CreateIntScalar(nExponent)); 
    mxSetField(mxUnitReturn, i, "scale",      CreateIntScalar(nScale)); 
    
    if (unSBMLLevel == 2) {
      mxSetField(mxUnitReturn, i, "multiplier", mxCreateDoubleScalar(dMultiplier)); 
      mxSetField(mxUnitReturn, i, "offset",     mxCreateDoubleScalar(dOffset)); 
    }
  }
}


/**
* NAME:       GetReactants
*
* PARAMETERS: Pointer to a reaction
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the species reference mxArray structure
*             populates the structure with all the species references 
*             listed as reactants in the reaction
*/
void
GetReactants ( Reaction_t   *pReaction,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion )
{
  int n = Reaction_getNumReactants(pReaction);
  int dims[2] = {1, n};

  /* fields within a reactant structure */
  const int nNoFields_l1 = 6;
  const char *field_names_l1[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "species", 
    "stoichiometry",
    "denominator"};

  const int nNoFields_l2 = 7;
  const char *field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "species", 
    "stoichiometry",
    "denominator", 
    "stoichiometryMath"};

  /*values */
  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacSpecies;
  const char * pacStoichMath = NULL;
  
  int nStoichiometry;
  int nDenominator;
  
  double dStoichiometry;
  
  SpeciesReference_t *pReactant;
  int i;

  /* create the structure array */
  if (unSBMLLevel == 1) {
    mxReactantReturn = mxCreateStructArray(2, dims, nNoFields_l1, field_names_l1);
  }
  else if (unSBMLLevel == 2) {
    mxReactantReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);
  }

  for (i = 0; i < n; i++) {
    /* determine the values */
    pReactant       = Reaction_getReactant(pReaction, i);
    pacTypecode     = TypecodeToChar(SBase_getTypeCode((SBase_t*) pReactant));
    pacNotes        = SBase_getNotes((SBase_t*) pReactant);
    pacAnnotations  = SBase_getAnnotation((SBase_t*) pReactant);
    pacSpecies      = SpeciesReference_getSpecies(pReactant);
 
    if (unSBMLLevel == 1) {
      nStoichiometry = (int) SpeciesReference_getStoichiometry(pReactant);
    }
    else if (unSBMLLevel == 2) {
      dStoichiometry = SpeciesReference_getStoichiometry(pReactant);
      
      if (SpeciesReference_isSetStoichiometryMath(pReactant) == 1) {
        pacStoichMath = SBML_formulaToString(SpeciesReference_getStoichiometryMath(pReactant));
      }
    }
    
    nDenominator    = SpeciesReference_getDenominator(pReactant);

    /**
     * check for NULL strings - Matlab doesnt like creating 
     * a string that is NULL
     */
    if (pacSpecies == NULL) {
      pacSpecies = "";
    }
    if (pacStoichMath == NULL) {
      pacStoichMath = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }

    /* put into structure */
    mxSetField(mxReactantReturn, i, "typecode",       mxCreateString(pacTypecode)); 
    mxSetField(mxReactantReturn, i, "notes",          mxCreateString(pacNotes));
    mxSetField(mxReactantReturn, i, "annotation",     mxCreateString(pacAnnotations));
    mxSetField(mxReactantReturn, i, "species",        mxCreateString(pacSpecies));
    
    if (unSBMLLevel == 1) {
      mxSetField(mxReactantReturn, i, "stoichiometry", CreateIntScalar(nStoichiometry)); 
    }
    else if (unSBMLLevel == 2) {
      mxSetField(mxReactantReturn, i, "stoichiometry", mxCreateDoubleScalar(dStoichiometry)); 
    }
    
    mxSetField(mxReactantReturn, i, "denominator",     CreateIntScalar(nDenominator));
    
    if (unSBMLLevel == 2) {
      mxSetField(mxReactantReturn, i, "stoichiometryMath", mxCreateString(pacStoichMath)); 
    }
  }
}


/**
* NAME:       GetProducts
*
* PARAMETERS: Pointer to a reaction
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the species reference mxArray structure
*             populates the structure with all the species references 
*             listed as products in the reaction
*/
void
GetProducts ( Reaction_t   *pReaction,
              unsigned int unSBMLLevel,
              unsigned int unSBMLVersion )
{
  int n = Reaction_getNumProducts(pReaction);
  int dims[2] = {1, n};

  /* fields within a product structure */
  const int nNoFields_l1 = 6;
  const char *field_names_l1[] = {
    "typecode", 
    "notes", 
    "annotation",
    "species", 
    "stoichiometry",
    "denominator"};

  const int nNoFields_l2 = 7;
  const char *field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "species", 
    "stoichiometry",
    "denominator", 
    "stoichiometryMath"};

  /* values */
  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacSpecies;
  const char * pacStoichMath = NULL;
  
  int nStoichiometry;
  int nDenominator;
  
  double dStoichiometry;
  
  SpeciesReference_t *pProduct;
  int i;


  /* create the structure array */
  if (unSBMLLevel == 1) {
    mxProductReturn = mxCreateStructArray(2, dims, nNoFields_l1, field_names_l1);
  }
  else if (unSBMLLevel == 2) {
    mxProductReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);
  }

  for (i = 0; i < n; i++) {
    /* determine the values */
    pProduct        = Reaction_getProduct(pReaction, i);
    pacTypecode     = TypecodeToChar(SBase_getTypeCode((SBase_t*) pProduct));
    pacNotes        = SBase_getNotes((SBase_t*) pProduct);
    pacAnnotations  = SBase_getAnnotation((SBase_t*) pProduct);
    pacSpecies      = SpeciesReference_getSpecies(pProduct);

    if (unSBMLLevel == 1) {
      nStoichiometry = (int) SpeciesReference_getStoichiometry(pProduct);
    }
    else if (unSBMLLevel == 2) {
      dStoichiometry = SpeciesReference_getStoichiometry(pProduct);

      if (SpeciesReference_isSetStoichiometryMath(pProduct)) {
        pacStoichMath = SBML_formulaToString(SpeciesReference_getStoichiometryMath(pProduct));
      }
    }
    
    nDenominator    = SpeciesReference_getDenominator(pProduct);

    /**
     * check for NULL strings - Matlab doesnt like creating 
     * a string that is NULL
     */
    if (pacSpecies == NULL) {
      pacSpecies = "";
    }
    if (pacStoichMath == NULL) {
      pacStoichMath = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }

    /* put into structure */
    mxSetField(mxProductReturn, i, "typecode",    mxCreateString(pacTypecode)); 
    mxSetField(mxProductReturn, i, "notes",       mxCreateString(pacNotes));
    mxSetField(mxProductReturn, i, "annotation",  mxCreateString(pacAnnotations));
    mxSetField(mxProductReturn, i, "species",     mxCreateString(pacSpecies)); 
    
    if (unSBMLLevel == 1) {
      mxSetField(mxProductReturn, i, "stoichiometry", CreateIntScalar(nStoichiometry)); 
    }
    else if (unSBMLLevel == 2) {
      mxSetField(mxProductReturn, i, "stoichiometry", mxCreateDoubleScalar(dStoichiometry)); 
    }
    
    mxSetField(mxProductReturn, i, "denominator",     CreateIntScalar(nDenominator));
    
    if (unSBMLLevel == 2) {
      mxSetField(mxProductReturn, i, "stoichiometryMath", mxCreateString(pacStoichMath)); 
    }
  }
}


/**
* NAME:       GetKineticLaw
*
* PARAMETERS: Pointer to a reaction
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the kinetic law mxArray structure
*             populates the structure with the kinetic law 
*             for the reaction
*/
void
GetKineticLaw ( Reaction_t   *pReaction,
                unsigned int unSBMLLevel,
                unsigned int unSBMLVersion)
{
  int dims[2] = {1, 1};

  /* fields within a kinetic law structure */
  const int nNoFields_l1 = 7;
  const char *field_names_l1[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "formula",	
    "parameter",
    "timeUnits", 
    "substanceUnits"};

  const int nNoFields_l2 = 8;
  const char *field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "formula", 
    "math", 
    "parameter",
    "timeUnits", 
    "substanceUnits"};
  
  /* values */
  const char * pacTypecode = NULL;
  const char * pacNotes = NULL;
  const char * pacAnnotations = NULL;
  const char * pacFormula = NULL;
  const char * pacTimeUnits = NULL;
  const char * pacSubstanceUnits = NULL;
  const char * pacMathFormula = NULL;
  const char * pacTimeCSymbol = "";

  KineticLaw_t *pKineticLaw;

  /* variables for mathML - matlab hack */
  int nStatus, nBuflen;
  mxArray * mxInput[1], * mxOutput[1];

  /* variables to check for csymbol time */
  const ASTNode_t *astMath;
  ASTNode_t *astChild;
  unsigned int nChild, nC;
  ASTNodeType_t type;

  /* create the structure array */
  if (unSBMLLevel == 1) {
    mxKineticLawReturn = mxCreateStructArray(2, dims, nNoFields_l1, field_names_l1);
  }
  else if (unSBMLLevel == 2) {
    mxKineticLawReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);
  }

  /* determine the values dealing with the very unusual situation in which
  no kinetic law has been set */

  pKineticLaw = Reaction_getKineticLaw(pReaction);

  if (pKineticLaw != NULL)
  {
    pacTypecode       = TypecodeToChar(SBase_getTypeCode((SBase_t*) pKineticLaw));
    pacNotes          = SBase_getNotes((SBase_t*) pKineticLaw);
    pacAnnotations    = SBase_getAnnotation((SBase_t*) pKineticLaw);
    pacFormula        = KineticLaw_getFormula(pKineticLaw);
    pacTimeUnits      = KineticLaw_getTimeUnits(pKineticLaw);
    pacSubstanceUnits = KineticLaw_getSubstanceUnits(pKineticLaw);

    GetKineticLawParameters(pKineticLaw, unSBMLLevel, unSBMLVersion);

    /* if level two set the math formula */
    if (unSBMLLevel == 2 && KineticLaw_isSetMath(pKineticLaw)) {
      KineticLaw_setFormulaFromMath(pKineticLaw);

      /* look for csymbol time */
      astMath = KineticLaw_getMath(pKineticLaw);
      nChild = ASTNode_getNumChildren(astMath);
      for (nC = 0; nC < nChild; nC++)
      {
        astChild = ASTNode_getChild(astMath, nC);
        type = ASTNode_getType(astChild);
        if (type == AST_NAME_TIME)
        {
          pacTimeCSymbol = ASTNode_getName(astChild);
        }
      }
      mxCSymbolTime = mxCreateString(pacTimeCSymbol);
      pacMathFormula  = KineticLaw_getFormula(pKineticLaw);
    }

    /* temporary hack to convert MathML in-fix to MATLAB compatible formula */
    mxInput[0] = mxCreateString(pacFormula);
    nStatus = mexCallMATLAB(1, mxOutput, 1, mxInput, "CheckAndConvert");

    if (nStatus != 0)
    {
      mexErrMsgTxt("Failed to convert formula");
    }

    /* get the formula returned */
    nBuflen = (mxGetM(mxOutput[0])*mxGetN(mxOutput[0])+1);
    pacFormula = (char *) mxCalloc(nBuflen, sizeof(char));
    nStatus = mxGetString(mxOutput[0], (char *) pacFormula, nBuflen);

    if (nStatus != 0)
    {
      mexErrMsgTxt("Cannot copy formula");
    }

    /* END OF HACK */
  }
  else 
  {
    pacFormula = NULL;
    pacMathFormula = NULL;
    mxKineticLawParameterReturn = NULL;
  }
  /**
   * check for NULL strings - Matlab doesnt like creating 
   * a string that is NULL
   */
  if (pacTypecode == NULL) {
    pacTypecode = "SBML_KINETIC_LAW";
  }
  if (pacFormula == NULL) {
    pacFormula = "";
  }
  if (pacMathFormula == NULL) {
    pacMathFormula = "";
  }
  if (pacTimeUnits == NULL) {
    pacTimeUnits = "";
  }
  if (pacSubstanceUnits == NULL) {
    pacSubstanceUnits = "";
  }
  if (pacNotes == NULL) {
    pacNotes = "";
  }
  if (pacAnnotations == NULL) {
    pacAnnotations = "";
  }

  /* put into structure */
  mxSetField(mxKineticLawReturn, 0, "typecode",   mxCreateString(pacTypecode)); 
  mxSetField(mxKineticLawReturn, 0, "notes",      mxCreateString(pacNotes));
  mxSetField(mxKineticLawReturn, 0, "annotation", mxCreateString(pacAnnotations));
  mxSetField(mxKineticLawReturn, 0, "formula",    mxCreateString(pacFormula)); 
  
  if (unSBMLLevel == 2) {
    mxSetField(mxKineticLawReturn, 0, "math", mxCreateString(pacMathFormula)); 
  }

  mxSetField(mxKineticLawReturn, 0, "parameter",      mxKineticLawParameterReturn); 
  mxSetField(mxKineticLawReturn, 0, "timeUnits",      mxCreateString(pacTimeUnits)); 
  mxSetField(mxKineticLawReturn, 0, "substanceUnits", mxCreateString(pacSubstanceUnits)); 
}


/**
* NAME:       GetKineticLawParameters
*
* PARAMETERS: Pointer to a kinetic law
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the parameter mxArray structure
*             populates the structure with all the parameters 
*             listed as for the kinetic law
*/
void
GetKineticLawParameters ( KineticLaw_t *pKineticLaw,
                          unsigned int unSBMLLevel,
                          unsigned int unSBMLVersion )
{
  int n = KineticLaw_getNumParameters(pKineticLaw);
  int dims[2] = {1, n};

  /* fields within a parameter structure */
  const int nNoFields_l1 = 7;
  const char *field_names_l1[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "name", 
    "value",
    "units", 
    "isSetValue"};

  const int nNoFields_l2 = 9;
  const char *field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "name", 
    "id", 
    "value",
    "units", 
    "constant", 
    "isSetValue"};

  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacName;
  const char * pacId = NULL;
  const char * pacUnits;

  double dValue;

  unsigned int unIsSetValue;

  int nConstant;

  Parameter_t *pParameter;

  int i;

  double dZero = 0.0;

  /* create the structure array */
  if (unSBMLLevel == 1) {
    mxKineticLawParameterReturn = mxCreateStructArray(2, dims, nNoFields_l1, field_names_l1);
  }
  else if (unSBMLLevel == 2) {
    mxKineticLawParameterReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);
  }

  for (i = 0; i < n; i++) {
    /* values */
    pParameter      = KineticLaw_getParameter(pKineticLaw, i);
    pacTypecode     = TypecodeToChar(SBase_getTypeCode((SBase_t*) pParameter));
    pacNotes        = SBase_getNotes((SBase_t*) pParameter);
    pacAnnotations  = SBase_getAnnotation((SBase_t*) pParameter);
    pacName         = Parameter_getName(pParameter);
    dValue          = Parameter_getValue(pParameter);
    pacUnits        = Parameter_getUnits(pParameter);
    unIsSetValue    = Parameter_isSetValue(pParameter);

    /* record any unset values as NAN */
    if (unIsSetValue == 0) {
      dValue = 0.0/dZero;
    }

    if (unSBMLLevel == 2) {
      pacId     = Parameter_getId(pParameter);
      nConstant = Parameter_getConstant(pParameter);
    }

    /**
     * check for NULL strings - Matlab doesnt like creating 
     * a string that is NULL
     */
    if (pacName == NULL) {
      pacName = "";
    }
    if (pacUnits == NULL) {
      pacUnits = "";
    }
    if (pacId == NULL) {
      pacId = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }

    /* put into structure */
    mxSetField(mxKineticLawParameterReturn, i, "typecode",    mxCreateString(pacTypecode)); 
    mxSetField(mxKineticLawParameterReturn, i, "notes",       mxCreateString(pacNotes));
    mxSetField(mxKineticLawParameterReturn, i, "annotation",  mxCreateString(pacAnnotations));
    mxSetField(mxKineticLawParameterReturn, i, "name",        mxCreateString(pacName)); 
    
    if (unSBMLLevel == 2) {
      mxSetField(mxKineticLawParameterReturn, i, "id",        mxCreateString(pacId)); 
    }

    mxSetField(mxKineticLawParameterReturn, i, "value",       mxCreateDoubleScalar(dValue)); 
    mxSetField(mxKineticLawParameterReturn, i, "units",       mxCreateString(pacUnits)); 

    if (unSBMLLevel == 2) {
      mxSetField(mxKineticLawParameterReturn, i, "constant",  CreateIntScalar(nConstant)); 
    }
  
    mxSetField(mxKineticLawParameterReturn, i, "isSetValue",  CreateIntScalar(unIsSetValue)); 
  }
}


/**
* NAME:       GetModifier
*
* PARAMETERS: Pointer to a reaction
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the species reference mxArray structure
*             populates the structure with all the species references 
*             listed as modifiers in the reaction
*/
void
GetModifier ( Reaction_t   *pReaction,
              unsigned int unSBMLLevel,
              unsigned int unSBMLVersion )
{
  int n = Reaction_getNumModifiers(pReaction);
  int dims[2] = {1, n};

  /* fields within a modifier structure */
  const int nNoFields_l2 = 4;
  const char *field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "species"};
  
  /* values */
  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacSpecies;

  ModifierSpeciesReference_t *pModifier;
  int i;

  /* create the structure array */
  mxModifierReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);

  for (i = 0; i < n; i++) {
    /* determine the values */
    pModifier       = Reaction_getModifier(pReaction, i);
    pacTypecode     = TypecodeToChar(SBase_getTypeCode((SBase_t*) pModifier));
    pacNotes        = SBase_getNotes((SBase_t*) pModifier);
    pacAnnotations  = SBase_getAnnotation((SBase_t*) pModifier);
    pacSpecies      = ModifierSpeciesReference_getSpecies(pModifier);

    /**
     * check for NULL strings - Matlab doesnt like creating 
     * a string that is NULL
     */
    if (pacSpecies == NULL) {
      pacSpecies = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }

    /* put into structure */
    mxSetField(mxModifierReturn, i, "typecode",   mxCreateString(pacTypecode)); 
    mxSetField(mxModifierReturn, i, "notes",      mxCreateString(pacNotes));
    mxSetField(mxModifierReturn, i, "annotation", mxCreateString(pacAnnotations));
    mxSetField(mxModifierReturn, i, "species",    mxCreateString(pacSpecies)); 
  }
}


/**
* NAME:       GetRule
*
* PARAMETERS: Pointer to a model
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the rule mxArray structure
*             populates the structure with all the rules in the model
*/
void
GetRule ( Model_t      *pModel,
              unsigned int unSBMLLevel,
              unsigned int unSBMLVersion )
{
  int n = Model_getNumRules(pModel);
  int dims[2] = {1, n};

  /* fields within a rule structure */
  const int nNoFields_l1 = 10;
  const char *field_names_l1[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "type",
    "formula", 
    "variable", 
    "species", 
    "compartment",
    "name", 
    "units"};

  const int nNoFields_l2 = 9;
  const char *field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "formula", 
    "variable", 
    "species", 
    "compartment",
    "name", 
    "units"};

  /* values */
  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacType = NULL;
  const char * pacFormula = NULL;
  const char * pacVariable = NULL;
  const char * pacSpecies = NULL;
  const char * pacCompartment = NULL;
  const char * pacName = NULL;
  const char * pacUnits = NULL;

  Rule_t *pRule;
  int i;

  /* variables for mathML - matlab hack */
  int nStatus, nBuflen;
  mxArray * mxInput[1], * mxOutput[1];

  /* create the structure array */
  if (unSBMLLevel == 1) {
    mxListRuleReturn = mxCreateStructArray(2, dims, nNoFields_l1, field_names_l1);
  }
  else if (unSBMLLevel == 2) {
    mxListRuleReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);
  }

  for (i = 0; i < n; i++) {
    /* determine the values */
    pRule           = Model_getRule(pModel, i);
    pacTypecode     = TypecodeToChar(SBase_getTypeCode((SBase_t*) pRule));
    pacNotes        = SBase_getNotes((SBase_t*) pRule);
    pacAnnotations  = SBase_getAnnotation((SBase_t*) pRule);
    
    if (unSBMLLevel == 1) {
      pacFormula    = Rule_getFormula(pRule);
    }
    else if (unSBMLLevel == 2) {
      if (Rule_isSetFormula(pRule) == 1){
        pacFormula  = Rule_getFormula(pRule);
      }
      else if (Rule_isSetMath(pRule) == 1) {
        Rule_setFormulaFromMath(pRule);
        pacFormula  = Rule_getFormula(pRule);
      }
    }

    /* temporary hack to convert MathML in-fix to MATLAB compatible formula */
    mxInput[0] = mxCreateString(pacFormula);
    nStatus = mexCallMATLAB(1, mxOutput, 1, mxInput, "CheckAndConvert");

    if (nStatus != 0)
    {
      mexErrMsgTxt("Failed to convert formula");
    }

    /* get the formula returned */
    nBuflen = (mxGetM(mxOutput[0])*mxGetN(mxOutput[0])+1);
    pacFormula = (char *) mxCalloc(nBuflen, sizeof(char));
    nStatus = mxGetString(mxOutput[0], (char *) pacFormula, nBuflen);

    if (nStatus != 0)
    {
      mexErrMsgTxt("Cannot copy formula");
    }

    /* END OF HACK */    
    
    /* values for different types of rules */
    switch(SBase_getTypeCode((SBase_t*) pRule)) {
      case SBML_ASSIGNMENT_RULE:
        if (unSBMLLevel == 1) {
          pacType = RuleType_toString(AssignmentRule_getType((AssignmentRule_t *) pRule));
        }

        if (AssignmentRule_isSetVariable((AssignmentRule_t *) pRule) == 1) {
          pacVariable = AssignmentRule_getVariable((AssignmentRule_t *) pRule);
        }
        else {
          pacVariable = "";
        }

        pacSpecies = "";
        pacCompartment = "";
        pacName = "";
        pacUnits = "";
      break;
      case SBML_ALGEBRAIC_RULE:
        pacVariable = "";
        pacSpecies = "";
        pacCompartment = "";
        pacName = "";
        pacUnits = "";
      break;
      case SBML_RATE_RULE:
        if (RateRule_isSetVariable((RateRule_t *) pRule) == 1) {
          pacVariable = RateRule_getVariable((RateRule_t *) pRule);
        }
        else {
          pacVariable = "";
        }

        pacSpecies = "";
        pacCompartment = "";
        pacName = "";
        pacUnits = "";
      break;
      case SBML_SPECIES_CONCENTRATION_RULE:
        if (unSBMLLevel == 1) {
          pacType = RuleType_toString(AssignmentRule_getType((AssignmentRule_t *) pRule));
        }

        pacVariable = "";
 
        if (SpeciesConcentrationRule_isSetSpecies((SpeciesConcentrationRule_t *) pRule) == 1) {
          pacSpecies = SpeciesConcentrationRule_getSpecies((SpeciesConcentrationRule_t *) pRule);
        }
        else {
          pacSpecies = "";
        }

        pacCompartment = "";
        pacName = "";
        pacUnits = "";
      break;
      case SBML_COMPARTMENT_VOLUME_RULE:
        if (unSBMLLevel == 1) {
          pacType = RuleType_toString(AssignmentRule_getType((AssignmentRule_t *) pRule));
        }

        pacVariable = "";
        pacSpecies = "";

        if (CompartmentVolumeRule_isSetCompartment((CompartmentVolumeRule_t *) pRule) == 1) {
          pacCompartment = CompartmentVolumeRule_getCompartment((CompartmentVolumeRule_t *) pRule);
        }
        else {
          pacCompartment = "";
        }
      
        pacName = "";
        pacUnits = "";
      break;
      case SBML_PARAMETER_RULE:
        if (unSBMLLevel == 1) {
          pacType = RuleType_toString(AssignmentRule_getType((AssignmentRule_t *) pRule));
        }

        pacVariable = "";
        pacSpecies = "";
        pacCompartment = "";

        if (ParameterRule_isSetName((ParameterRule_t *)pRule) == 1) {
          pacName = ParameterRule_getName((ParameterRule_t *) pRule);
        }
        else {
          pacName = "";
        }
    
        if (ParameterRule_isSetUnits((ParameterRule_t *) pRule) == 1) {
          pacUnits = ParameterRule_getUnits((ParameterRule_t *) pRule);
        }
        else {
          pacUnits = "";
        }
      break;
      default:
        pacVariable = "";
        pacSpecies = "";
        pacCompartment = "";
        pacName = "";
        pacUnits = "";
      break;
    }

    /**
     * check for NULL strings - Matlab doesnt like creating 
     * a string that is NULL
     */
    if (pacTypecode == NULL) {
      pacTypecode = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }
    if (pacFormula == NULL) {
      pacFormula = "";
    }
    if (pacType == NULL) {
      pacType = "";
    }

    /* put into structure */
    mxSetField(mxListRuleReturn, i, "typecode",    mxCreateString(pacTypecode)); 
    mxSetField(mxListRuleReturn, i, "notes",       mxCreateString(pacNotes));
    mxSetField(mxListRuleReturn, i, "annotation",  mxCreateString(pacAnnotations));
  
    if (unSBMLLevel == 1){
      mxSetField(mxListRuleReturn, i, "type",      mxCreateString(pacType));
    }
  
    mxSetField(mxListRuleReturn, i, "formula",     mxCreateString(pacFormula)); 
    mxSetField(mxListRuleReturn, i, "variable",    mxCreateString(pacVariable)); 
    mxSetField(mxListRuleReturn, i, "species",     mxCreateString(pacSpecies)); 
    mxSetField(mxListRuleReturn, i, "compartment", mxCreateString(pacCompartment)); 
    mxSetField(mxListRuleReturn, i, "name",        mxCreateString(pacName)); 
    mxSetField(mxListRuleReturn, i, "units",       mxCreateString(pacUnits)); 
  }  
}


/**
* NAME:       GetFunctionDefinition
*
* PARAMETERS: Pointer to a model
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the function definition mxArray structure
*             populates the structure with all the function definition in
*             the model
*/
void
GetFunctionDefinition ( Model_t      *pModel,
                        unsigned int unSBMLLevel,
                        unsigned int unSBMLVersion )
{
  int n = Model_getNumFunctionDefinitions(pModel);
  int dims[2] = {1, n};

  /* fields within a function definition structure */
  const int nNoFields_l2 = 6;
  const char * field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "name", 
    "id", 
    "math"};

  /* values */
  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacName;
  const char * pacId = NULL;
  const char * pacFormula;

  FunctionDefinition_t *pFuncDefinition;
  int i;

  /* variables for mathML - matlab hack */
  int nStatus, nBuflen;
  mxArray * mxInput[1], * mxOutput[1];

  /* create the structure array */
  mxFunctionDefReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);

  for (i = 0; i < n; i++) {
    /* determine the values */
    pFuncDefinition     = Model_getFunctionDefinition(pModel, i);
    pacTypecode         = TypecodeToChar(SBase_getTypeCode((SBase_t *) pFuncDefinition));
    pacNotes            = SBase_getNotes((SBase_t *) pFuncDefinition);
    pacAnnotations      = SBase_getAnnotation((SBase_t *) pFuncDefinition);
    pacName             = FunctionDefinition_getName(pFuncDefinition);
    pacId               = FunctionDefinition_getId(pFuncDefinition);

    if (FunctionDefinition_isSetMath(pFuncDefinition)) {
      pacFormula        = SBML_formulaToString(FunctionDefinition_getMath(pFuncDefinition));
    }
    /* temporary hack to convert MathML in-fix to MATLAB compatible formula */

    mxInput[0] = mxCreateString(pacFormula);
    nStatus = mexCallMATLAB(1, mxOutput, 1, mxInput, "CheckAndConvert");

    if (nStatus != 0)
    {
      mexErrMsgTxt("Failed to convert formula");
    }

    /* get the formula returned */
    nBuflen = (mxGetM(mxOutput[0])*mxGetN(mxOutput[0])+1);
    pacFormula = (char *) mxCalloc(nBuflen, sizeof(char));
    nStatus = mxGetString(mxOutput[0], (char *) pacFormula, nBuflen);

    if (nStatus != 0)
    {
      mexErrMsgTxt("Cannot copy formula");
    }

    /* END OF HACK */
    /**
     * check for NULL strings - Matlab doesnt like creating
     * a string that is NULL
     */
    if (pacName == NULL) {
      pacName = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }
    if (pacId == NULL) {
      pacId = "";
    }
    if (pacFormula == NULL) {
      pacFormula = "";
    }

    /* put into structure */
    mxSetField(mxFunctionDefReturn, i, "typecode",    mxCreateString(pacTypecode)); 
    mxSetField(mxFunctionDefReturn, i, "notes",       mxCreateString(pacNotes));
    mxSetField(mxFunctionDefReturn, i, "annotation",  mxCreateString(pacAnnotations));
    mxSetField(mxFunctionDefReturn, i, "name",        mxCreateString(pacName)); 
    mxSetField(mxFunctionDefReturn, i, "id",          mxCreateString(pacId)); 
    mxSetField(mxFunctionDefReturn, i, "math",        mxCreateString(pacFormula)); 
  }
}


/**
* NAME:       GetEvent
*
* PARAMETERS: Pointer to a model
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:  creates the event mxArray structure
*            populates the structure with all the events in the model
*/
void
GetEvent (Model_t      *pModel,
          unsigned int unSBMLLevel,
          unsigned int unSBMLVersion )
{
  int n = Model_getNumEvents(pModel);
  int dims[2] = {1, n};

  /* fields within a event structure */
  const int nNoFields_l2 = 9;
  const char * field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "name", 
    "id", 
    "trigger", 
    "delay", 
    "timeUnits", 
    "eventAssignment"};

  /* values */
  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacName;
  const char * pacId = NULL;
  const char * pacTrigger = NULL;
  const char * pacDelay = NULL;
  const char * pacTimeUnits = NULL;

  Event_t *pEvent;
  int i;

  /* variables for mathML - matlab hack */
  int nStatus, nBuflen;
  mxArray * mxInput[1], * mxOutput[1];

  /* create the structure array */
  mxEventReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);

  for (i = 0; i < n; i++) {
    /* determine the values */
    pEvent          = Model_getEvent(pModel, i);
    pacTypecode     = TypecodeToChar(SBase_getTypeCode((SBase_t *) pEvent));
    pacNotes        = SBase_getNotes((SBase_t *) pEvent);
    pacAnnotations  = SBase_getAnnotation((SBase_t *) pEvent);
    pacName         = Event_getName(pEvent);
    pacId           = Event_getId(pEvent);
    pacTimeUnits    = Event_getTimeUnits(pEvent);

    GetEventAssignment(pEvent, unSBMLLevel, unSBMLVersion);
 
    if (Event_isSetTrigger(pEvent)) {
      pacTrigger    = SBML_formulaToString(Event_getTrigger(pEvent));
    }

    if (Event_isSetDelay(pEvent)) {
      pacDelay      = SBML_formulaToString(Event_getDelay(pEvent));
    }

    /* temporary hack to convert MathML in-fix to MATLAB compatible formula 
     *   TRIGGER FUNCTION 
     */

    mxInput[0] = mxCreateString(pacTrigger);
    nStatus = mexCallMATLAB(1, mxOutput, 1, mxInput, "CheckAndConvert");

    if (nStatus != 0)
    {
      mexErrMsgTxt("Failed to convert formula");
    }

    /* get the formula returned */
    nBuflen = (mxGetM(mxOutput[0])*mxGetN(mxOutput[0])+1);
    pacTrigger = (char *) mxCalloc(nBuflen, sizeof(char));
    nStatus = mxGetString(mxOutput[0], (char *) pacTrigger, nBuflen);

    if (nStatus != 0)
    {
      mexErrMsgTxt("Cannot copy formula");
    }

    /* END OF HACK */


    /* temporary hack to convert MathML in-fix to MATLAB compatible formula 
     * DELAY FUNCTION
     */

    mxInput[0] = mxCreateString(pacDelay);
    nStatus = mexCallMATLAB(1, mxOutput, 1, mxInput, "CheckAndConvert");

    if (nStatus != 0)
    {
      mexErrMsgTxt("Failed to convert formula");
    }

    /* get the formula returned */
    nBuflen = (mxGetM(mxOutput[0])*mxGetN(mxOutput[0])+1);
    pacDelay = (char *) mxCalloc(nBuflen, sizeof(char));
    nStatus = mxGetString(mxOutput[0], (char *) pacDelay, nBuflen);

    if (nStatus != 0)
    {
      mexErrMsgTxt("Cannot copy formula");
    }

    /* END OF HACK */


    /**        
     * check for NULL strings - Matlab doesnt like creating 
     * a string that is NULL
     */
    if (pacName == NULL) {
      pacName = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }
    if (pacId == NULL) {
      pacId = "";
    }
    if (pacTimeUnits == NULL) {
      pacTimeUnits = "";
    }
    if (pacTrigger == NULL) {
      pacTrigger = "";
    }
    if (pacDelay == NULL) {
      pacDelay = "";
    }

    /* put into structure */
    mxSetField(mxEventReturn, i, "typecode",        mxCreateString(pacTypecode)); 
    mxSetField(mxEventReturn, i, "notes",           mxCreateString(pacNotes));
    mxSetField(mxEventReturn, i, "annotation",      mxCreateString(pacAnnotations));
    mxSetField(mxEventReturn, i, "name",            mxCreateString(pacName)); 
    mxSetField(mxEventReturn, i, "id",              mxCreateString(pacId)); 
    mxSetField(mxEventReturn, i, "trigger",         mxCreateString(pacTrigger)); 
    mxSetField(mxEventReturn, i, "delay",           mxCreateString(pacDelay)); 
    mxSetField(mxEventReturn, i, "timeUnits",       mxCreateString(pacTimeUnits)); 
    mxSetField(mxEventReturn, i, "eventAssignment", mxEventAssignReturn); 

    mxEventAssignReturn = NULL;
  }
}


/**
* NAME:       GetEventAssignment
*
* PARAMETERS: Pointer to a event
*             unSBMLLevel
*             unSBMLVersion - included for possible expansion needs
*
* RETURNS:    void
*
* FUNCTION:   creates the event assignment mxArray structure
*             populates the structure with all the event assignments
*             in the event
*/
void
GetEventAssignment (  Event_t      *pEvent,
                      unsigned int unSBMLLevel,
                      unsigned int unSBMLVersion )
{
  int n = Event_getNumEventAssignments(pEvent);
  int dims[2] = {1, n};

  const int nNoFields_l2 = 5;
  const char *field_names_l2[] = {	
    "typecode", 
    "notes", 
    "annotation",
    "variable", 
    "math"};
  
  /* values */
  const char * pacTypecode;
  const char * pacNotes;
  const char * pacAnnotations;
  const char * pacVariable;
  const char * pacFormula;

  EventAssignment_t * pEventAssignment;
  int i;

  mxEventAssignReturn = mxCreateStructArray(2, dims, nNoFields_l2, field_names_l2);

  for (i = 0; i < n; i++) {
    /* determine the values */
    pEventAssignment  = Event_getEventAssignment(pEvent, i);
    pacTypecode       = TypecodeToChar(SBase_getTypeCode((SBase_t *) pEventAssignment));
    pacNotes          = SBase_getNotes((SBase_t *) pEventAssignment);
    pacAnnotations    = SBase_getAnnotation((SBase_t *) pEventAssignment);
    pacVariable       = EventAssignment_getVariable(pEventAssignment);

    if (EventAssignment_isSetMath(pEventAssignment)) {
      pacFormula      = SBML_formulaToString(EventAssignment_getMath(pEventAssignment));
    }

    /**
     * check for NULL strings - Matlab doesnt like creating 
     * a string that is NULL
     */
    if (pacVariable == NULL) {
      pacVariable = "";
    }
    if (pacNotes == NULL) {
      pacNotes = "";
    }
    if (pacAnnotations == NULL) {
      pacAnnotations = "";
    }
    if (pacFormula == NULL) {
      pacFormula = "";
    }

    /* put into structure */
    mxSetField(mxEventAssignReturn, i, "typecode",    mxCreateString(pacTypecode)); 
    mxSetField(mxEventAssignReturn, i, "notes",       mxCreateString(pacNotes));
    mxSetField(mxEventAssignReturn, i, "annotation",  mxCreateString(pacAnnotations));
    mxSetField(mxEventAssignReturn, i, "variable",    mxCreateString(pacVariable)); 
    mxSetField(mxEventAssignReturn, i, "math",        mxCreateString(pacFormula)); 
  }
}
