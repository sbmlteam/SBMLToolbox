/**
 * Filename    : OutputSBML.c
 * Description : MATLAB code for translating SBML-MATLAB structure into a SBML document
 * Author(s)   : SBML Development Group <sbml-team@caltech.edu>
 * Organization: University of Hertfordshire STRC
 * Created     : 2004-08-23
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
 *     Science and Technology Research Institute
 *     University of Hertfordshire
 *     Hatfield, AL10 9AB
 *     United Kingdom
 *
 *     http://www.sbml.org
 *     mailto:sbml-team@caltech.edu
 *
 * Contributor(s): 
 */
#include <mex.h>
#include <matrix.h>

#include <string.h>

#include "sbml/SBMLReader.h"
#include "sbml/SBMLTypes.h"

/* function declarations */
SBMLTypeCode_t  CharToTypecode (char *);

void  GetParameter			( mxArray *, unsigned int, unsigned int, Model_t * );
void  GetCompartment		( mxArray *, unsigned int, unsigned int, Model_t * );
void  GetFunctionDefinition	( mxArray *, unsigned int, unsigned int, Model_t * );
void  GetUnitDefinition		( mxArray *, unsigned int, unsigned int, Model_t * );
void  GetSpecies			( mxArray *, unsigned int, unsigned int, Model_t * );
void  GetRule				( mxArray *, unsigned int, unsigned int, Model_t * );
void  GetReaction			( mxArray *, unsigned int, unsigned int, Model_t * );
void  GetEvent              ( mxArray *, unsigned int, unsigned int, Model_t * );

void  GetEventAssignment ( mxArray *, unsigned int, unsigned int, Event_t * );


void GetUnit ( mxArray *, unsigned int, unsigned int, UnitDefinition_t * );

void GetSpeciesReference	( mxArray *, unsigned int, unsigned int, Reaction_t *, int);
void GetProduct				( mxArray *, unsigned int, unsigned int, Reaction_t * );
void GetKineticLaw			( mxArray *, unsigned int, unsigned int, Reaction_t * );
void GetModifier			( mxArray *, unsigned int, unsigned int, Reaction_t * );

void GetParameterFromKineticLaw ( mxArray *, unsigned int, unsigned int, KineticLaw_t * );


mxArray * mxModel[1];

void FreeMem(void)
{
	/* destroy arrays created */
	mxDestroyArray(mxModel[0]);
}

/**
 * NAME:    mexFunction
 *
 * PARAMETERS:  int     nlhs     -  number of output arguments  
 *              mxArray *plhs[]  -  output arguments
 *              int     nrhs     -  number of input arguments
 *              mxArray *prhs[]  -  input arguments
 *
 * RETURNS:    
 *
 * FUNCTION:  MATLAB standard dll export function
 *            any returns are made through the mxArray * plhs
 */
void
mexFunction (int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

	mxArray * mxCheckStructure[1];
	mxArray * mxFilename[2], * mxExt[1];
	int nStatus;
	char *pacFilename, *pacTempString1, *pacTempString2;
  int nBuflen, nBufferLen;
	
	SBMLDocument_t *sbmlDocument;
	Model_t *sbmlModel;


	mxArray * mxLevel, * mxVersion,* mxTypecode, * mxNotes, * mxAnnotations, * mxName, *mxId;
	unsigned int nLevel, nVersion;
	char * pacTypecode, * pacNotes, * pacAnnotations, * pacAnnotationString, * pacName, * pacId;
	
	mxArray * mxParameters, * mxCompartments, * mxFunctionDefinitions, *mxUnitDefinitions;
	mxArray * mxSpecies, * mxRules, * mxReactions, * mxEvents;


/*************************************************************************************
	* validate inputs and outputs
	**********************************************************************************/
  if (nrhs < 1)
  {
      mexErrMsgTxt("Must supply at least the model as an output argument\nUSAGE: OutputSBML(SBMLModel, (filename))");
  }

/**
	* create a copy of the input
	*/	
	mxModel[0] = mxDuplicateArray(prhs[0]);
    mexMakeArrayPersistent(mxModel[0]);
	mexAtExit(FreeMem);

/**
	* check number and type of output arguments
	* SHOULDNT BE ANY
	*/
	if (nlhs > 0)
	{
		mexErrMsgTxt("Too many output arguments\nUSAGE: OutputSBML(SBMLModel, (filename))");
	}

/**
	* check number and type of input arguments
	* must be a valid Matlab_SBML structure
	* and optionally the filename
	*/
  
	if (nrhs > 2)
	{
		mexErrMsgTxt("Too many input arguments\nUSAGE: OutputSBML(SBMLModel, (filename))");
	}
  
	nStatus = mexCallMATLAB(1, mxCheckStructure, 1, mxModel, "isSBML_Model");
	
	if ((nStatus != 0) || (mxIsLogicalScalarTrue(mxCheckStructure[0]) != 1))
	{
		mexErrMsgTxt("First input must be a valid MATLAB_SBML Structure\nUSAGE: OutputSBML(SBMLModel, (filename))");
	}

  if (nrhs == 2)
  {
	
	  if (mxIsChar(prhs[1]) != 1)
	  {
	      mexErrMsgTxt("Second input must be a filename\nUSAGE: OutputSBML(SBMLModel, (filename))");
	  }

    nBuflen = (mxGetM(prhs[1])*mxGetN(prhs[1])+1);
    pacFilename = (char *)mxCalloc(nBuflen, sizeof(char));
    nStatus = mxGetString(prhs[1], pacFilename, nBuflen);
  
    if (nStatus != 0)
    {
        mexErrMsgTxt("Cannot copy filename");
    }

  }
/*********************************************************************************************************
	* get the details of the model
	***********************************************************************************************************/

/**
	* get the SBML level and version from the structure
	* and create the document with these
    */

	mxLevel = mxGetField(mxModel[0], 0, "SBML_level");
	nLevel = (unsigned int) mxGetScalar(mxLevel);

	mxVersion = mxGetField(mxModel[0], 0, "SBML_version");
	nVersion = (unsigned int) mxGetScalar(mxVersion);

  sbmlDocument = SBMLDocument_createWith(nLevel, nVersion);

	
	/* create a model within the document */
  sbmlModel = SBMLDocument_createModel(sbmlDocument);


	/* get typecode */
	mxTypecode = mxGetField(mxModel[0], 0, "typecode");
  nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
  pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
  nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);
  
  if (nStatus != 0)
  {
      mexErrMsgTxt("Cannot copy typecode");
  }

	/*SBase_init(sbmlModel, CharToTypecode(pacTypecode)); */

	
	/* get notes */
	mxNotes = mxGetField(mxModel[0], 0, "notes");
  nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
  pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
  nStatus = mxGetString(mxNotes, pacNotes, nBuflen);
  
  if (nStatus != 0)
  {
      mexErrMsgTxt("Cannot copy notes");
  }

	/*SBase_setNotes(sbmlModel, pacNotes); */

	
  /* get annotations  */
  mxAnnotations = mxGetField(mxModel[0], 0, "annotation");
  nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
  pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
  
  nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);
  
  if (nStatus != 0)
  {
      mexErrMsgTxt("Cannot copy annotations");
  }

  /* add the tags to the annotation string */
  if (strcmp(pacAnnotations, ""))
  {
      pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
      strcpy(pacAnnotationString, "<annotation>\n\t\t");
      strcat(pacAnnotationString, pacAnnotations);
      strcat(pacAnnotationString, "\n\t</annotation>");
  }
  else
  {
      pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));    
  }

	/*SBase_setAnnotation(sbmlModel, pacAnnotationString); */

	/* get name */
	mxName = mxGetField(mxModel[0], 0, "name");
  nBuflen = (mxGetM(mxName)*mxGetN(mxName)+1);
  pacName = (char *)mxCalloc(nBuflen, sizeof(char));
  nStatus = mxGetString(mxName, pacName, nBuflen);
  
  if (nStatus != 0)
  {
      mexErrMsgTxt("Cannot copy name");
  }

	Model_setName(sbmlModel, pacName);

	mxCompartments = mxGetField(mxModel[0], 0, "compartment");
	GetCompartment(mxCompartments, nLevel, nVersion, sbmlModel);

	mxParameters = mxGetField(mxModel[0], 0, "parameter");
	GetParameter(mxParameters, nLevel, nVersion, sbmlModel);
    
  mxSpecies = mxGetField(mxModel[0], 0, "species");
	GetSpecies(mxSpecies, nLevel, nVersion, sbmlModel);

  mxRules = mxGetField(mxModel[0], 0, "rule");
	GetRule(mxRules, nLevel, nVersion, sbmlModel);

  mxUnitDefinitions = mxGetField(mxModel[0], 0, "unitDefinition");
  GetUnitDefinition(mxUnitDefinitions, nLevel, nVersion, sbmlModel);

  mxReactions = mxGetField(mxModel[0], 0, "reaction");
	GetReaction(mxReactions, nLevel, nVersion, sbmlModel);

	/* level 2 only */
	if (nLevel == 2)
	{
		/* get id */
		mxId = mxGetField(mxModel[0], 0, "id");
		nBuflen = (mxGetM(mxId)*mxGetN(mxId)+1);
		pacId = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxId, pacId, nBuflen);
    
		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy id");
		}

		Model_setId(sbmlModel, pacId);

		mxFunctionDefinitions = mxGetField(mxModel[0], 0, "functionDefinition");
		GetFunctionDefinition(mxFunctionDefinitions, nLevel, nVersion, sbmlModel);

    mxEvents = mxGetField(mxModel[0], 0, "event");
		GetEvent(mxEvents, nLevel, nVersion, sbmlModel);
	}


