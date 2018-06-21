
question 11

création d'un type d'objet : telephone_elt_vry_type ayant un attribut  num_tel de type VARCHAR2(14)	
création d'un type  tableau telephone_vry_type de 3 éléments de type telephone_elt_vry_type
création d'un type d'objet  client_type   ayant 4 attributs : num  de type number (5),  nom de type  VARCHAR2(30), adresse de type VARCHAR2(30),
telephone_vry  de type telephone_vry_type
création de table client à partir  du type d'objet client_type ayant comme clé primaire le num du client 


question 12
 
--creation  procédure change_Portable acceptant deux paramètres : paramcli et paramtel
CREATE OR REPLACE PROCEDURE change_Portable (paramcli IN NUMBER, paramtel IN
VARCHAR2) IS
-- déclaration d'une variable de type telephone_vry_type (tableau de 3 téléphones)
tableau_tel telephone_vry_type;
indice NUMBER; -- declaration d'une variable indice de type number

BEGIN
 -- affectation de  telephone_vry dans la variable tableau_tel  
SELECT telephone_vry INTO tableau_tel
FROM Client WHERE num = paramcli FOR UPDATE;
-- si le troisieme éléments du tableau tableau_tel n'existe pas alors indice = 1

IF NOT tableau_tel.EXISTS(3) THEN
indice := 1;
--boucle tant que indice < 3 
WHILE (indice <= tableau_tel.LIMIT)
LOOP
-- on étend le tableau s'il n'y a pas d'élément d'indice : indice
IF NOT (tableau_tel.EXISTS(indice)) THEN
 tableau_tel.EXTEND;
 tableau_tel(indice) := telephone_elt_vry_type(NULL);
END IF;
-- oncrementation de indice
indice := indice + 1;
-- fin boucle while
END LOOP;
-- fin condition if
END IF;
-- affectation  du paramtel au téléphone du 3 ème élément  du tableau tableau_tel
tableau_tel(3).numTel := paramtel;
--modification du client ayant num = paramcli
UPDATE Client SET telephone_vry = tableau_tel WHERE num = paramcli;
-- bloc exception lancé quand il n'y a pas de clients ayant num= paramcli
EXCEPTION
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Client inexistant');
END;
/
 rôle : 
Procédure cataloguée change_Portable(paramcliINNUMBER, paramtelINVARCHAR2) qui affecte à un client
 donné (paramcli) un nouveau numéro de portable (paramtel).le tableau VARRAY  telephone_vry est étendu ou pas



