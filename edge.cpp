#include <iostream>
using namespace std;
#include <string>

int main()
{
  string river, water, temp;

  while(cin >> river) {
    cin >> temp;
    while (temp[0] != '|') {
      river = river + " " + temp;
      cin >> temp;
    }

    cin.ignore(1, ' ');
    getline(cin, water); 
    for(int i = 0; i < water.length(); i++) {
      if(water[i] == '.' || water[i] == '-' || water[i] == '/' || water[i] == ' ')
        water[i] = '_';
    }
    for(int i = 0; i < river.length(); i++) {
      if(river[i] == '.' || river[i] == '-' || river[i] == '/' || river[i] == ' ')
        river[i] = '_';
    }
    cout << river << " -> " << water << endl;
  }
}