/************************************************************************************************************
	* output the resulting model to specified file
	*********************************************************************************************************/

	if (nrhs == 1) 
	{
   /**
	  * prompt user for a filename 
	  * and write the document to this
	  */

	  /* extension to look for */
    mxExt[0] = mxCreateString(".xml");
    nStatus = mexCallMATLAB(2, mxFilename, 1, mxExt, "uiputfile");
    
    if (nStatus != 0)
    {
      mexErrMsgTxt("Failed to read filename");
    }

    /* get the filename returned */ 
    nBuflen = (mxGetM(mxFilename[0])*mxGetN(mxFilename[0])+1);
    pacTempString1 = (char *)mxCalloc(nBuflen, sizeof(char));
    nStatus = mxGetString(mxFilename[0], pacTempString1, nBuflen);
  
    if (nStatus != 0)
    {
      mexErrMsgTxt("Cannot copy filename");
    }

	  /* get the full path */
    nBufferLen = (mxGetM(mxFilename[1])*mxGetN(mxFilename[1])+1);
    pacTempString2 = (char *)mxCalloc(nBufferLen, sizeof(char));
    nStatus = mxGetString(mxFilename[1], pacTempString2, nBufferLen);
  
    if (nStatus != 0)
    {
      mexErrMsgTxt("Cannot copy path");
    }

	  /* write full path and filename */
    pacFilename = (char *) mxCalloc(nBufferLen+nBuflen+4, sizeof(char));
	  strcpy(pacFilename, pacTempString2);
    strcat(pacFilename, pacTempString1);

	  /* check that the extension has been used  */
	  if (strstr(pacFilename, ".xml") == NULL)
	  {
  		strcat(pacFilename, ".xml");
	  }
 	}
	else
	{
	  /* 
	   * user has specified a filename
	   * /
	  
	  /* check that the extension has been used  */
	  if (strstr(pacFilename, ".xml") == NULL)
	  {
		  strcat(pacFilename, ".xml");
	  }
	}

  /* write the SBML document to the filename specified */
	nStatus = writeSBML(sbmlDocument, pacFilename);
	mexPrintf("Document written\n");

	if (nStatus != 1)
	{
		mexErrMsgTxt("Failed to write file");
	}
	
	/* free any memory allocated */
	mxFree(pacTypecode);
	mxFree(pacNotes);
	mxFree(pacAnnotations);
	mxFree(pacAnnotationString);
	mxFree(pacName);
	mxFree(pacFilename);

  if (nrhs == 1)
  {
    mxFree(pacTempString1);
    mxFree(pacTempString2);
    mxDestroyArray(mxFilename[0]);
    mxDestroyArray(mxFilename[1]);
    mxDestroyArray(mxExt[0]);
  }
	mxDestroyArray(mxCheckStructure[0]);

	SBMLDocument_free(sbmlDocument);
}

/**
 * NAME:    CharToTypecode
 *
 * PARAMETERS:  char * 
 *
 * RETURNS:    SBMLTypeCode_t typecode
 *
 * FUNCTION:  converts typecode string to SBMLTypeCode
 */
SBMLTypeCode_t
CharToTypecode (char * pacTypecode)
{
	SBMLTypeCode_t typecode;
	unsigned int nIndex;

	const char * Typecodes[] =
	{
		"SBML_COMPARTMENT",
		"SBML_EVENT",
		"SBML_EVENT_ASSIGNMENT",
		"SBML_FUNCTION_DEFINITION",
		"SBML_KINETIC_LAW",
		"SBML_MODEL",
		"SBML_PARAMETER",
		"SBML_REACTION",
		"SBML_SPECIES",
		"SBML_SPECIES_REFERENCE",
		"SBML_MODIFIER_SPECIES_REFERENCE",
		"SBML_UNIT_DEFINITION",
		"SBML_UNIT",
		"SBML_ASSIGNMENT_RULE",
		"SBML_ALGEBRAIC_RULE",
		"SBML_RATE_RULE",
		"SBML_SPECIES_CONCENTRATION_RULE",
		"SBML_COMPARTMENT_VOLUME_RULE",
		"SBML_PARAMETER_RULE",
	};

	nIndex = 0;
	while (nIndex < 19)
	{
		if (strcmp(pacTypecode, Typecodes[nIndex]) == 0)
		{
			break;
		}
		nIndex++;
	}

  switch (nIndex)
  {
    case 0:
      typecode = SBML_COMPARTMENT;
      break;

    case 1:
      typecode = SBML_EVENT;
      break;

    case 2:
      typecode = SBML_EVENT_ASSIGNMENT;
      break;

    case 3:
      typecode = SBML_FUNCTION_DEFINITION;
      break;

    case 4:
      typecode = SBML_KINETIC_LAW;
      break;

    case 5:
      typecode = SBML_MODEL;
      break;

    case 6:
      typecode = SBML_PARAMETER;
      break;

    case 7:
      typecode = SBML_REACTION;
      break;

    case 8:
      typecode = SBML_SPECIES;
      break;

    case 9:
      typecode = SBML_SPECIES_REFERENCE;
      break;

    case 10:
      typecode = SBML_MODIFIER_SPECIES_REFERENCE;
      break;    

    case 11:
      typecode = SBML_UNIT_DEFINITION;
      break;

    case 12:
      typecode = SBML_UNIT;
      break;

    case 13:
      typecode = SBML_ASSIGNMENT_RULE;
      break;

    case 14:
      typecode = SBML_ALGEBRAIC_RULE;
      break;

    case 15:
      typecode = SBML_RATE_RULE;
      break;

    case 16:
      typecode = SBML_SPECIES_CONCENTRATION_RULE;
      break;

    case 17:
      typecode = SBML_COMPARTMENT_VOLUME_RULE;
      break;

    case 18:
      typecode = SBML_PARAMETER_RULE;
      break;

    default:
      mexErrMsgTxt("error in typecode");
      break;
  }

  return typecode;
}
/**
 * NAME:    GetCompartment
 *
 * PARAMETERS:  mxArray of compartment structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the model
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the compartment mxArray structure
 *        and adds each compartment to the model
 *
 */
