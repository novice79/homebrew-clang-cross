#include "lib.h"
#if defined(_WIN32)
#include <windows.h>
#endif
#include <boost/json.hpp>
namespace json = boost::json;
using namespace std;
int main(int argc, char *argv[])
{
    #if defined(_WIN32)
    MessageBox(NULL, "test", "test", 0x20);
    Sleep(2000);
    MessageBox(NULL, "test2", "test2", 0x06);
    #endif
    
    cout<< "你好，世界😄\n";
    parse_url("https://user:pass@example.com:443/path/to/my%2dfile.txt?id=42&name=John%20Doe+Jingleheimer%2DSchmidt#page%20anchor");
    json::object obj;                                               // construct an empty object
    obj[ "pi" ] = 3.141;                                            // insert a double
    obj[ "happy" ] = true;                                          // insert a bool
    obj[ "name" ] = "Boost";                                        // insert a string
    obj[ "nothing" ] = nullptr;                                     // insert a null
    obj[ "answer" ].emplace_object()["everything"] = 42;            // insert an object with 1 element
    obj[ "list" ] = { 1, 0, 2 };                                    // insert an array with 3 elements
    obj[ "object" ] = { {"currency", "USD"}, {"value", 42.99} };    // insert an object with 2 elements
    cout <<  json::serialize( obj ) << endl;
    return 0;
}