



DROP DATABASE IF EXISTS EVENEMENTS;
CREATE DATABASE IF NOT EXISTS EVENEMENTS;
USE EVENEMENTS;

DROP TABLE IF EXISTS LIEU;
DROP TABLE IF EXISTS A_LIEU;
DROP TABLE IF EXISTS EVENEMENT;
DROP TABLE IF EXISTS NOTE;
DROP TABLE IF EXISTS THEME;
DROP TABLE IF EXISTS CONCERNE;
DROP TABLE IF EXISTS INSCRIT;
DROP TABLE IF EXISTS VISITEUR;
DROP TABLE IF EXISTS ADMINISTRATEUR;
DROP TABLE IF EXISTS CREERSUPPRIMER;
DROP TABLE IF EXISTS CONTRIBUTEUR;



CREATE TABLE LIEU (
  idlieu INTEGER NOT NULL AUTO_INCREMENT,
  pays VARCHAR(42),
  ville VARCHAR(42),
  rue VARCHAR(42),
  numero_rue NUMERIC(5),
  code_postal VARCHAR(42),
  position_long NUMERIC(5,4),
  position_lat NUMERIC(5,4),
  CONSTRAINT PK_LIEU PRIMARY KEY (idlieu)
) ENGINE=InnoDB ;

CREATE TABLE A_LIEU (
  idlieu INTEGER NOT NULL,
  idevent INTEGER NOT NULL,
  CONSTRAINT PK_A_LIEU PRIMARY KEY (idlieu, idevent)
) ENGINE=InnoDB ;

CREATE TABLE EVENEMENT (
  idevent INTEGER NOT NULL AUTO_INCREMENT,
  dateEvent DATE,
  effectif_min NUMERIC(10),
  effectif_max NUMERIC(10),
  idcontrib INTEGER NOT NULL,
  idtheme INTEGER NOT NULL,
  dateCRE_E_SUP_E DATE,
  CONSTRAINT PK_EVENEMENT PRIMARY KEY (idevent)
) ENGINE=InnoDB;

CREATE TABLE NOTE (
  idevent INTEGER NOT NULL,
  idvisit  INTEGER NOT NULL,
  note NUMERIC(2),
  commentaire VARCHAR(42),
  CONSTRAINT NOTE_PK PRIMARY KEY (idevent,idvisit)
) ENGINE=InnoDB ;

CREATE TABLE THEME (
  idtheme INTEGER NOT NULL AUTO_INCREMENT,
  nom VARCHAR(42),
  categorie VARCHAR(42),
  idadmin INTEGER,
  dateCRE_T_SUP_T DATE,
  CONSTRAINT PK_THEME PRIMARY KEY (idtheme)
) ENGINE=InnoDB ;

CREATE TABLE CONCERNE (
  idevent INTEGER NOT NULL,
  idtheme INTEGER NOT NULL,
  CONSTRAINT PK_CONCERNE PRIMARY KEY (idevent, idtheme)
) ENGINE=InnoDB ;

CREATE TABLE INSCRIT (
  idevent INTEGER NOT NULL,
  idvisit INTEGER NOT NULL,
  dateINS DATE,
  CONSTRAINT PK_INSCRIT PRIMARY KEY (idevent, idvisit)
) ENGINE=InnoDB ;

CREATE TABLE VISITEUR (
  idvisit INTEGER NOT NULL AUTO_INCREMENT,
  email VARCHAR(42),
  nom VARCHAR(42),
  prenom VARCHAR(42),
  age NUMERIC(3,0),
  pseudo VARCHAR(42),
password VARCHAR(70),
  CONSTRAINT PK_VISITEUR PRIMARY KEY (idvisit)
) ENGINE=InnoDB ;

CREATE TABLE ADMINISTRATEUR (
  idadmin INTEGER NOT NULL AUTO_INCREMENT,
  nom VARCHAR(42),
  prenom VARCHAR(42),
  email VARCHAR(42),
  password VARCHAR(70),
  CONSTRAINT PK_ADMINISTRATEUR PRIMARY KEY (idadmin)
) ENGINE=InnoDB ;

CREATE TABLE CREER_SUPPRIMER_CONTRIB (
  idcontrib INTEGER NOT NULL,
  idadmin INTEGER NOT NULL,
  dateCRE_C_SUP_C DATE,
  CONSTRAINT PK_CREERSUPPRIMER_CONTRIB PRIMARY KEY (idcontrib, idadmin)
) ENGINE=InnoDB ;

CREATE TABLE CONTRIBUTEUR (
  idcontrib INTEGER NOT NULL AUTO_INCREMENT,
  email VARCHAR(42),
  nom VARCHAR(42),
  prenom VARCHAR(42),
  age VARCHAR(42),
  pseudo VARCHAR(42),
  password VARCHAR(70),
  CONSTRAINT PK_CONTRIBUTEUR PRIMARY KEY (idcontrib)
) ENGINE=InnoDB;

ALTER TABLE CREER_SUPPRIMER_CONTRIB ADD CONSTRAINT FK_CREERSUPPRIMER_CONTRIB FOREIGN KEY (idcontrib) REFERENCES CONTRIBUTEUR (idcontrib);
ALTER TABLE A_LIEU ADD CONSTRAINT FK_A_LIEU_EVENT FOREIGN KEY (idevent) REFERENCES EVENEMENT (idevent);
ALTER TABLE A_LIEU ADD CONSTRAINT FK_A_LIEU FOREIGN KEY (idlieu) REFERENCES LIEU (idlieu);
ALTER TABLE EVENEMENT ADD CONSTRAINT FK_EVENEMENT_EVENT FOREIGN KEY (idcontrib) REFERENCES CONTRIBUTEUR (idcontrib);
ALTER TABLE EVENEMENT ADD CONSTRAINT FK_EVENEMENT_THEME FOREIGN KEY (idtheme) REFERENCES THEME (idtheme);
ALTER TABLE NOTE ADD CONSTRAINT FK_NOTE_VISIT FOREIGN KEY (idvisit) REFERENCES VISITEUR (idvisit);
ALTER TABLE NOTE ADD CONSTRAINT FK_NOTE_EVENT FOREIGN KEY (idevent) REFERENCES EVENEMENT (idevent);
ALTER TABLE THEME ADD CONSTRAINT FK_THEME FOREIGN KEY (idadmin) REFERENCES ADMINISTRATEUR (idadmin);
ALTER TABLE CONCERNE ADD CONSTRAINT FK_CONCERNE_THEME FOREIGN KEY (idtheme) REFERENCES THEME (idtheme);
ALTER TABLE CONCERNE ADD CONSTRAINT FK_CONCERNE_EVENT FOREIGN KEY (idevent) REFERENCES EVENEMENT (idevent);
ALTER TABLE INSCRIT ADD CONSTRAINT FK_INSCRIT_VISIT FOREIGN KEY (idvisit) REFERENCES VISITEUR (idvisit);
ALTER TABLE CREER_SUPPRIMER_CONTRIB ADD CONSTRAINT FK_CREERSUPPRIMER_ADMIN  FOREIGN KEY (idadmin) REFERENCES ADMINISTRATEUR (idadmin);
ALTER TABLE INSCRIT ADD CONSTRAINT FK_INSCRIT_EVENT FOREIGN KEY (idevent) REFERENCES EVENEMENT (idevent);