void
GetCompartment (mxArray * mxCompartments,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			         Model_t * sbmlModel)
{
	int nNoCompartments = mxGetNumberOfElements(mxCompartments);

	int nStatus;
	int nBuflen;

	/* field values */
	char * pacTypecode;
	char * pacNotes;
	char * pacAnnotations;
  char * pacAnnotationString;
	char * pacName;
	char * pacId;
	double dVolume;
	unsigned int unSpatialDimensions;
	double dSize;
	char * pacUnits;
	char * pacOutside;
	int nConstant;
	unsigned int unIsSetVolume;
	unsigned int unIsSetSize;

	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxName, * mxId, * mxUnits;
	mxArray * mxOutside, * mxVolume, * mxIsSetVolume, * mxSpatialDimensions, * mxSize, * mxConstant, * mxIsSetSize;

	
	Compartment_t *pCompartment;
	int i;

	for (i = 0; i < nNoCompartments; i++) {

 		pCompartment = Compartment_create();

		/* get typecode */
		mxTypecode = mxGetField(mxCompartments, i, "typecode");
		nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
		pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy typecode");
		}

		/*SBase_init(pCompartment, CharToTypecode(pacTypecode)); */


		/* get notes */
		mxNotes = mxGetField(mxCompartments, i, "notes");
		nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
		pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxNotes, pacNotes, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy notes");
		}

		/*SBase_setNotes(pCompartment, pacNotes); */


		/* get annotations */
		mxAnnotations = mxGetField(mxCompartments, i, "annotation");
		nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
		pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy annotations");
		}

    /* add the tags to the annotation string */
    if (strcmp(pacAnnotations, ""))
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
        strcpy(pacAnnotationString, "<annotation>\n\t\t\t");
        strcat(pacAnnotationString, pacAnnotations);
        strcat(pacAnnotationString, "\n\t\t</annotation>");
    }
    else
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
    }

		/*SBase_setAnnotation(pCompartment, pacAnnotationString); */


		/* get name */
		mxName = mxGetField(mxCompartments, i, "name");
		nBuflen = (mxGetM(mxName)*mxGetN(mxName)+1);
		pacName = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxName, pacName, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy name");
		}

		Compartment_setName(pCompartment, pacName);


		/* get units */
		mxUnits = mxGetField(mxCompartments, i, "units");
		nBuflen = (mxGetM(mxUnits)*mxGetN(mxUnits)+1);
		pacUnits = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxUnits, pacUnits, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy units");
		}

		Compartment_setUnits(pCompartment, pacUnits);


		/* get outside */
		mxOutside = mxGetField(mxCompartments, i, "outside");
		nBuflen = (mxGetM(mxOutside)*mxGetN(mxOutside)+1);
		pacOutside = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxOutside, pacOutside, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy outside");
		}

		Compartment_setOutside(pCompartment, pacOutside);


		/* get isSetVolume */
		mxIsSetVolume = mxGetField(mxCompartments, i, "isSetVolume");
		unIsSetVolume = (unsigned int)mxGetScalar(mxIsSetVolume);


		/* level 1 only */
		if (unSBMLLevel == 1)
		{
			/* get volume */
			mxVolume = mxGetField(mxCompartments, i, "volume");
			dVolume = mxGetScalar(mxVolume);

			if (unIsSetVolume == 1) {
				Compartment_setVolume(pCompartment, dVolume);
			}
		
		}

		/* level 2 only */
		if (unSBMLLevel == 2)
		{
			/* get id */
			mxId = mxGetField(mxCompartments, i, "id");
			nBuflen = (mxGetM(mxId)*mxGetN(mxId)+1);
			pacId = (char *)mxCalloc(nBuflen, sizeof(char));
			nStatus = mxGetString(mxId, pacId, nBuflen);

			if (nStatus != 0)
			{
				mexErrMsgTxt("Cannot copy id");
			}

			Compartment_setId(pCompartment, pacId);
		
			
			/* get constant */
			mxConstant = mxGetField(mxCompartments, i, "constant");
			nConstant = (int)mxGetScalar(mxConstant);

			Compartment_setConstant(pCompartment, nConstant);

			/* get spatialdimensions */
			mxSpatialDimensions = mxGetField(mxCompartments, i, "spatialDimensions");
			unSpatialDimensions = (unsigned int)mxGetScalar(mxSpatialDimensions);

			Compartment_setSpatialDimensions(pCompartment, unSpatialDimensions);

			/* get isSetSize */
			mxIsSetSize = mxGetField(mxCompartments, i, "isSetSize");
			unIsSetSize = (unsigned int)mxGetScalar(mxIsSetSize);

			
			/* get size */
			mxSize = mxGetField(mxCompartments, i, "size");
			dSize = mxGetScalar(mxSize);

			if (unIsSetSize == 1) {
				Compartment_setSize(pCompartment, dSize);
			}
		}

		/* add the compartment to the model */
		Model_addCompartment(sbmlModel, pCompartment);

    /* free any memory allocated */
	  mxFree(pacTypecode);
	  mxFree(pacNotes);
	  mxFree(pacAnnotations);
	  mxFree(pacAnnotationString);
	  mxFree(pacName);
  	mxFree(pacUnits);
  	mxFree(pacOutside);
		/* level 2 only */
		if (unSBMLLevel == 2)
		{
  	  mxFree(pacId);
    }
	}
}
/**
 * NAME:    GetParameter
 *
 * PARAMETERS:  mxArray of parameter structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the model
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the parameter mxArray structure
 *        and adds each parameter to the model
 *
 */
 void
 GetParameter ( mxArray * mxParameters,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			         Model_t * sbmlModel)
{
	int nNoParameters = mxGetNumberOfElements(mxParameters);

	int nStatus;
	int nBuflen;

	char * pacTypecode;
	char * pacNotes;
	char * pacAnnotations;
  char * pacAnnotationString;
	char * pacName;
	char * pacId;
	double dValue;
	char * pacUnits;
	unsigned int unIsSetValue;
	int nConstant;

	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxName, * mxId, * mxUnits;
	mxArray * mxValue, * mxIsSetValue, * mxConstant;

	Parameter_t *pParameter;

	int i;

	for (i = 0; i < nNoParameters; i++) 
	{

		pParameter = Parameter_create();

		/* get typecode */
		mxTypecode = mxGetField(mxParameters, i, "typecode");
		nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
		pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy typecode");
		}

		/*SBase_init(pParameter, CharToTypecode(pacTypecode)); */


		/* get notes */
		mxNotes = mxGetField(mxParameters, i, "notes");
		nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
		pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxNotes, pacNotes, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy notes");
		}

		/*SBase_setNotes(pParameter, pacNotes); */


		/* get annotations */
		mxAnnotations = mxGetField(mxParameters, i, "annotation");
		nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
		pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy annotations");
		}
   
    /* add the tags to the annotation string */
    if (strcmp(pacAnnotations, ""))
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
        strcpy(pacAnnotationString, "<annotation>\n\t\t\t");
        strcat(pacAnnotationString, pacAnnotations);
        strcat(pacAnnotationString, "\n\t\t</annotation>");
    }
    else
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
    }

		/*SBase_setAnnotation(pParameter, pacAnnotationString); */


		/* get name */
		mxName = mxGetField(mxParameters, i, "name");
		nBuflen = (mxGetM(mxName)*mxGetN(mxName)+1);
		pacName = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxName, pacName, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy name");
		}

		Parameter_setName(pParameter, pacName);


		/* get units */
		mxUnits = mxGetField(mxParameters, i, "units");
		nBuflen = (mxGetM(mxUnits)*mxGetN(mxUnits)+1);
		pacUnits = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxUnits, pacUnits, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy units");
		}

		Parameter_setUnits(pParameter, pacUnits);


		/* get isSetValue */
		mxIsSetValue = mxGetField(mxParameters, i, "isSetValue");
		unIsSetValue = (unsigned int)mxGetScalar(mxIsSetValue);


		/* get value */
		mxValue = mxGetField(mxParameters, i, "value");
		dValue = mxGetScalar(mxValue);

		if (unIsSetValue == 1) {
			Parameter_setValue(pParameter, dValue);
		}


		/* level 2 */
		if (unSBMLLevel == 2)
		{
			/* get id */
			mxId = mxGetField(mxParameters, i, "id");
			nBuflen = (mxGetM(mxId)*mxGetN(mxId)+1);
			pacId = (char *)mxCalloc(nBuflen, sizeof(char));
			nStatus = mxGetString(mxId, pacId, nBuflen);

			if (nStatus != 0)
			{
				mexErrMsgTxt("Cannot copy id");
			}

			Parameter_setId(pParameter, pacId);
		
			
			/* get constant */
			mxConstant = mxGetField(mxParameters, i, "constant");
			nConstant = (int)mxGetScalar(mxConstant);

			Parameter_setConstant(pParameter, nConstant);
		}

		/* add the parameter to the model */
		Model_addParameter(sbmlModel, pParameter);

    /* free any memory allocated */
	  mxFree(pacTypecode);
	  mxFree(pacNotes);
	  mxFree(pacAnnotations);
	  mxFree(pacAnnotationString);
	  mxFree(pacName);
  	mxFree(pacUnits);
		/* level 2 only */
		if (unSBMLLevel == 2)
		{
  	  mxFree(pacId);
    }
	}

}
/**
 * NAME:    GetSpecies
 *
 * PARAMETERS:  mxArray of species structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the model
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the species mxArray structure
 *        and adds each species to the model
 *
 */
 void
 GetSpecies ( mxArray * mxSpecies,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			         Model_t * sbmlModel)
{
	int nNoSpecies = mxGetNumberOfElements(mxSpecies);

	int nStatus;
	int nBuflen;

	char * pacTypecode;
	char * pacNotes;
	char * pacAnnotations;
  char * pacAnnotationString;
	char * pacName;
	char * pacId;
	char * pacCompartment;
	double dInitialAmount;
	double dInitialConcentration;
	char * pacUnits;
	char * pacSubstanceUnits;
	char * pacSpatialSizeUnits;
	int nHasOnlySubsUnits;
	int nBoundaryCondition;
	int nCharge;
	int nConstant;
	unsigned int unIsSetInit;
	unsigned int unIsSetInitConc;
	unsigned int unIsSetCharge;

	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxName, * mxId, * mxCompartment, * mxInitialAmount, * mxUnits;
	mxArray * mxInitialConcentration, * mxSpatialSizeUnits, * mxHasOnlySubstance, * mxBoundaryCondition, * mxCharge;
	mxArray * mxConstant, * mxIsSetInitialAmt, * mxIsSetInitialConc, * mxIsSetCharge, * mxSubstanceUnits; 

	Species_t *pSpecies;

	int i;

	for (i = 0; i < nNoSpecies; i++) 
	{

		pSpecies = Species_create();

		/* get typecode */
		mxTypecode = mxGetField(mxSpecies, i, "typecode");
		nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
		pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy typecode");
		}

		/*SBase_init(pSpecies, CharToTypecode(pacTypecode)); */


		/* get notes */
		mxNotes = mxGetField(mxSpecies, i, "notes");
		nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
		pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxNotes, pacNotes, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy notes");
		}

		/*SBase_setNotes(pSpecies, pacNotes); */


		/* get annotations */
		mxAnnotations = mxGetField(mxSpecies, i, "annotation");
		nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
		pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy annotations");
		}

    /* add the tags to the annotation string */
    if (strcmp(pacAnnotations, ""))
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
        strcpy(pacAnnotationString, "<annotation>\n\t\t\t");
        strcat(pacAnnotationString, pacAnnotations);
        strcat(pacAnnotationString, "\n\t\t</annotation>");
    }
    else
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
    }


		/*SBase_setAnnotation(pSpecies, pacAnnotationString); */


		/* get name */
		mxName = mxGetField(mxSpecies, i, "name");
		nBuflen = (mxGetM(mxName)*mxGetN(mxName)+1);
		pacName = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxName, pacName, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy name");
		}

		Species_setName(pSpecies, pacName);


		/* get Compartment */
		mxCompartment = mxGetField(mxSpecies, i, "compartment");
		nBuflen = (mxGetM(mxCompartment)*mxGetN(mxCompartment)+1);
		pacCompartment = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxCompartment, pacCompartment, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy compartment");
		}

		Species_setCompartment(pSpecies, pacCompartment);


		/* get isSetInitialAmount */
		mxIsSetInitialAmt = mxGetField(mxSpecies, i, "isSetInitialAmount");
		unIsSetInit = (unsigned int)mxGetScalar(mxIsSetInitialAmt);


		/* get initial amount */
		mxInitialAmount = mxGetField(mxSpecies, i, "initialAmount");
		dInitialAmount = mxGetScalar(mxInitialAmount);

		if (unIsSetInit == 1) {
			Species_setInitialAmount(pSpecies, dInitialAmount);
		}


		/* get boundary condition */
		mxBoundaryCondition = mxGetField(mxSpecies, i, "boundaryCondition");
		nBoundaryCondition = (int)mxGetScalar(mxBoundaryCondition);

		Species_setBoundaryCondition(pSpecies, nBoundaryCondition);

		
		/* get isSetCharge */
		mxIsSetCharge = mxGetField(mxSpecies, i, "isSetCharge");
		unIsSetCharge = (unsigned int)mxGetScalar(mxIsSetCharge);


		/* get charge */
		mxCharge = mxGetField(mxSpecies, i, "charge");
		nCharge = (int)mxGetScalar(mxCharge);

		if (unIsSetCharge == 1) {
			Species_setCharge(pSpecies, nCharge);
		}

		
		/* level 1 only */
		if (unSBMLLevel == 1)
		{
			/* get units */
			mxUnits = mxGetField(mxSpecies, i, "units");
			nBuflen = (mxGetM(mxUnits)*mxGetN(mxUnits)+1);
			pacUnits = (char *)mxCalloc(nBuflen, sizeof(char));
			nStatus = mxGetString(mxUnits, pacUnits, nBuflen);

			if (nStatus != 0)
			{
				mexErrMsgTxt("Cannot copy units");
			}

			Species_setUnits(pSpecies, pacUnits);

		}
		

		/* level 2 */
		if (unSBMLLevel == 2)
		{
			/* get id */
			mxId = mxGetField(mxSpecies, i, "id");
			nBuflen = (mxGetM(mxId)*mxGetN(mxId)+1);
			pacId = (char *)mxCalloc(nBuflen, sizeof(char));
			nStatus = mxGetString(mxId, pacId, nBuflen);

			if (nStatus != 0)
			{
				mexErrMsgTxt("Cannot copy id");
			}

			Species_setId(pSpecies, pacId);
		
			/* get isSetInitialConcentration */
			mxIsSetInitialConc = mxGetField(mxSpecies, i, "isSetInitialConcentration");
			unIsSetInitConc = (unsigned int)mxGetScalar(mxIsSetInitialConc);

			
			/* get initial concentration */
			mxInitialConcentration = mxGetField(mxSpecies, i, "initialConcentration");
			dInitialConcentration = mxGetScalar(mxInitialConcentration);

			if (unIsSetInitConc == 1) {
				Species_setInitialConcentration(pSpecies, dInitialConcentration);
			}

			/* get substance units */
			mxSubstanceUnits = mxGetField(mxSpecies, i, "substanceUnits");
			nBuflen = (mxGetM(mxSubstanceUnits)*mxGetN(mxSubstanceUnits)+1);
			pacSubstanceUnits = (char *)mxCalloc(nBuflen, sizeof(char));
			nStatus = mxGetString(mxSubstanceUnits, pacSubstanceUnits, nBuflen);

			if (nStatus != 0)
			{
				mexErrMsgTxt("Cannot copy substance units");
			}

			Species_setSubstanceUnits(pSpecies, pacSubstanceUnits);

			
			/* get spatial size units */
			mxSpatialSizeUnits = mxGetField(mxSpecies, i, "spatialSizeUnits");
			nBuflen = (mxGetM(mxSpatialSizeUnits)*mxGetN(mxSpatialSizeUnits)+1);
			pacSpatialSizeUnits = (char *)mxCalloc(nBuflen, sizeof(char));
			nStatus = mxGetString(mxSpatialSizeUnits, pacSpatialSizeUnits, nBuflen);

			if (nStatus != 0)
			{
				mexErrMsgTxt("Cannot copy spatial size units");
			}

			Species_setSpatialSizeUnits(pSpecies, pacSpatialSizeUnits);

			
			/* get HasOnlySubstanceUnits */
			mxHasOnlySubstance = mxGetField(mxSpecies, i, "hasOnlySubstanceUnits");
			nHasOnlySubsUnits = (int)mxGetScalar(mxHasOnlySubstance);

			Species_setHasOnlySubstanceUnits(pSpecies, nHasOnlySubsUnits);

			
			/* get constant */
			mxConstant = mxGetField(mxSpecies, i, "constant");
			nConstant = (int)mxGetScalar(mxConstant);

			Species_setConstant(pSpecies, nConstant);
		}

		/* add the species to the model */
		Model_addSpecies(sbmlModel, pSpecies);

    /* free any memory allocated */
	  mxFree(pacTypecode);
	  mxFree(pacNotes);
	  mxFree(pacAnnotations);
	  mxFree(pacAnnotationString);
	  mxFree(pacName);
  	mxFree(pacCompartment);
		/* level 1 only */
		if (unSBMLLevel == 1)
		{
  	  mxFree(pacUnits);
    }
		/* level 2 only */
		if (unSBMLLevel == 2)
		{
  	  mxFree(pacId);
  	  mxFree(pacSubstanceUnits);
  	  mxFree(pacSpatialSizeUnits);
    }
	}

}

