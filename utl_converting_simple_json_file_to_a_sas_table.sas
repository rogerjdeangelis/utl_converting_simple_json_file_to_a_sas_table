Converting simple json file to a sas table

Use SAS/IML/R

see
https://tinyurl.com/ydychojl
https://communities.sas.com/t5/SAS-Procedures/Splitting-Text-into-different-columns-with-headings/m-p/496138


INPUT
=====

  d:/json/utl_converting_simple_json_text_to_a_sas_table.json

  {"A123": "12", "B234": "-157.5", "C345": "1954"}
  {"A123": "12", "C345": "-157.3", "d123": "1456"}
  {"A123": "17", "B234": "-143.5", "C345": "1745", "D123": "1745"}
  {"A123": "15", "B234": "-154.4", "C345": "998"}


EXAMPLE OUTPUT
--------------

A123     B234     C345      D123    D123_1

 12     -157.5    1954
 12               -157.3    1456
 17     -143.5    1745               1745
 15     -154.4    998


PROCESS
=======

%utl_submit_r64('
library(haven);
library(SASxport);
library(jsonlite);
want<-jsonlite::stream_in(file("utl_converting_simple_json_text_to_a_sas_table"));
write.xport(want,file="d:/xpt/rxpt.xpt");
');

libname xpt xport "d:/xpt/rxpt.xpt";

proc print data=xpt.want;
run;quit;

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

data _null_;
 file "d:/json/utl_converting_simple_json_text_to_a_sas_table.json";
 input;
 put _infile_;
cards4;
{"A123": "12", "B234": "-157.5", "C345": "1954"}
{"A123": "12", "C345": "-157.3", "d123": "1456"}
{"A123": "17", "B234": "-143.5", "C345": "1745", "D123": "1745"}
{"A123": "15", "B234": "-154.4", "C345": "998"}
;;;;
run;quit;

