#include <iostream>
using namespace std;
#include <string>
#include <stdlib.h>

int main() {
  string water, water2;

  while(!cin.eof()) {
    cin.ignore(1, ' ');
    getline(cin, water);
    if (cin.eof())
      break;

    water2 = water;

    for(int i = 0; i < water.length(); i++) {
      if(water[i] == '.' || water[i] == '-' || water[i] == '/' || water[i] == ' ')
        water[i] = '_';

      if(water[i] == ' ')
	 water2[i] = '_';
    }

    cout << water << "[label=\"" << water2 << "\"]" << endl;
  }

}