/**
 * NAME:    GetRule
 *
 * PARAMETERS:  mxArray of Rule structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the model
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the Rule mxArray structure
 *        and adds each Rule to the model
 *
 */
 void
 GetRule ( mxArray * mxRule,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			         Model_t * sbmlModel)
{
	int nNoRules = mxGetNumberOfElements(mxRule);

	int nStatus;
	int nBuflen;

	char * pacTypecode;
	char * pacNotes;
	char * pacAnnotations;
	char * pacAnnotationString;
  char * pacType;
  char * pacFormula;
	char * pacVariable;
	char * pacSpecies;
	char * pacCompartment;
	char * pacName;
	char * pacUnits;
    
	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxFormula, * mxVariable, * mxCompartment, * mxSpecies, * mxName, * mxUnits, * mxType;

	AssignmentRule_t *pAssignRule;
	AlgebraicRule_t * pAlgRule;
	RateRule_t *pRateRule;
	SpeciesConcentrationRule_t *pSpeciesConcentrationRule;
	CompartmentVolumeRule_t *pCompartmentVolumeRule;
	ParameterRule_t *pParameterRule;

	int i;

	for (i = 0; i < nNoRules; i++) 
	{

		/* get typecode */
		mxTypecode = mxGetField(mxRule, i, "typecode");
		nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
		pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy typecode");
		}


		/* get notes */
		mxNotes = mxGetField(mxRule, i, "notes");
		nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
		pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxNotes, pacNotes, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy notes");
		}



		/* get annotations */
		mxAnnotations = mxGetField(mxRule, i, "annotation");
		nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
		pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy annotations");
		}

    /* add the tags to the annotation string */
    if (strcmp(pacAnnotations, ""))
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
        strcpy(pacAnnotationString, "<annotation>\n\t\t\t");
        strcat(pacAnnotationString, pacAnnotations);
        strcat(pacAnnotationString, "\n\t\t</annotation>");
    }
    else
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
    }

		/* get formula */
		mxFormula = mxGetField(mxRule, i, "formula");
		nBuflen = (mxGetM(mxFormula)*mxGetN(mxFormula)+1);
		pacFormula = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxFormula, pacFormula, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy Formula");
		}


		/* get each of the fields regardless of whether appropriate type

		/* get Variable */
		mxVariable = mxGetField(mxRule, i, "variable");
		nBuflen = (mxGetM(mxVariable)*mxGetN(mxVariable)+1);
		pacVariable = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxVariable, pacVariable, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy Variable");
		}

		/* get Species */
		mxSpecies = mxGetField(mxRule, i, "species");
		nBuflen = (mxGetM(mxSpecies)*mxGetN(mxSpecies)+1);
		pacSpecies = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxSpecies, pacSpecies, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy Species");
		}


		/* get Compartment */
		mxCompartment = mxGetField(mxRule, i, "compartment");
		nBuflen = (mxGetM(mxCompartment)*mxGetN(mxCompartment)+1);
		pacCompartment = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxCompartment, pacCompartment, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy Compartment");
		}
		

		/* get Name */
		mxName = mxGetField(mxRule, i, "name");
		nBuflen = (mxGetM(mxName)*mxGetN(mxName)+1);
		pacName = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxName, pacName, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy Name");
		}

		
		/* get Units */
		mxUnits = mxGetField(mxRule, i, "units");
		nBuflen = (mxGetM(mxUnits)*mxGetN(mxUnits)+1);
		pacUnits = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxUnits, pacUnits, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy Units");
		}
		
    if (unSBMLLevel == 1) 
    {
      /* get Type */
      mxType = mxGetField(mxRule, i, "type");
      nBuflen = (mxGetM(mxType)*mxGetN(mxType)+1);
      pacType = (char *)mxCalloc(nBuflen, sizeof(char));
      nStatus = mxGetString(mxType, pacType, nBuflen);
      
      if (nStatus != 0)
      {
          mexErrMsgTxt("Cannot copy Type");
      }
    }

		/* assign values for different types of rules */
		switch(CharToTypecode(pacTypecode)) {
      case SBML_ASSIGNMENT_RULE:
        pAssignRule = AssignmentRule_create();

        /*SBase_init((Rule_t *)pAssignRule, CharToTypecode(pacTypecode)); */
        AssignmentRule_setVariable(pAssignRule, pacVariable);			
        /*SBase_setNotes(pAssignRule, pacNotes); */
        /*SBase_setAnnotation(pAssignRule, pacAnnotationString); */

        if (unSBMLLevel == 1)
        {
          AssignmentRule_setType(pAssignRule, RuleType_forName(pacType));
          Rule_setFormula((Rule_t *)pAssignRule, pacFormula);
        }
        else if (unSBMLLevel == 2)
        {
          Rule_setFormula((Rule_t *)pAssignRule, pacFormula);
          Rule_setMath((Rule_t *)pAssignRule, SBML_parseFormula(pacFormula));
        }

        /* add the Rule to the model */
        Model_addRule(sbmlModel,(Rule_t *) pAssignRule);
        break;

      case SBML_ALGEBRAIC_RULE:
        pAlgRule = AlgebraicRule_create();

        /*SBase_init((Rule_t *)pAlgRule, CharToTypecode(pacTypecode)); */
        /*SBase_setNotes(pAlgRule, pacNotes); */
        /*SBase_setAnnotation(pAlgRule, pacAnnotationString); */

        if (unSBMLLevel == 1)
        {
          Rule_setFormula((Rule_t *)pAlgRule, pacFormula);
        }
        else if (unSBMLLevel == 2)
        {
          Rule_setFormula((Rule_t *)pAlgRule, pacFormula);
          Rule_setMath((Rule_t *)pAlgRule, SBML_parseFormula(pacFormula));
        }

        /* add the Rule to the model */
        Model_addRule(sbmlModel,(Rule_t *) pAlgRule);
        break;

      case SBML_RATE_RULE:
        pRateRule = RateRule_create();

        /*SBase_init((Rule_t *)pRateRule, CharToTypecode(pacTypecode)); */
        RateRule_setVariable(pRateRule, pacVariable);			
        /*SBase_setNotes(pRateRule, pacNotes); */
        /*SBase_setAnnotation(pRateRule, pacAnnotationString); */

        if (unSBMLLevel == 1)
        {
          Rule_setFormula((Rule_t *)pRateRule, pacFormula);
        }
        else if (unSBMLLevel == 2)
        {
          Rule_setFormula((Rule_t *)pRateRule, pacFormula);
          Rule_setMath((Rule_t *)pRateRule, SBML_parseFormula(pacFormula));
        }

        /* add the Rule to the model */
        Model_addRule(sbmlModel,(Rule_t *) pRateRule);
        break;

      case SBML_SPECIES_CONCENTRATION_RULE:
        pSpeciesConcentrationRule = SpeciesConcentrationRule_create();

        /*SBase_init((Rule_t *)pSpeciesConcentrationRule, CharToTypecode(pacTypecode)); */
        SpeciesConcentrationRule_setSpecies(pSpeciesConcentrationRule, pacSpecies);			
        /*SBase_setNotes(pSpeciesConcentrationRule, pacNotes); */
        /*SBase_setAnnotation(pSpeciesConcentrationRule, pacAnnotationString); */

        if (unSBMLLevel == 1)
        {
          AssignmentRule_setType(pSpeciesConcentrationRule, RuleType_forName(pacType));
          Rule_setFormula((Rule_t *)pSpeciesConcentrationRule, pacFormula);
        }
        else if (unSBMLLevel == 2)
        {
          Rule_setFormula((Rule_t *)pSpeciesConcentrationRule, pacFormula);
          Rule_setMath((Rule_t *)pSpeciesConcentrationRule, SBML_parseFormula(pacFormula));
        }

        /* add the Rule to the model */
        Model_addRule(sbmlModel,(Rule_t *) pSpeciesConcentrationRule);
        break;

      case SBML_COMPARTMENT_VOLUME_RULE:
        pCompartmentVolumeRule = CompartmentVolumeRule_create();

        /*SBase_init((Rule_t *)pCompartmentVolumeRule, CharToTypecode(pacTypecode)); */
        CompartmentVolumeRule_setCompartment(pCompartmentVolumeRule, pacCompartment);			
        /*SBase_setNotes(pCompartmentVolumeRule, pacNotes); */
        /*SBase_setAnnotation(pCompartmentVolumeRule, pacAnnotationString); */

        if (unSBMLLevel == 1)
        {
          AssignmentRule_setType(pCompartmentVolumeRule, RuleType_forName(pacType));
          Rule_setFormula((Rule_t *)pCompartmentVolumeRule, pacFormula);
        }
        else if (unSBMLLevel == 2)
        {
          Rule_setFormula((Rule_t *)pCompartmentVolumeRule, pacFormula);
          Rule_setMath((Rule_t *)pCompartmentVolumeRule, SBML_parseFormula(pacFormula));
        }

        /* add the Rule to the model */
        Model_addRule(sbmlModel,(Rule_t *) pCompartmentVolumeRule);
        break;

      case SBML_PARAMETER_RULE:
        pParameterRule = ParameterRule_create();

        /*SBase_init((Rule_t *)pParameterRule, CharToTypecode(pacTypecode)); */
        ParameterRule_setName(pParameterRule, pacName);			
        ParameterRule_setUnits(pParameterRule, pacUnits);			
        /*SBase_setNotes(pParameterRule, pacNotes); */
        /*SBase_setAnnotation(pParameterRule, pacAnnotationString); */

        if (unSBMLLevel == 1)
        {
          AssignmentRule_setType(pParameterRule, RuleType_forName(pacType));
          Rule_setFormula((Rule_t *)pParameterRule, pacFormula);
        }
        else if (unSBMLLevel == 2)
        {
          Rule_setFormula((Rule_t *)pParameterRule, pacFormula);
          Rule_setMath((Rule_t *)pParameterRule, SBML_parseFormula(pacFormula));
        }

        /* add the Rule to the model */
        Model_addRule(sbmlModel,(Rule_t *) pParameterRule);
        break;

      default:
        mexErrMsgTxt("Error in rule assignment");
        break;
		}

    /* free any memory allocated */
	  mxFree(pacTypecode);
	  mxFree(pacNotes);
	  mxFree(pacAnnotations);
	  mxFree(pacAnnotationString);
	  mxFree(pacName);
  	mxFree(pacCompartment);
	  mxFree(pacFormula);
  	mxFree(pacVariable);
	  mxFree(pacUnits);
  	mxFree(pacSpecies);
		/* level 1 only */
		if (unSBMLLevel == 1)
		{
  	  mxFree(pacType);
    }
	}

}
/**
 * NAME:    GetUnitDefinition
 *
 * PARAMETERS:  mxArray of unitdefinition structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the model
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the unit definition mxArray structure
 *        and adds each unitdefinition to the model
 */
