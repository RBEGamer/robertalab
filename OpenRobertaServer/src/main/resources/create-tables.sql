create table USER (
  ID INTEGER not null generated by default as identity (start with 1),
  ACCOUNT varchar(255) not null,
  PASSWORD  varchar(255) not null,
  EMAIL varchar(255),
  ROLE varchar(32) not null,
  CREATED timestamp not null,
  LAST_LOGIN timestamp not null,
  TAGS varchar(16M), -- e.g. HERDER-GYMNASIUM KÖLN Q1 ED_SHEERAN
  USER_NAME varchar(255),
  primary key (ID)
);

create unique index accountIdx on USER(ACCOUNT);

create table GROUP (
  ID INTEGER not null generated by default as identity (start with 1),
  OWNER_ID int references USER(ID),
  NAME varchar(255) not null,
  primary key (ID)
);

create unique index groupId on GROUP(NAME);

create table USER_GROUP (
  GROUP_ID int references GROUP (ID),
  USER_ID int references USER(ID),
  constraint pk_USER_GROUP primary key (GROUP_ID, USER_ID)
);

create unique index accountIdx on USER_GROUP(ACCOUNT);

create table LOST_PASSWORD (
    ID INTEGER not null generated by default as identity (start with 1),
    USER_ID INTEGER not null,
    URL_POSTFIX varchar(255),
    CREATED timestamp not null,
    
    primary key (ID),
    foreign key (USER_ID) references USER(ID) ON DELETE CASCADE
);

create table ROBOT (
  ID INTEGER not null generated by default as identity (start with 42),
  NAME varchar(255) not null,
  CREATED timestamp not null,
  TAGS varchar(16M), 
  ICON_NUMBER integer not null,
  
  primary key (ID),
);

create unique index typeIdx on ROBOT(NAME);

create table PROGRAM (
  ID INTEGER not null generated by default as identity (start with 42),
  NAME varchar(255) not null,
  OWNER_ID INTEGER not null,
  ROBOT_ID INTEGER not null,
  PROGRAM_TEXT varchar(16M),
  CREATED timestamp not null,
  LAST_CHANGED timestamp not null,
  LAST_CHECKED timestamp,
  LAST_ERRORFREE timestamp,
  NUMBER_OF_BLOCKS INTEGER,
  TAGS varchar(16M), -- e.g. CAR AUTONOMOUS COOL 3WHEELS
  ICON_NUMBER integer not null,
  
  primary key (ID),
  foreign key (OWNER_ID) references USER(ID) ON DELETE CASCADE,
  foreign key (ROBOT_ID) references ROBOT(ID)
);

create unique index progNameOwnerRobotIdx on PROGRAM(NAME, OWNER_ID, ROBOT_ID);

create table USER_PROGRAM (
  ID INTEGER not null generated by default as identity (start with 42),
  USER_ID INTEGER not null,
  PROGRAM_ID INTEGER not null,
  RELATION varchar(32) not null, -- 1 READ access, 2 WRITE access, 4 DELETE right, (really? not yet used) 8 PROMOTE_READ right, 16 PROMOTE_WRITE right
 
  foreign key (USER_ID) references USER(ID) ON DELETE CASCADE,
  foreign key (PROGRAM_ID) references PROGRAM(ID) ON DELETE CASCADE
);

create table TOOLBOX (
  ID INTEGER not null generated by default as identity (start with 42),
  NAME varchar(255) not null,
  OWNER_ID INTEGER,
  ROBOT_ID INTEGER not null,
  TOOLBOX_TEXT varchar(16M),
  CREATED timestamp not null,
  LAST_CHANGED timestamp not null,
  LAST_CHECKED timestamp,
  LAST_ERRORFREE timestamp,
  TAGS varchar(16M), -- e.g. CAR AUTONOMOUS COOL 3WHEELS
  ICON_NUMBER integer not null,
  
  primary key (ID),
  foreign key (OWNER_ID) references USER(ID) ON DELETE CASCADE,
  foreign key (ROBOT_ID) references ROBOT(ID)
);

create unique index toolNameOwnerIdx on TOOLBOX(NAME, OWNER_ID, ROBOT_ID);

create table CONFIGURATION (
  ID INTEGER not null generated by default as identity (start with 42),
  NAME varchar(255) not null,
  OWNER_ID INTEGER,
  ROBOT_ID INTEGER not null,
  CONFIGURATION_TEXT varchar(16M),
  CREATED timestamp not null,
  LAST_CHANGED timestamp not null,
  LAST_CHECKED timestamp,
  LAST_ERRORFREE timestamp,
  TAGS varchar(16M), -- e.g. CAR AUTONOMOUS COOL 3WHEELS
  ICON_NUMBER integer not null,
  
  primary key (ID),
  foreign key (OWNER_ID) references USER(ID) ON DELETE CASCADE,
  foreign key (ROBOT_ID) references ROBOT(ID)
);

insert into ROBOT
( NAME, CREATED, TAGS, ICON_NUMBER )
values('ev3',
now,
 '', 0
 );
commit;

insert into USER
(ACCOUNT, PASSWORD, EMAIL, ROLE, CREATED, LAST_LOGIN, TAGS, USER_NAME)
values ('Roberta','d4ab787ab667fef4:a5bf6037bd904f05b76ee431ae285f443229e3a3','','TEACHER',now ,now ,'','Roberta Roboter'
);
commit;

insert into USER
(ACCOUNT, PASSWORD, EMAIL, ROLE, CREATED, LAST_LOGIN, TAGS, USER_NAME)
values ('TEST','d4ab787ab667fef4:a5bf6037bd904f05b76ee431ae285f443229e3a3','','TEACHER',now ,now ,'','Test User'
);
commit;

insert into GROUP
(NAME)
values ('Fraunhofer');
commit;

insert into USER_GROUP
(GROUP_ID, USER_ID)
values (1,2);
commit;

insert into USER
(ACCOUNT, PASSWORD, EMAIL, ROLE, CREATED, LAST_LOGIN, TAGS, USER_NAME)
values ('TEST','d4ab787ab667fef4:a5bf6037bd904f05b76ee431ae285f443229e3a3','','TEACHER',now ,now ,'','Test User'
);
commit;


insert into PROGRAM
( NAME, OWNER_ID, ROBOT_ID, PROGRAM_TEXT, CREATED, LAST_CHANGED, LAST_CHECKED, LAST_ERRORFREE, NUMBER_OF_BLOCKS, TAGS, ICON_NUMBER )
values('TestProg',2,42,'<block_set xmlns="http://de.fhg.iais.roberta.blockly"><instance x="370" y="50"><block type="robControls_start" id="149" intask="true" deletable="false"><mutation declare="false"></mutation></block><block type="robActions_motorDiff_on" id="168" inline="false" intask="true"><field name="DIRECTION">FOREWARD</field><value name="POWER"><block type="math_number" id="169" intask="true"><field name="NUM">30</field></block></value></block><block type="robControls_wait_for" id="189" inline="false" intask="true"><value name="WAIT0"><block type="logic_compare" id="190" inline="true" intask="true"><mutation operator_range="COLOUR"></mutation><field name="OP">EQ</field><value name="A"><block type="sim_getSample" id="191" intask="true" deletable="false" movable="false"><mutation input="COLOUR_COLOUR"></mutation><field name="SENSORTYPE">COLOUR_COLOUR</field><field name="SENSORPORT">3</field></block></value><value name="B"><block type="robColour_picker" id="197" intask="true"><field name="COLOUR">#000000</field></block></value></block></value></block></instance></block_set>',
now, now, now, now,
0,'', 0
 );
commit;
