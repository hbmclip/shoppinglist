#!/usr/local/bin/hbmclip

**********************************************
* Name  : createdatabase
* Date  : 2025-06-08 - 16:58:06
* Notes : 
/*
   1. Define the database name
   2. Connect to the Database Management System (DBMS)
   3. Create the database if it does not exist
   4. Select the database for use
   5. Define and create the 'shopping_lists' table
   6. Define and create the 'items' table
   7. Verify if tables were created successfully
   8. Disconnect from the DBMS
*/
***********************************************
#include 'hbmediator.ch' // virtual include file
PROCEDURE createdatabase( ... )
    MODULE SHELL

    LOCAL hParams , aData, cPrintParams, cMessage 

    /* Insert your params here */
    **************************************Templates***************************************
    * SHELL ADD PARAM "-first" TITLE "First" BOOLEAN // Logical parameter
    * SHELL ADD PARAM "-second" TITLE "Second" STRING DEFAULT "Default Value" // Default value
    * SHELL ADD PARAM "-third" TITLE "Third" STRING MANDATORY // Must be value
    ************************************************************************************

    SHELL ADD PARAM "-json" TITLE "Return in json format" BOOLEAN
    SHELL ADD PARAM "-param-json" TITLE "Parameter in string json" STRING DEFAULT ""
    SHELL ADD PARAM "-param-json-file" TITLE "Parameter in json file" STRING DEFAULT ""
    SHELL ADD PARAM "-param-json-base64" TITLE "Parameter in string json (base64 format)" STRING DEFAULT ""
    SHELL ADD PARAM "-param-json-file-base64" TITLE "Parameter in json file (base64 format)" STRING DEFAULT ""
    SHELL PRINT HELP TO cPrintParams
    IF hb_AScan( hb_Acmdline() , "--help" ) <> 0
        Hbm_Help( cPrintParams )
        RETURN
    ENDIF

     ***********************************************
    SHELL GET PARAMS TO hParams 
    IF Empty( cMessage := GetJsonParams( hParams )) // Get parameters in Json : -param-json and -param-json-file
    ELSE
        SHELL RETURN ERROR cMessage
    ENDIF
    SHELL GET LAST MESSAGE TO cMessage
    IF ! Empty( cMessage )
        SHELL RETURN ERROR cMessage
    ENDIF
     ***********************************************
    SHELL GET DATA TO aData
    IF IS_PIPE_CONTENT()
        AAdd(aData,m->__PIPE)
        //PIPE TO <aArray> AS ARRAY
        //PIPE TO <cStr> AS STRING
    ENDIF

    IF hParams["-json"]
        SHELL JSON ON // Enable Json format in return message
    ELSE
        SHELL JSON OFF // Disable Json format in return message
    ENDIF

    //SHELL DEBUG hParams // Debug
    //SHELL DEBUG aData // Debug
    //? hb_valtoexp( hParams ) // Debug
    //? hb_valtoexp( aDara ) // Debug

    /* Insert your code here */
    
   // 1. Define the database name
   cDatabaseName := "shopping_list_db"

   // 2. Connect to the Database Management System (DBMS)
   

   // 3. Create the database if it does not exist
   // 4. Select the database for use
   // 5. Define and create the 'shopping_lists' table
   // 6. Define and create the 'items' table
   // 7. Verify if tables were created successfully
   // 8. Disconnect from the DBMS

    **************************************Return Message Templates*****************************
    * SHELL RETURN ERROR <cReturn> [ERRORCODE <nCode>] // error
    * SHELL RETURN <cReturn> [AS ARRAY>] // success
    ************************************************************************************

RETURN

STATIC PROCEDURE Hbm_Help( cPrintParams )

    hb_Default( @cPrintParams , "")
    ? "Objective : "
    ?
    ? "Parameters standard"
    ? "--help    This help (script) "
    ? "--?       Help " + ExeName() + " (executable) "
    ? "--virtual-include : embedded ch files "
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF


RETURN
STATIC FUNCTION GetJsonParams( hParams )
     LOCAL hNew
     LOCAL cRet := ""
     IF ! Empty( hParams[ "-param-json-file" ] )
         IF File( hParams[ "-param-json-file" ] )
             hNew := hb_jsonDecode( hb_MemoRead( hParams[ "-param-json-file" ] ) )
             IF ValType( hNew ) == "H" // IF hash, add to the hash of parameters
                 hb_HMerge( hParams, hNew )
             ELSE
                 cRet := "Invalid json in -param-json-file"
             ENDIF
          ELSE
             cRet := hb_StrFormat( "File %s not found. Check -param-json " + hb_eol(), hParams[ "-param-json-file" ] ) 
          ENDIF
      ENDIF
      IF ! Empty( hParams[ "-param-json" ] )
          hNew := hb_jsonDecode( hParams[ "-param-json" ] )
          IF ValType( hNew ) == "H" // // IF hash, add to the hash of parameters
              hb_HMerge( hParams, hNew )
          ELSE
              cRet := "Invalid json in -param-json" 
          ENDIF
      ENDIF
     IF ! Empty( hParams[ "-param-json-file-base64" ] )
         IF File( hParams[ "-param-json-file-base64" ] )
             hNew := hb_jsonDecode( hb_base64decode( hb_MemoRead( hParams[ "-param-json-file-base64" ] ) ) )
             IF ValType( hNew ) == "H" // IF hash, add to the hash of parameters
                 hb_HMerge( hParams, hNew )
             ELSE
                 cRet := "Invalid json in -param-json-file-base64"
             ENDIF
          ELSE
             cRet := hb_StrFormat( "File %s not found. Check -param-json-base64 " + hb_eol(), hParams[ "-param-json-file" ] ) 
          ENDIF
      ENDIF
      IF ! Empty( hParams[ "-param-json-base64" ] )
          hNew := hb_jsonDecode( hb_base64decode( hParams[ "-param-json-base64" ] ) )
          IF ValType( hNew ) == "H" // // IF hash, add to the hash of parameters
              hb_HMerge( hParams, hNew )
          ELSE
              cRet := "Invalid json in -param-json-base64" 
          ENDIF
      ENDIF
RETURN cRet