void
GetUnitDefinition ( mxArray * mxUnitDefinitions,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			   Model_t * sbmlModel )
{
	int nNoUnits = mxGetNumberOfElements(mxUnitDefinitions);
  
	int nStatus;
	int nBuflen;

	/* values */
	char * pacTypecode;
	char * pacNotes;
	char * pacAnnotations;
  char * pacAnnotationString;
	char * pacName;
	char * pacId = NULL;

	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxName, * mxId, * mxUnits;

	UnitDefinition_t *pUnitDefinition;
	int i;


	for (i = 0; i < nNoUnits; i++) 
	{
		pUnitDefinition = UnitDefinition_create();

		/* get typecode */
		mxTypecode = mxGetField(mxUnitDefinitions, i, "typecode");
		nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
		pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy typecode");
		}

		/*SBase_init(pUnitDefinition, CharToTypecode(pacTypecode)); */


		/* get notes */
		mxNotes = mxGetField(mxUnitDefinitions, i, "notes");
		nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
		pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxNotes, pacNotes, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy notes");
		}

		/*SBase_setNotes(pUnitDefinition, pacNotes); */


		/* get annotations */
		mxAnnotations = mxGetField(mxUnitDefinitions, i, "annotation");
		nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
		pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy annotations");
		}

    /* add the tags to the annotation string */
    if (strcmp(pacAnnotations, ""))
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
        strcpy(pacAnnotationString, "<annotation>\n\t\t\t");
        strcat(pacAnnotationString, pacAnnotations);
        strcat(pacAnnotationString, "\n\t\t</annotation>");
    }
    else
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
    }


		/*SBase_setAnnotation(pUnitDefinition, pacAnnotationString); */


		/* get name */
		mxName = mxGetField(mxUnitDefinitions, i, "name");
		nBuflen = (mxGetM(mxName)*mxGetN(mxName)+1);
		pacName = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxName, pacName, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy name");
		}

		UnitDefinition_setName(pUnitDefinition, pacName);

		
		/* get list of units */
		mxUnits = mxGetField(mxUnitDefinitions, i, "unit");
		GetUnit(mxUnits, unSBMLLevel, unSBMLVersion, pUnitDefinition);


		/* level 2 only */
		if (unSBMLLevel == 2)
		{
			/* get id */
			mxId = mxGetField(mxUnitDefinitions, i, "id");
			nBuflen = (mxGetM(mxId)*mxGetN(mxId)+1);
			pacId = (char *)mxCalloc(nBuflen, sizeof(char));
			nStatus = mxGetString(mxId, pacId, nBuflen);

			if (nStatus != 0)
			{
				mexErrMsgTxt("Cannot copy id");
			}

			UnitDefinition_setId(pUnitDefinition, pacId);
		}

		/* add the unit definition to the model */
		Model_addUnitDefinition(sbmlModel, pUnitDefinition);

    /* free any memory allocated */
	  mxFree(pacTypecode);
	  mxFree(pacNotes);
	  mxFree(pacAnnotations);
	  mxFree(pacAnnotationString);
	  mxFree(pacName);
		/* level 2 only */
		if (unSBMLLevel == 2)
		{
  	  mxFree(pacId);
    }

	}
}

/**
 * NAME:    GetUnit
 *
 * PARAMETERS:  mxArray of unit structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the unit definition
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the unit mxArray structure
 *        and adds each unit to the unitdefinition
 */
