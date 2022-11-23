DROP TYPE maia_t FORCE;

CREATE OR REPLACE 
  TYPE maia_t UNDER base_t
  ( name  VARCHAR2(30)
  , genus VARCHAR2(30)
  , CONSTRUCTOR FUNCTION maia_t
    ( name  VARCHAR2
    , genus VARCHAR2 DEFAULT 'Maiar' ) RETURN SELF AS RESULT
  , OVERRIDING MEMBER FUNCTION   get_name RETURN VARCHAR2
  , MEMBER PROCEDURE  set_name (name VARCHAR2)
  , MEMBER FUNCTION   get_genus RETURN VARCHAR2
  , MEMBER PROCEDURE  set_genus (genus VARCHAR2)
  , OVERRIDING MEMBER FUNCTION  to_string RETURN VARCHAR2 ) INSTANTIABLE NOT FINAL;
/

CREATE OR REPLACE TYPE BODY maia_t IS 
  -- Implement a default constructor. 
  CONSTRUCTOR FUNCTION maia_t
    ( name     VARCHAR2
    , genus    VARCHAR2 DEFAULT 'Maiar' ) RETURN SELF AS RESULT IS 
  BEGIN 
    self.oid := tolkien_s.CURRVAL-1000;
    self.name := name;
    self.genus := genus;
    self.oname := 'Maia';
    RETURN;
  END maia_t;
    
    -- Override the get_name function.
    OVERRIDING MEMBER FUNCTION get_name 
    RETURN VARCHAR2 IS 
    BEGIN 
      RETURN self.name;
    END get_name;
    
    -- Implement a get_genus function.
    MEMBER FUNCTION get_genus 
    RETURN VARCHAR2 IS
    BEGIN 
      RETURN self.genus;
    END get_genus;
    
    -- Implement a set_genus procedure
	MEMBER PROCEDURE set_genus ( genus VARCHAR2 ) IS
	BEGIN 
		self.genus := genus;
	END set_genus;
	
	 -- Implement a set_name procedure
    MEMBER PROCEDURE set_name (name VARCHAR2) IS 
    BEGIN 
      self.name := name;
    END set_name;

    /* Implement an overriding to_string function with
       generalized invocation. */
	OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS 
	BEGIN 
		RETURN (self AS base_t).to_string() ||'['||self.name||']['||self.genus||']';
	END to_string;
END;
/

QUIT
