// S1AP-CommonDataTypes
/*

-- **************************************************************
--
-- Common definitions
--
-- **************************************************************

S1AP-CommonDataTypes {
itu-t (0) identified-organization (4) etsi (0) mobileDomain (0) 
eps-Access (21) modules (3) s1ap (1) version1 (1) s1ap-CommonDataTypes (3) }

DEFINITIONS AUTOMATIC TAGS ::= 

BEGIN

Criticality		::= ENUMERATED { reject, ignore, notify }

Presence		::= ENUMERATED { optional, conditional, mandatory }

PrivateIE-ID	::= CHOICE {
	local				INTEGER (0..65535),
	global				OBJECT IDENTIFIER
}

ProcedureCode		::= INTEGER (0..255)

ProtocolExtensionID	::= INTEGER (0..65535)

ProtocolIE-ID		::= INTEGER (0..65535)

TriggeringMessage	::= ENUMERATED { initiating-message, successful-outcome, unsuccessfull-outcome }

END

*/


 enum CriticalityValue{
  REJECT = 1,
  IGNORE = 2,
  NOTIFY = 3
 }

 enum Presence{
  OPTIONAL=1,
  CONDITIONAL=2,
  MANDATORY=3
 }

 union PrivateIEID{	// TODO: Choice, oneof ( is Union correct)
 	1: i16 local,
 	2: string global 	//. TODO:  What should this be? 
 }


 enum TriggeringMesage{
  INITIATING_MESSAGE = 1,
  SUCCESSFUL_OUTCOME = 2,
  UNSUCCESSFULOUTCOME = 3
 }

typedef i8 ProcedureCode 				// INTEGER (0..255)
typedef i32 ProtocolExtensionID 		// INTEGER (0..65535)
typedef i32 ProtocolIEID 				// INTEGER (0..65535)