void
GetUnit ( mxArray * mxUnits,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			   UnitDefinition_t * sbmlUnitDefinition )
{
	int nNoUnits = mxGetNumberOfElements(mxUnits);
  
	int nStatus;
	int nBuflen;

	/* values */
	char * pacTypecode;
	char * pacNotes;
	char * pacAnnotations;
  char * pacAnnotationString;
	char * pacKind;
	int nExponent;
	int nScale;
	double dMultiplier;
	double dOffset;

	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxKind, *mxExponent;
	mxArray * mxScale, * mxMultiplier, * mxOffset;

	Unit_t *pUnit;
	int i;


	for (i = 0; i < nNoUnits; i++) 
	{
		pUnit = Unit_create();

		/* get typecode */
		mxTypecode = mxGetField(mxUnits, i, "typecode");
		nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
		pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy typecode");
		}

		/*SBase_init(pUnit, CharToTypecode(pacTypecode)); */


		/* get notes */
		mxNotes = mxGetField(mxUnits, i, "notes");
		nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
		pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxNotes, pacNotes, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy notes");
		}

		/*SBase_setNotes(pUnit, pacNotes); */


		/* get annotations */
		mxAnnotations = mxGetField(mxUnits, i, "annotation");
		nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
		pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy annotations");
		}
        
    /* add the tags to the annotation string */
    if (strcmp(pacAnnotations, ""))
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
        strcpy(pacAnnotationString, "<annotation>\n\t\t\t\t");
        strcat(pacAnnotationString, pacAnnotations);
        strcat(pacAnnotationString, "\n\t\t\t</annotation>");
    }
    else
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
    }


		/*SBase_setAnnotation(pUnit, pacAnnotationString); */


		/* get kind */
		mxKind = mxGetField(mxUnits, i, "kind");
		nBuflen = (mxGetM(mxKind)*mxGetN(mxKind)+1);
		pacKind = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxKind, pacKind, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy kind");
		}

		Unit_setKind(pUnit, UnitKind_forName(pacKind));


		/* get exponent */
		mxExponent = mxGetField(mxUnits, i, "exponent");
		nExponent = (int)mxGetScalar(mxExponent);

		Unit_setExponent(pUnit, nExponent);


		/* get scale */
		mxScale = mxGetField(mxUnits, i, "scale");
		nScale = (int)mxGetScalar(mxScale);

		Unit_setScale(pUnit, nScale);


		/* level 2 only */
		if (unSBMLLevel == 2)
		{
			/* get multiplier */
			mxMultiplier = mxGetField(mxUnits, i, "multiplier");
			dMultiplier = mxGetScalar(mxMultiplier);

			Unit_setMultiplier(pUnit, dMultiplier);

		
			/* get offset */
			mxOffset = mxGetField(mxUnits, i, "offset");
			dOffset = mxGetScalar(mxOffset);

			Unit_setOffset(pUnit, dOffset);
		
		}

		/* add the unit to the unit definition */
		UnitDefinition_addUnit(sbmlUnitDefinition, pUnit);

    /* free any memory allocated */
	  mxFree(pacTypecode);
	  mxFree(pacNotes);
	  mxFree(pacAnnotations);
	  mxFree(pacAnnotationString);
	  mxFree(pacKind);
	}
}
/**
 * NAME:    GetReaction
 *
 * PARAMETERS:  mxArray of Reaction structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the model
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the Reaction mxArray structure
 *        and adds each Reaction to the model
 *
 */
 void
 GetReaction ( mxArray * mxReaction,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			   Model_t * sbmlModel)
{
	int nNoReaction = mxGetNumberOfElements(mxReaction);

	int nStatus;
	int nBuflen;

	char * pacTypecode;
	char * pacNotes;
	char * pacAnnotations;
  char * pacAnnotationString;
	char * pacName;
	int nReversible;
	int nFast;
	char * pacId;
	unsigned int unIsSetFast;


	int i;
      

	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxName, * mxId, * mxModifiers;
	mxArray * mxReversible, * mxFast, * mxIsSetFast, *mxReactants, * mxProducts, * mxKineticLaw;

	Reaction_t *pReaction;

	for (i = 0; i < nNoReaction; i++) 
	{

		pReaction = Reaction_create();

		/* get typecode */
		mxTypecode = mxGetField(mxReaction, i, "typecode");
		nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
		pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy typecode");
		}

		/*SBase_init(pReaction, CharToTypecode(pacTypecode)); */


		/* get notes */
		mxNotes = mxGetField(mxReaction, i, "notes");
		nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
		pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxNotes, pacNotes, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy notes");
		}

		/*SBase_setNotes(pReaction, pacNotes); */


		/* get annotations */
		mxAnnotations = mxGetField(mxReaction, i, "annotation");
		nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
		pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy annotations");
		}


    /* add the tags to the annotation string */
    if (strcmp(pacAnnotations, ""))
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
        strcpy(pacAnnotationString, "<annotation>\n\t\t\t");
        strcat(pacAnnotationString, pacAnnotations);
        strcat(pacAnnotationString, "\n\t\t</annotation>");
    }
    else
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
    }

		/*SBase_setAnnotation(pReaction, pacAnnotationString); */


		/* get name */
		mxName = mxGetField(mxReaction, i, "name");
		nBuflen = (mxGetM(mxName)*mxGetN(mxName)+1);
		pacName = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxName, pacName, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy name");
		}

		Reaction_setName(pReaction, pacName);


		/* get reversible */
		mxReversible = mxGetField(mxReaction, i, "reversible");
		nReversible = (int)mxGetScalar(mxReversible);

		Reaction_setReversible(pReaction, nReversible);


		/* get list of reactants */
		mxReactants = mxGetField(mxReaction, i, "reactant");
		GetSpeciesReference(mxReactants, unSBMLLevel, unSBMLVersion, pReaction, 0);


		/* get list of products */
		mxProducts = mxGetField(mxReaction, i, "product");
		GetSpeciesReference(mxProducts, unSBMLLevel, unSBMLVersion, pReaction, 1);

		
    /* get kinetic law */
    mxKineticLaw = mxGetField(mxReaction, i, "kineticLaw");
		if ((mxKineticLaw != NULL) && (mxIsEmpty(mxKineticLaw) != 1)) {
      GetKineticLaw(mxKineticLaw, unSBMLLevel, unSBMLVersion, pReaction);
    }
        
		/* level 1 only */
		if (unSBMLLevel == 1)
		{
			/* get fast */
			mxFast = mxGetField(mxReaction, i, "fast");
			nFast = (int)mxGetScalar(mxFast);

			Reaction_setFast(pReaction, nFast);
		}
		

		/* level 2 */
		if (unSBMLLevel == 2)
		{
			/* get id */
			mxId = mxGetField(mxReaction, i, "id");
			nBuflen = (mxGetM(mxId)*mxGetN(mxId)+1);
			pacId = (char *)mxCalloc(nBuflen, sizeof(char));
			nStatus = mxGetString(mxId, pacId, nBuflen);

			if (nStatus != 0)
			{
				mexErrMsgTxt("Cannot copy id");
			}

			Reaction_setId(pReaction, pacId);
		
			/* get isSetFast */
			mxIsSetFast = mxGetField(mxReaction, i, "isSetFast");
            
      /* hack to catch bug in version 1.0.2 where field name was set as IsSetFast */
      if (mxIsSetFast == NULL)
      {
          mxIsSetFast = mxGetField(mxReaction, i, "IsSetFast");
      }

      unIsSetFast = (unsigned int)mxGetScalar(mxIsSetFast);


			/* get fast */
			mxFast = mxGetField(mxReaction, i, "fast");
			nFast = (int)mxGetScalar(mxFast);

			if (unIsSetFast == 1) {
				Reaction_setFast(pReaction, nFast);
			}

 			/* get modifiers */
			mxModifiers = mxGetField(mxReaction, i, "modifier");
  		GetModifier(mxModifiers, unSBMLLevel, unSBMLVersion, pReaction);
    }

		/* add the Reaction to the model */
		Model_addReaction(sbmlModel, pReaction);

    /* free any memory allocated */
	  mxFree(pacTypecode);
	  mxFree(pacNotes);
	  mxFree(pacAnnotations);
	  mxFree(pacAnnotationString);
	  mxFree(pacName);
		/* level 2 only */
		if (unSBMLLevel == 2)
		{
  	  mxFree(pacId);
    }
	}

}
/**
 * NAME:    GetKineticLaw
 *
 * PARAMETERS:  mxArray of kinetic law structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the Reactiom
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the KineticLaw mxArray structure
 *        and adds Kinetic law to the reaction
 *
 */
 void
 GetKineticLaw ( mxArray * mxKineticLaw,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			   Reaction_t * sbmlReaction)
{
	int nStatus;
	int nBuflen;

  char * pacTypecode;
  char * pacNotes;
  char * pacAnnotations;
  char * pacAnnotationString;
  char * pacFormula;
  char * pacTimeUnits;
  char * pacSubstanceUnits;
  char * pacMath;

 	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxFormula, * mxTimeUnits, * mxSubstanceUnits;
	mxArray * mxMath, * mxParameter;

  KineticLaw_t *pKineticLaw;
  
  pKineticLaw = KineticLaw_create();
  
  /* get typecode */
  mxTypecode = mxGetField(mxKineticLaw, 0, "typecode");
  nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
  pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
  nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);
  
  if (nStatus != 0)
  {
      mexErrMsgTxt("Cannot copy typecode");
  }
  
  /*SBase_init(pKineticLaw, CharToTypecode(pacTypecode)); */
  
  
  /* get notes */
  mxNotes = mxGetField(mxKineticLaw, 0, "notes");
  nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
  pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
  nStatus = mxGetString(mxNotes, pacNotes, nBuflen);
  
  if (nStatus != 0)
  {
      mexErrMsgTxt("Cannot copy notes");
  }
  
  /*SBase_setNotes(pKineticLaw, pacNotes); */
  
  
  /* get annotations */
  mxAnnotations = mxGetField(mxKineticLaw, 0, "annotation");
  nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
  pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
  nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);
  
  if (nStatus != 0)
  {
      mexErrMsgTxt("Cannot copy annotations");
  }
         
  /* add the tags to the annotation string */
  if (strcmp(pacAnnotations, ""))
  {
      pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
      strcpy(pacAnnotationString, "<annotation>\n\t\t\t\t");
      strcat(pacAnnotationString, pacAnnotations);
      strcat(pacAnnotationString, "\n\t\t\t</annotation>");
  }
  else
  {
      pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
  }

   
  /*SBase_setAnnotation(pKineticLaw, pacAnnotationString); */

  /* get formula */
  mxFormula = mxGetField(mxKineticLaw, 0, "formula");
  nBuflen = (mxGetM(mxFormula)*mxGetN(mxFormula)+1);
  pacFormula = (char *)mxCalloc(nBuflen, sizeof(char));
  nStatus = mxGetString(mxFormula, pacFormula, nBuflen);
  
  if (nStatus != 0)
  {
      mexErrMsgTxt("Cannot copy annotations");
  }
  
  KineticLaw_setFormula(pKineticLaw, pacFormula);

  
  /* get timeUnits */
  mxTimeUnits = mxGetField(mxKineticLaw, 0, "timeUnits");
  nBuflen = (mxGetM(mxTimeUnits)*mxGetN(mxTimeUnits)+1);
  pacTimeUnits = (char *)mxCalloc(nBuflen, sizeof(char));
  nStatus = mxGetString(mxTimeUnits, pacTimeUnits, nBuflen);
  
  if (nStatus != 0)
  {
      mexErrMsgTxt("Cannot copy annotations");
  }
  
  KineticLaw_setTimeUnits(pKineticLaw, pacTimeUnits);


  /* get substanceUnits */
  mxSubstanceUnits = mxGetField(mxKineticLaw, 0, "substanceUnits");
  nBuflen = (mxGetM(mxSubstanceUnits)*mxGetN(mxSubstanceUnits)+1);
  pacSubstanceUnits = (char *)mxCalloc(nBuflen, sizeof(char));
  nStatus = mxGetString(mxSubstanceUnits, pacSubstanceUnits, nBuflen);
  
  if (nStatus != 0)
  {
      mexErrMsgTxt("Cannot copy annotations");
  }
  
  KineticLaw_setSubstanceUnits(pKineticLaw, pacSubstanceUnits);

  /* get list of parameters */
  mxParameter = mxGetField(mxKineticLaw, 0, "parameter");
  GetParameterFromKineticLaw(mxParameter, unSBMLLevel, unSBMLVersion, pKineticLaw);
  
  if (unSBMLLevel == 2)
  {
    /* get Math */
    mxMath = mxGetField(mxKineticLaw, 0, "math");
    nBuflen = (mxGetM(mxMath)*mxGetN(mxMath)+1);
    pacMath = (char *)mxCalloc(nBuflen, sizeof(char));
    nStatus = mxGetString(mxMath, pacMath, nBuflen);
    
    if (nStatus != 0)
    {
        mexErrMsgTxt("Cannot copy Math");
    }
    
    KineticLaw_setMath(pKineticLaw, SBML_parseFormula(pacMath));
    
  }

  /* add kinetic law to the reaction */
  Reaction_setKineticLaw(sbmlReaction, pKineticLaw);

  /* free any memory allocated */
	mxFree(pacTypecode);
	mxFree(pacNotes);
	mxFree(pacAnnotations);
	mxFree(pacAnnotationString);
	mxFree(pacTimeUnits);
  mxFree(pacSubstanceUnits);
	mxFree(pacFormula);
	/* level 2 only */
	if (unSBMLLevel == 2)
	{
  	mxFree(pacMath);
  }
}

