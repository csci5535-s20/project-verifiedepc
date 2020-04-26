// S1AP-PDU-Descriptions - InitialUEAttach Procedure requirements only. 



// -------  Interface PDU Definition



typedef S1APElementaryProcedure InitiatingMessage
typedef S1APElementaryProcedure SuccessfulOutcome
typedef S1APElementaryProcedure UnsuccessfulOutcome

union S1APPDU{
	1: InitiatingMessage 		initiating_message;
	2: SuccessfulOutcome 		successful_outcome;
	3: UnsuccessfulOutcome 		unsuccessful_outcome; 
}

// -------  Interface Elementary Procedure Class

struct S1APElementaryProcedure{
	1: InitiatingMessage 				initiating_message;
	2: optional SuccessfulOutcome 		successful_outcome;
	3: optional UnsuccessfulOutcome 	unsuccessful_outcome; 
	4: required ProcedureCode 			procedure_code;  //TODO : UNIQUE
	5: Criticality 						criticality = Criticality.IGNORE;

}

// -------  Interface Elementary Procedure List

const list<S1APElementaryProcedure> S1APElementaryProcedures = [S1APElementaryProceduresClass1, S1APElementaryProceduresClass2];


const list<S1APElementaryProcedure> S1APElementaryProceduresClass1 = [

	InitialContextSetup_EP,
	S1Setup_EP,

]


const list<S1APElementaryProcedure> S1APElementaryProceduresClass2 = [

	DownlinkNASTransport_EP,
	InitialUEMessage_EP,
	UplinkNASTransport_EP,

]




// Elementary Procedure Defintions

// EP9
typedef S1apElementaryProcedure InitialContextSetup_EP = {"initiating_message": InitialContextSetupRequest , "sucessful_outcome":InitialContextSetupResponse , "unsuccessful_outcome": InitialContextSetupFailure, "procedure_code": ID_InitialContextSetup_PC, "criticality": Criticality.REJECT}


// EP11
typedef S1apElementaryProcedure DownlinkNASTransport_EP = {"initiating_message": DownlinkNASTransport,  "procedure_code": ID_downlinkNASTransport_PC, "criticality": Criticality.IGNORE}


// EP12
typedef S1apElementaryProcedure InitialUEMessage_EP = {"initiating_message": InitialUEMessage,  "procedure_code": ID_initialUEMessage_PC , "criticality": Criticality.IGNORE}



// EP13
typedef S1apElementaryProcedure UplinkNASTransport_EP = {"initiating_message": UplinkNASTransport,  "procedure_code": ID_uplinkNASTransport_PC, "criticality": Criticality.IGNORE}



// EP17
typedef S1apElementaryProcedure S1Setup_EP = {"initiating_message":S1SetupRequest , "sucessful_outcome":S1SetupResponse, "unsuccessful_outcome":S1SetupFailure , "procedure_code":ID_S1Setup_PC , "criticality": Criticality.REJECT}
