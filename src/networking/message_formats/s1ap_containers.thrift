// S1AP-Containers
// **************************************************************

struct S1apProtocolIES{
	1: required ProtocolIEID 					id;		//UNIQUE
	2: Criticality 								criticality;
	3: Value 									value;
	4: Presence 								presence;
}


struct S1apProtocolIESPair{
	1: required ProtocolIEID 					id;			//UNIQUE
	2: Criticality 								first_criticality;
	3: Value 									first_value;
	4: Criticality 								second_criticality;
	5: Value 									second_value;
	6: Presence 								presence;

}

struct S1apProtocolExtension{
	1: required ProtocolIEID 					id;			//UNIQUE
	2: Criticality 								criticality;
	3: Extension 								extension;
	4: Presence 								presence;
}

struct S1apPrivateIES{
	1: required ProtocolIEID 					id;
	2: Criticality 								criticality;
	3: Value 									value;
	4: Presence 								presence;
}


// *************************************
// Dependent Types being defined here. 
// TODO: Modify/chagne/delete these as we might not be using this. 
// *************************************



typedef S1apProtocolIES ProtocolIEField

typedef ProtocolIEField ProtocolIESingleContainer

//TODO: size(maxProtocolIEs)
typedef list<ProtocolIEField maxProtocolIEs> ProtocolIEContainer

typedef S1apProtocolIESPair ProtocolIEFieldPair

typedef list<ProtocolIEFieldPair maxProtocolIEs>ProtocolIEContainerPair;// TODO: size(maxProtocolIEs)


//TODO: size(loowerBound,upperBound)
typedef list<ProtocolIESingleContainer>ProtocolIEContainerList


//TODO: size(LowerBound, UpperBound)
typedef list<ProtocolIEContainerPair> ProtocolIEContainerPairList

typedef S1apProtocolExtension ProtocolExtensionField

typedef list<ProtocolExtensionField maxProtocolExtensionContainer> ProtocolExtensionContainer // TODO: size(maxProtocolExtensions)


typedef S1apPrivateIES PrivateIEField

typedef list<PrivateIEField maxPrivateIEs> PrivateIEContainer //TODO: size(maxPrivateIEs)