/**
 * NAME:    GetSpeciesReference
 *
 * PARAMETERS:  mxArray of Reactant structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the reaction
 *				nFlag to indicate whether the species referred to are 
 *					products or reactants
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the Reactant mxArray structure
 *        and adds each Reactant to the reaction
 *
 */
 void
 GetSpeciesReference ( mxArray * mxReactant,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			   Reaction_t * sbmlReaction, 
			   int nFlag)
{
	int nNoReactant = mxGetNumberOfElements(mxReactant);

	int nStatus;
	int nBuflen;

  char * pacTypecode;
  char * pacNotes;
  char * pacAnnotations;
  char * pacAnnotationString;
  char * pacSpecies;
  int nStoichiometry;
  int nDenominator;
  double dStoichiometry;
  char * pacStoichiometryMath;

  SpeciesReference_t *pSpeciesReference;
 
	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxSpecies, * mxStoichiometry, * mxDenominator;
	mxArray * mxStoichiometryMath;

	int i;

	for (i = 0; i < nNoReactant; i++) 
	{

		pSpeciesReference = SpeciesReference_create();

		/* get typecode */
		mxTypecode = mxGetField(mxReactant, i, "typecode");
		nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
		pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy typecode");
		}

		/*SBase_init(pSpeciesReference, CharToTypecode(pacTypecode)); */


		/* get notes */
		mxNotes = mxGetField(mxReactant, i, "notes");
		nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
		pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxNotes, pacNotes, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy notes");
		}

		/*SBase_setNotes(pSpeciesReference, pacNotes); */


		/* get annotations */
		mxAnnotations = mxGetField(mxReactant, i, "annotation");
		nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
		pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy annotations");
		}
        
    /* add the tags to the annotation string */
    if (strcmp(pacAnnotations, ""))
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
        strcpy(pacAnnotationString, "<annotation>\n\t\t\t\t");
        strcat(pacAnnotationString, pacAnnotations);
        strcat(pacAnnotationString, "\n\t\t\t</annotation>");
    }
    else
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
    }

		/*SBase_setAnnotation(pSpeciesReference, pacAnnotationString); */


		/* get Species */
		mxSpecies = mxGetField(mxReactant, i, "species");
		nBuflen = (mxGetM(mxSpecies)*mxGetN(mxSpecies)+1);
		pacSpecies = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxSpecies, pacSpecies, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy Species");
		}

		SpeciesReference_setSpecies(pSpeciesReference, pacSpecies);


		/* get Denominator */
		mxDenominator = mxGetField(mxReactant, i, "denominator");
		nDenominator = (int)mxGetScalar(mxDenominator);

		SpeciesReference_setDenominator(pSpeciesReference, nDenominator);

		
		/* level 1 only */
		if (unSBMLLevel == 1)
		{
			/* get Stoichiometry */
			mxStoichiometry = mxGetField(mxReactant, i, "stoichiometry");
			nStoichiometry = (int)mxGetScalar(mxStoichiometry);

			SpeciesReference_setStoichiometry(pSpeciesReference, nStoichiometry);
		}
		

		/* level 2 */
		if (unSBMLLevel == 2)
		{
			/* get Stoichiometry */
			mxStoichiometry = mxGetField(mxReactant, i, "stoichiometry");
			dStoichiometry = mxGetScalar(mxStoichiometry);

			SpeciesReference_setStoichiometry(pSpeciesReference, dStoichiometry);

			/* get StoichiometryMath */
			mxStoichiometryMath = mxGetField(mxReactant, i, "stoichiometryMath");
			nBuflen = (mxGetM(mxStoichiometryMath)*mxGetN(mxStoichiometryMath)+1);
			pacStoichiometryMath = (char *)mxCalloc(nBuflen, sizeof(char));
			nStatus = mxGetString(mxStoichiometryMath, pacStoichiometryMath, nBuflen);

			if (nStatus != 0)
			{
				mexErrMsgTxt("Cannot copy StoichiometryMath");
			}

			SpeciesReference_setStoichiometryMath(pSpeciesReference, SBML_parseFormula(pacStoichiometryMath));
		
		}

		if (nFlag == 0) {
			/* add the Reactant to the reaction */
			Reaction_addReactant(sbmlReaction, pSpeciesReference);
		}
		else {
			/* add the product to the reaction */
			Reaction_addProduct(sbmlReaction, pSpeciesReference);
		}

    /* free any memory allocated */
	  mxFree(pacTypecode);
	  mxFree(pacNotes);
	  mxFree(pacAnnotations);
	  mxFree(pacAnnotationString);
  	mxFree(pacSpecies);
		/* level 2 only */
		if (unSBMLLevel == 2)
		{
  	  mxFree(pacStoichiometryMath);
    }

	}

}
/**
 * NAME:    GetModifier
 *
 * PARAMETERS:  mxArray of modifier structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the reaction
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the modifier mxArray structure
 *        and adds each modifier to the reaction
 *
 */
 void
 GetModifier ( mxArray * mxModifier,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			   Reaction_t * sbmlReaction)
{
	int nNoModifier = mxGetNumberOfElements(mxModifier);

	int nStatus;
	int nBuflen;

  char * pacTypecode;
  char * pacNotes;
  char * pacAnnotations;
  char * pacAnnotationString;
  char * pacSpecies;

  ModifierSpeciesReference_t *pSpeciesReference;
 
	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxSpecies;

	int i;

	for (i = 0; i < nNoModifier; i++) 
	{

		pSpeciesReference = ModifierSpeciesReference_create();

		/* get typecode */
		mxTypecode = mxGetField(mxModifier, i, "typecode");
		nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
		pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy typecode");
		}

		/*SBase_init(pSpeciesReference, CharToTypecode(pacTypecode)); */


		/* get notes */
		mxNotes = mxGetField(mxModifier, i, "notes");
		nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
		pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxNotes, pacNotes, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy notes");
		}

		/*SBase_setNotes(pSpeciesReference, pacNotes); */


		/* get annotations */
		mxAnnotations = mxGetField(mxModifier, i, "annotation");
		nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
		pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy annotations");
		}
        
    /* add the tags to the annotation string */
    if (strcmp(pacAnnotations, ""))
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
        strcpy(pacAnnotationString, "<annotation>\n\t\t\t\t");
        strcat(pacAnnotationString, pacAnnotations);
        strcat(pacAnnotationString, "\n\t\t\t</annotation>");
    }
    else
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
    }


		/*SBase_setAnnotation(pSpeciesReference, pacAnnotationString); */


		/* get Species */
		mxSpecies = mxGetField(mxModifier, i, "species");
		nBuflen = (mxGetM(mxSpecies)*mxGetN(mxSpecies)+1);
		pacSpecies = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxSpecies, pacSpecies, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy Species");
		}

		ModifierSpeciesReference_setSpecies(pSpeciesReference, pacSpecies);


    /* add the modifier to the reaction */
    Reaction_addModifier(sbmlReaction, pSpeciesReference);

    /* free any memory allocated */
	  mxFree(pacTypecode);
	  mxFree(pacNotes);
	  mxFree(pacAnnotations);
	  mxFree(pacAnnotationString);
  	mxFree(pacSpecies);
	}

}

/**
 * NAME:    GetParameterFromKineticLaw
 *
 * PARAMETERS:  mxArray of parameter structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the kinetic law
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the parameter mxArray structure
 *        and adds each parameter to the kinetic law
 *
 */
 void
 GetParameterFromKineticLaw ( mxArray * mxParameters,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			   KineticLaw_t * sbmlKineticLaw)
{
	int nNoParameters = mxGetNumberOfElements(mxParameters);

	int nStatus;
	int nBuflen;

	char * pacTypecode;
	char * pacNotes;
	char * pacAnnotations;
  char * pacAnnotationString;
	char * pacName;
	char * pacId;
	double dValue;
	char * pacUnits;
	unsigned int unIsSetValue;
	int nConstant;

	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxName, * mxId, * mxUnits;
	mxArray * mxValue, * mxIsSetValue, * mxConstant;

	Parameter_t *pParameter;

	int i;

	for (i = 0; i < nNoParameters; i++) 
	{

		pParameter = Parameter_create();

		/* get typecode */
		mxTypecode = mxGetField(mxParameters, i, "typecode");
		nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
		pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy typecode");
		}

		/*SBase_init(pParameter, CharToTypecode(pacTypecode)); */


		/* get notes */
		mxNotes = mxGetField(mxParameters, i, "notes");
		nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
		pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxNotes, pacNotes, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy notes");
		}

		/*SBase_setNotes(pParameter, pacNotes); */


		/* get annotations */
		mxAnnotations = mxGetField(mxParameters, i, "annotation");
		nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
		pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy annotations");
		}
   
        
    /* add the tags to the annotation string */
    if (strcmp(pacAnnotations, ""))
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
        strcpy(pacAnnotationString, "<annotation>\n\t\t\t\t\t");
        strcat(pacAnnotationString, pacAnnotations);
        strcat(pacAnnotationString, "\n\t\t\t\t</annotation>");
    }
    else
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
    }


		/*SBase_setAnnotation(pParameter, pacAnnotationString); */


		/* get name */
		mxName = mxGetField(mxParameters, i, "name");
		nBuflen = (mxGetM(mxName)*mxGetN(mxName)+1);
		pacName = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxName, pacName, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy name");
		}

		Parameter_setName(pParameter, pacName);


		/* get units */
		mxUnits = mxGetField(mxParameters, i, "units");
		nBuflen = (mxGetM(mxUnits)*mxGetN(mxUnits)+1);
		pacUnits = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxUnits, pacUnits, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy units");
		}

		Parameter_setUnits(pParameter, pacUnits);


		/* get isSetValue */
		mxIsSetValue = mxGetField(mxParameters, i, "isSetValue");
		unIsSetValue = (unsigned int)mxGetScalar(mxIsSetValue);



		/* get value */
		mxValue = mxGetField(mxParameters, i, "value");
		dValue = mxGetScalar(mxValue);

		if (unIsSetValue == 1) {
			Parameter_setValue(pParameter, dValue);
		}


		
		/* level 2 */
		if (unSBMLLevel == 2)
		{
			/* get id */
			mxId = mxGetField(mxParameters, i, "id");
			nBuflen = (mxGetM(mxId)*mxGetN(mxId)+1);
			pacId = (char *)mxCalloc(nBuflen, sizeof(char));
			nStatus = mxGetString(mxId, pacId, nBuflen);

			if (nStatus != 0)
			{
				mexErrMsgTxt("Cannot copy id");
			}

			Parameter_setId(pParameter, pacId);
		
			
			/* get constant */
			mxConstant = mxGetField(mxParameters, i, "constant");
			nConstant = (int)mxGetScalar(mxConstant);

			Parameter_setConstant(pParameter, nConstant);
		}

		/* add the parameter to the kinetic law */
		KineticLaw_addParameter(sbmlKineticLaw, pParameter);

    /* free any memory allocated */
	  mxFree(pacTypecode);
	  mxFree(pacNotes);
	  mxFree(pacAnnotations);
	  mxFree(pacAnnotationString);
	  mxFree(pacName);
	  mxFree(pacUnits);
		/* level 2 only */
		if (unSBMLLevel == 2)
		{
  	  mxFree(pacId);
    }
	}

}
/**
 * NAME:    GetFunctionDefinition
 *
 * PARAMETERS:  mxArray of functiondefinition structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the model
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the function definition mxArray structure
 *        and adds each functiondefinition to the model
 */
