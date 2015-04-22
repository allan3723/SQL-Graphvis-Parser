#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main()
{ 
  ofstream dotFile;
  ifstream inFile, style;
  int choice=0;
  string line;

  system("createdb mondial");
  system("psql mondial -q -f mondial-schema.sql");
  system("psql mondial -q -f mondial-inputs.sql");
  system("psql mondial -q -f flow-into.sql");

  while ((choice < 1) || (choice > 7)){
     cout << "\nSelect a GV\n"
     << "1. River to river only.\n"
     << "2. River to lake only.\n"
     << "3. River to sea only.\n"
     << "4. River to river and lake.\n"
     << "5. River to river and sea. \n"
     << "6. River to lake and sea. \n"
     << "7. River to all. \n"
     << "Choose a number: ";
     cin >> choice;	  
	 if ((choice < 1) || (choice > 7))
		cout << "Not a valid option\n";
   }
   
   switch(choice){
      case 1:
        system("psql mondial -t -f river.sql > allriver.txt");
	    system("psql mondial -t -f rr.sql > rr.txt");
	    break;
      case 2:
	    system("psql mondial -t -f river2.sql > allriver.txt");
		system("psql mondial -t -f lake.sql > alllake.txt");
	    system("psql mondial -t -f rl.sql > rl.txt");
	    break;
      case 3:
	    system("psql mondial -t -f river3.sql > allriver.txt");	
        system("psql mondial -t -f sea.sql > allsea.txt");	  
	    system("psql mondial -t -f rs.sql > rs.txt");
	    break;
      case 4:
		system("psql mondial -t -f lake.sql > alllake.txt");
        system("psql mondial -t -f river4.sql > allriver.txt"); 
	    system("psql mondial -t -f rr.sql > rr.txt");
           system("psql mondial -t -f rl.sql > rl.txt");
	    break;
      case 5:
        system("psql mondial -t -f river5.sql > allriver.txt");
        system("psql mondial -t -f sea.sql > allsea.txt");	  
	    system("psql mondial -t -f rs.sql > rs.txt");
	    system("psql mondial -t -f rl.sql > rl.txt");
	    break;
      case 6:
	       system("psql mondial -t -f river6.sql > allriver.txt");
		system("psql mondial -t -f lake.sql > alllake.txt");
        system("psql mondial -t -f sea.sql > allsea.txt");	  
	    system("psql mondial -t -f rl.sql > rl.txt");
	    system("psql mondial -t -f rs.sql > rs.txt");
	    break;
      default:
	    system("psql mondial -t -f alllake.sql > alllake.txt");
        system("psql mondial -t -f allriver.sql > allriver.txt");
        system("psql mondial -t -f allsea.sql > allsea.txt");
		system("psql mondial -t -f rr.sql > rr.txt");
		system("psql mondial -t -f rl.sql > rl.txt");
		system("psql mondial -t -f rs.sql > rs.txt");
		break;
    }
  
  style.open("Stylesheet");
  string rshape, lshape, sshape, rstyle, lstyle, sstyle, 
         rcolor, lcolor, scolor, rrcolor, rlcolor, rscolor, 
         rrdir, rldir, rsdir, rrstyle, rlstyle, rsstyle, rrlabel, 
         rllabel, rslabel, rrfname, rlfname, rsfname, rrfcolor, 
         rlfcolor, rsfcolor;
  int rwidth, lwidth, swidth, rheight, lheight, sheight, rrfsize, 
      rlfsize, rsfsize;

	style >> rshape >> rshape >> rshape >> rshape >> rshape >> rshape >> rshape
             >> rshape >> rshape>> rstyle >> rwidth >> rheight >> rcolor
             >> lshape >> lshape >> lstyle >> lwidth >> lheight >> lcolor
             >> sshape >> sshape >> sstyle >> swidth >> sheight >> scolor
             >> rrcolor >> rrcolor >> rrcolor >> rrcolor >> rrcolor 
             >> rrcolor >> rrcolor >> rrcolor
             >> rrcolor
             >> rrcolor >> rrcolor >> rrdir >> rrstyle
             >> rrlabel >> rrfname >> rrfcolor >> rrfsize
	           >> rlcolor >> rlcolor >> rldir >> rlstyle >> rllabel 
             >> rlfname >> rlfcolor >> rlfsize
             >> rscolor >> rscolor >> rsdir >> rsstyle >> rslabel 
             >> rsfname >> rsfcolor >> rsfsize;

  style.close();
  dotFile.open("graph.gv");

  dotFile << "digraph {\nrankdir=BT\n";

  	dotFile << "node [shape=\"" << rshape << "\" style=\"" << rstyle 
            << "\" width=" << rwidth 
            << " height=" << rheight << " color=\"" << rcolor << "\"]\n";
 
  	system("node < allriver.txt > river.txt");

  	inFile.open("river.txt");
  	while ( !inFile.eof())
  	{
   	   getline(inFile, line);
    	   dotFile << line << endl;

    	   if (inFile.eof())
      	     break;
  	}
  	inFile.close();

  if (choice == 2 || choice == 4 || choice == 6 || choice == 7) {
  	dotFile << "node [shape=\"" << lshape << "\" style=\"" << lstyle 
            << "\" width=" << lwidth 
            << " height=" << lheight << " color=\"" << lcolor << "\"]\n";
  	system("node < alllake.txt > lake.txt");
  	inFile.open("lake.txt");

  	while ( !inFile.eof())
  	{
    	   getline(inFile, line);
    	   dotFile << line << endl;

    	   if (inFile.eof())
      	     break;
  	}
  	inFile.close();
  }


  if(choice == 3 || choice == 5 || choice == 6 || choice == 7) {
  	dotFile << "node [shape=\"" << sshape << "\" style=\"" << sstyle 
            << "\" width=" << swidth 
            << " height=" << sheight << " color=\"" << scolor << "\"]\n";
  	system("node < allsea.txt > sea.txt");
  	inFile.open("sea.txt");

  	while ( !inFile.eof())
  	{
    	  getline(inFile, line);
    	  dotFile << line << endl;

    	  if (inFile.eof())
      	    break;
  	}
  	inFile.close();
  }


  if (choice == 1 || choice == 4 || choice == 5 || choice == 7) {
  	system("edge < rr.txt > rr");
 	 dotFile << "edge [color=\"" << rrcolor << "\" dir=" << rrdir 
           << " style=" << rrstyle
           << " label=\"" << rrlabel << "\" fontname=\"" 
           << rrfname << "\" fontcolor=\""
		       << rrfcolor << "\" fontsize=\"" << rrfsize <<"\"]\n";
  	inFile.open("rr");

 	 while ( !inFile.eof())
 	 {
    	   getline(inFile, line);
    	   dotFile << line << endl;

    	   if (inFile.eof())
      	     break;
  	 }
  	 inFile.close();
  }

  if (choice == 2 || choice == 4 || choice == 6 || choice == 7) {  
  	system("edge < rl.txt > rl");
 	 dotFile << "edge [color=\"" << rlcolor << "\" dir=" << rldir 
           << " style=" << rlstyle
           << " label=\"" << rllabel << "\" fontname=\"" 
           << rlfname << "\" fontcolor=\""
		       << rlfcolor << "\" fontsize=\"" << rlfsize <<"\"]\n";
 	 inFile.open("rl");

 	 while ( !inFile.eof())
 	 {
   	   getline(inFile, line);
   	   dotFile << line << endl;

    	  if (inFile.eof())
      	    break;
  	}
  	inFile.close();
  }

  if(choice == 3 || choice == 5 || choice == 6 || choice == 7) {  
  	system("edge < rs.txt > rs");
 	 dotFile << "edge [color=\"" << rscolor << "\" dir=" << rsdir 
           << " style=" << rsstyle
           << " label=\"" << rslabel << "\" fontname=\"" 
           << rsfname << "\" fontcolor=\""
		       << rsfcolor << "\" fontsize=\"" << rsfsize <<"\"]\n";
  	inFile.open("rs");

  	while ( !inFile.eof())
  	{
    	  getline(inFile, line);
    	  dotFile << line << endl;

    	  if (inFile.eof())
      	    break;
  	}
  	inFile.close();
  }

  dotFile << "}\n";

  dotFile.close();

  system("dropdb mondial");
  
}