/*

-- **************************************************************
-- TS 36.413 V8.10.0 (2010-06)
-- **************************************************************

-- **************************************************************
--
-- Container definitions
--
-- **************************************************************

S1AP-Containers {
itu-t (0) identified-organization (4) etsi (0) mobileDomain (0) 
eps-Access (21) modules (3) s1ap (1) version1 (1) s1ap-Containers (5) }

DEFINITIONS AUTOMATIC TAGS ::= 

BEGIN

-- **************************************************************
--
-- IE parameter types from other modules.
--
-- **************************************************************

IMPORTS
	Criticality,
	Presence,
	PrivateIE-ID,
	ProtocolExtensionID,
	ProtocolIE-ID
FROM S1AP-CommonDataTypes

	maxPrivateIEs,
	maxProtocolExtensions,
	maxProtocolIEs
FROM S1AP-Constants;

-- **************************************************************
--
-- Class Definition for Protocol IEs
--
-- **************************************************************

S1AP-PROTOCOL-IES ::= CLASS {
	&id				ProtocolIE-ID 					UNIQUE,
	&criticality			Criticality,
	&Value,
	&presence			Presence
}
WITH SYNTAX {
	ID				&id
	CRITICALITY			&criticality
	TYPE				&Value
	PRESENCE			&presence
}

-- **************************************************************
--
-- Class Definition for Protocol IEs
--
-- **************************************************************

S1AP-PROTOCOL-IES-PAIR ::= CLASS {
	&id				ProtocolIE-ID 					UNIQUE,
	&firstCriticality		Criticality,
	&FirstValue,
	&secondCriticality		Criticality,
	&SecondValue,
	&presence			Presence
}
WITH SYNTAX {
	ID				&id
	FIRST CRITICALITY 		&firstCriticality
	FIRST TYPE			&FirstValue
	SECOND CRITICALITY 		&secondCriticality
	SECOND TYPE			&SecondValue
	PRESENCE			&presence
}

-- **************************************************************
--
-- Class Definition for Protocol Extensions
--
-- **************************************************************

S1AP-PROTOCOL-EXTENSION ::= CLASS {
	&id				ProtocolExtensionID 				UNIQUE,
	&criticality			Criticality,
	&Extension,
	&presence		Presence
}
WITH SYNTAX {
	ID				&id
	CRITICALITY			&criticality
	EXTENSION			&Extension
	PRESENCE		&presence
}

-- **************************************************************
--
-- Class Definition for Private IEs
--
-- **************************************************************

S1AP-PRIVATE-IES ::= CLASS {
	&id				PrivateIE-ID,
	&criticality			Criticality,
	&Value,
	&presence		Presence
}
WITH SYNTAX {
	ID				&id
	CRITICALITY			&criticality
	TYPE			&Value
	PRESENCE		&presence
}

-- **************************************************************
--
-- Container for Protocol IEs
--
-- **************************************************************

ProtocolIE-Container {S1AP-PROTOCOL-IES : IEsSetParam} ::= 
	SEQUENCE (SIZE (0..maxProtocolIEs)) OF
	ProtocolIE-Field {{IEsSetParam}}

ProtocolIE-SingleContainer {S1AP-PROTOCOL-IES : IEsSetParam} ::= 
	ProtocolIE-Field {{IEsSetParam}}

ProtocolIE-Field {S1AP-PROTOCOL-IES : IEsSetParam} ::= SEQUENCE {
	id				S1AP-PROTOCOL-IES.&id				({IEsSetParam}),
	criticality			S1AP-PROTOCOL-IES.&criticality			({IEsSetParam}{@id}),
	value				S1AP-PROTOCOL-IES.&Value	        	({IEsSetParam}{@id})
}

-- **************************************************************
--
-- Container for Protocol IE Pairs
--
-- **************************************************************

ProtocolIE-ContainerPair {S1AP-PROTOCOL-IES-PAIR : IEsSetParam} ::= 
	SEQUENCE (SIZE (0..maxProtocolIEs)) OF
	ProtocolIE-FieldPair {{IEsSetParam}}

ProtocolIE-FieldPair {S1AP-PROTOCOL-IES-PAIR : IEsSetParam} ::= SEQUENCE {
	id				S1AP-PROTOCOL-IES-PAIR.&id			({IEsSetParam}),
	firstCriticality		S1AP-PROTOCOL-IES-PAIR.&firstCriticality	({IEsSetParam}{@id}),
	firstValue			S1AP-PROTOCOL-IES-PAIR.&FirstValue	        ({IEsSetParam}{@id}),
	secondCriticality		S1AP-PROTOCOL-IES-PAIR.&secondCriticality	({IEsSetParam}{@id}),
	secondValue			S1AP-PROTOCOL-IES-PAIR.&SecondValue	        ({IEsSetParam}{@id})
}

-- **************************************************************
--
-- Container Lists for Protocol IE Containers
--
-- **************************************************************

ProtocolIE-ContainerList {INTEGER : lowerBound, INTEGER : upperBound, S1AP-PROTOCOL-IES : IEsSetParam} ::=
	SEQUENCE (SIZE (lowerBound..upperBound)) OF
	ProtocolIE-SingleContainer {{IEsSetParam}}

ProtocolIE-ContainerPairList {INTEGER : lowerBound, INTEGER : upperBound, S1AP-PROTOCOL-IES-PAIR : IEsSetParam} ::=
	SEQUENCE (SIZE (lowerBound..upperBound)) OF
	ProtocolIE-ContainerPair {{IEsSetParam}}

-- **************************************************************
--
-- Container for Protocol Extensions
--
-- **************************************************************

ProtocolExtensionContainer {S1AP-PROTOCOL-EXTENSION : ExtensionSetParam} ::= 
	SEQUENCE (SIZE (1..maxProtocolExtensions)) OF
	ProtocolExtensionField {{ExtensionSetParam}}

ProtocolExtensionField {S1AP-PROTOCOL-EXTENSION : ExtensionSetParam} ::= SEQUENCE {
	id				S1AP-PROTOCOL-EXTENSION.&id			({ExtensionSetParam}),
	criticality			S1AP-PROTOCOL-EXTENSION.&criticality		({ExtensionSetParam}{@id}),
	extensionValue			S1AP-PROTOCOL-EXTENSION.&Extension		({ExtensionSetParam}{@id})
}

-- **************************************************************
--
-- Container for Private IEs
--
-- **************************************************************

PrivateIE-Container {S1AP-PRIVATE-IES : IEsSetParam } ::= 
	SEQUENCE (SIZE (1.. maxPrivateIEs)) OF
	PrivateIE-Field {{IEsSetParam}}

PrivateIE-Field {S1AP-PRIVATE-IES : IEsSetParam} ::= SEQUENCE {
	id				S1AP-PRIVATE-IES.&id			({IEsSetParam}),
	criticality			S1AP-PRIVATE-IES.&criticality		({IEsSetParam}{@id}),
	value			S1AP-PRIVATE-IES.&Value		({IEsSetParam}{@id})
}

END
*/