void
GetFunctionDefinition ( mxArray * mxFunctionDefinitions,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			   Model_t * sbmlModel )
{
	int nNoFunctions = mxGetNumberOfElements(mxFunctionDefinitions);
  
	int nStatus;
	int nBuflen;

	/* values */
	char * pacTypecode;
	char * pacNotes;
	char * pacAnnotations;
  char * pacAnnotationString;
	char * pacName;
	char * pacId;
	char * pacFormula;

	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxName, * mxId, * mxMath;

	FunctionDefinition_t *pFuncDefinition;
	int i;


	for (i = 0; i < nNoFunctions; i++) 
	{
		pFuncDefinition = FunctionDefinition_create();

		/* get typecode */
		mxTypecode = mxGetField(mxFunctionDefinitions, i, "typecode");
		nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
		pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy typecode");
		}

		/*SBase_init(pFuncDefinition, CharToTypecode(pacTypecode)); */


		/* get notes */
		mxNotes = mxGetField(mxFunctionDefinitions, i, "notes");
		nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
		pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxNotes, pacNotes, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy notes");
		}

		/*SBase_setNotes(pFuncDefinition, pacNotes); */


		/* get annotations */
		mxAnnotations = mxGetField(mxFunctionDefinitions, i, "annotation");
		nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
		pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy annotations");
		}

    /* add the tags to the annotation string */
    if (strcmp(pacAnnotations, ""))
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
        strcpy(pacAnnotationString, "<annotation>\n\t\t\t");
        strcat(pacAnnotationString, pacAnnotations);
        strcat(pacAnnotationString, "\n\t\t</annotation>");
    }
    else
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
    }


		/*SBase_setAnnotation(pFuncDefinition, pacAnnotationString); */


		/* get name */
		mxName = mxGetField(mxFunctionDefinitions, i, "name");
		nBuflen = (mxGetM(mxName)*mxGetN(mxName)+1);
		pacName = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxName, pacName, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy name");
		}

		FunctionDefinition_setName(pFuncDefinition, pacName);


		/* get id */
		mxId = mxGetField(mxFunctionDefinitions, i, "id");
		nBuflen = (mxGetM(mxId)*mxGetN(mxId)+1);
		pacId = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxId, pacId, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy id");
		}

		FunctionDefinition_setId(pFuncDefinition, pacId);
	

		/* get math */
		mxMath = mxGetField(mxFunctionDefinitions, i, "math");
		nBuflen = (mxGetM(mxMath)*mxGetN(mxMath)+1);
		pacFormula = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxMath, pacFormula, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy math");
		}

		FunctionDefinition_setMath(pFuncDefinition, SBML_parseFormula(pacFormula));

		/* add the function definition to the model */
		Model_addFunctionDefinition(sbmlModel, pFuncDefinition);

    /* free any memory allocated */
	  mxFree(pacTypecode);
	  mxFree(pacNotes);
	  mxFree(pacAnnotations);
	  mxFree(pacAnnotationString);
	  mxFree(pacName);
	  mxFree(pacFormula);
 	  mxFree(pacId);
	}
}
/**
 * NAME:    GetEvent
 *
 * PARAMETERS:  mxArray of event structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the model
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the event mxArray structure
 *        and adds each event to the model
 */
void
GetEvent ( mxArray * mxEvents,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			   Model_t * sbmlModel )
{
	int nNoEvents = mxGetNumberOfElements(mxEvents);
  
	int nStatus;
	int nBuflen;

	/* values */
	char * pacTypecode;
	char * pacNotes;
	char * pacAnnotations;
  char * pacAnnotationString;
	char * pacName;
	char * pacId;
  char * pacTrigger;
	char * pacDelay;
	char * pacTimeUnits;

	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxName, * mxId, * mxTimeUnits;
  mxArray * mxTrigger, * mxDelay, * mxEventAssignments;

	Event_t *pEvent;
	int i;


	for (i = 0; i < nNoEvents; i++) 
	{
		pEvent = Event_create();

		/* get typecode */
		mxTypecode = mxGetField(mxEvents, i, "typecode");
		nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
		pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy typecode");
		}

		/*SBase_init(pEvent, CharToTypecode(pacTypecode)); */


		/* get notes */
		mxNotes = mxGetField(mxEvents, i, "notes");
		nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
		pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxNotes, pacNotes, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy notes");
		}

		/*SBase_setNotes(pEvent, pacNotes); */


		/* get annotations */
		mxAnnotations = mxGetField(mxEvents, i, "annotation");
		nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
		pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy annotations");
		}

    /* add the tags to the annotation string */
    if (strcmp(pacAnnotations, ""))
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
        strcpy(pacAnnotationString, "<annotation>\n\t\t\t");
        strcat(pacAnnotationString, pacAnnotations);
        strcat(pacAnnotationString, "\n\t\t</annotation>");
    }
    else
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
    }


		/*SBase_setAnnotation(pEvent, pacAnnotationString); */


		/* get name */
		mxName = mxGetField(mxEvents, i, "name");
		nBuflen = (mxGetM(mxName)*mxGetN(mxName)+1);
		pacName = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxName, pacName, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy name");
		}

		Event_setName(pEvent, pacName);

		
		/* get Trigger */
		mxTrigger = mxGetField(mxEvents, i, "trigger");
		nBuflen = (mxGetM(mxTrigger)*mxGetN(mxTrigger)+1);
		pacTrigger = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTrigger, pacTrigger, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy Trigger");
		}

    if (strcmp(pacTrigger, ""))
    {
      Event_setTrigger(pEvent, SBML_parseFormula(pacTrigger));
    }
		
		/* get Delay */
		mxDelay = mxGetField(mxEvents, i, "delay");
		nBuflen = (mxGetM(mxDelay)*mxGetN(mxDelay)+1);
		pacDelay = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxDelay, pacDelay, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy Delay");
		}

    if (strcmp(pacDelay, ""))
    {
      Event_setDelay(pEvent, SBML_parseFormula(pacDelay));
    }
        
		/* get TimeUnits */
		mxTimeUnits = mxGetField(mxEvents, i, "timeUnits");
		nBuflen = (mxGetM(mxTimeUnits)*mxGetN(mxTimeUnits)+1);
		pacTimeUnits = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTimeUnits, pacTimeUnits, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy TimeUnits");
		}

		Event_setTimeUnits(pEvent, pacTimeUnits);

		
    /* get id */
    mxId = mxGetField(mxEvents, i, "id");
    nBuflen = (mxGetM(mxId)*mxGetN(mxId)+1);
    pacId = (char *)mxCalloc(nBuflen, sizeof(char));
    nStatus = mxGetString(mxId, pacId, nBuflen);
    
    if (nStatus != 0)
    {
        mexErrMsgTxt("Cannot copy id");
    }
    
    Event_setId(pEvent, pacId);


    /* get list of event assignments */
		mxEventAssignments = mxGetField(mxEvents, i, "eventAssignment");
		GetEventAssignment(mxEventAssignments, unSBMLLevel, unSBMLVersion, pEvent);

        
    /* add the event to the model */
		Model_addEvent(sbmlModel, pEvent);

    /* free any memory allocated */
	  mxFree(pacTypecode);
	  mxFree(pacNotes);
	  mxFree(pacAnnotations);
	  mxFree(pacAnnotationString);
	  mxFree(pacName);
  	mxFree(pacTrigger);
	  mxFree(pacDelay);
	  mxFree(pacTimeUnits);
 	  mxFree(pacId);
	}
}
/**
 * NAME:    GetEventAssignment
 *
 * PARAMETERS:  mxArray of event assignment structures
 *              unSBMLLevel
 *              unSBMLVersion - included for possible expansion needs
 *				Pointer to the event
 *
 * RETURNS:    void
 *
 * FUNCTION:  gets data from the event assignment mxArray structure
 *        and adds each event assignment to the event
 */
void
GetEventAssignment ( mxArray * mxEventAssignment,
               unsigned int unSBMLLevel,
               unsigned int unSBMLVersion, 
			   Event_t * sbmlEvent )
{
	int nNoEventAssigns = mxGetNumberOfElements(mxEventAssignment);
  
	int nStatus;
	int nBuflen;

	/* values */
	char * pacTypecode;
	char * pacNotes;
	char * pacAnnotations;
  char * pacAnnotationString;
	char * pacVariable;
  char * pacMath;

	mxArray * mxTypecode, * mxNotes, * mxAnnotations, * mxVariable, * mxMath;

	EventAssignment_t *pEventAssignment;
	int i;


	for (i = 0; i < nNoEventAssigns; i++) 
	{
		pEventAssignment = EventAssignment_create();

		/* get typecode */
		mxTypecode = mxGetField(mxEventAssignment, i, "typecode");
		nBuflen = (mxGetM(mxTypecode)*mxGetN(mxTypecode)+1);
		pacTypecode = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxTypecode, pacTypecode, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy typecode");
		}

		/*SBase_init(pEventAssignment, CharToTypecode(pacTypecode)); */


		/* get notes */
		mxNotes = mxGetField(mxEventAssignment, i, "notes");
		nBuflen = (mxGetM(mxNotes)*mxGetN(mxNotes)+1);
		pacNotes = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxNotes, pacNotes, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy notes");
		}

		/*SBase_setNotes(pEventAssignment, pacNotes); */


		/* get annotations */
		mxAnnotations = mxGetField(mxEventAssignment, i, "annotation");
		nBuflen = (mxGetM(mxAnnotations)*mxGetN(mxAnnotations)+1);
		pacAnnotations = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxAnnotations, pacAnnotations, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy annotations");
		}
        
    /* add the tags to the annotation string */
    if (strcmp(pacAnnotations, ""))
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen+30, sizeof(char));
        strcpy(pacAnnotationString, "<annotation>\n\t\t\t\t");
        strcat(pacAnnotationString, pacAnnotations);
        strcat(pacAnnotationString, "\n\t\t\t</annotation>");
    }
    else
    {
        pacAnnotationString = (char *)mxCalloc(nBuflen, sizeof(char));
    }


		/*SBase_setAnnotation(pEventAssignment, pacAnnotationString); */


		/* get Variable */
		mxVariable = mxGetField(mxEventAssignment, i, "variable");
		nBuflen = (mxGetM(mxVariable)*mxGetN(mxVariable)+1);
		pacVariable = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxVariable, pacVariable, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy Variable");
		}

		EventAssignment_setVariable(pEventAssignment, pacVariable);

		/* get Math */
		mxMath = mxGetField(mxEventAssignment, i, "math");
		nBuflen = (mxGetM(mxMath)*mxGetN(mxMath)+1);
		pacMath = (char *)mxCalloc(nBuflen, sizeof(char));
		nStatus = mxGetString(mxMath, pacMath, nBuflen);

		if (nStatus != 0)
		{
			mexErrMsgTxt("Cannot copy Math");
		}

    /* if pacMath is empty setMath blows up */
    if (strcmp(pacMath, ""))
    {
      EventAssignment_setMath(pEventAssignment, SBML_parseFormula(pacMath));
    }


		/* add the event assignment to the event */
		Event_addEventAssignment(sbmlEvent, pEventAssignment);

    /* free any memory allocated */
	  mxFree(pacTypecode);
	  mxFree(pacNotes);
	  mxFree(pacAnnotations);
	  mxFree(pacAnnotationString);
   	mxFree(pacVariable);
	  mxFree(pacMath);
	}
}
