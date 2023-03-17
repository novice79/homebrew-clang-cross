


#include "lib.h"

#include <boost/url.hpp>

void parse_url(std::string url)
{
    boost::urls::url_view u( url );
    std::cout <<
    "url       : " << u                     << "\n"
    "scheme    : " << u.scheme()            << "\n"
    "authority : " << u.encoded_authority() << "\n"
    "userinfo  : " << u.encoded_userinfo()  << "\n"
    "user      : " << u.encoded_user()      << "\n"
    "password  : " << u.encoded_password()  << "\n"
    "host      : " << u.encoded_host()      << "\n"
    "port      : " << u.port()              << "\n"
    "path      : " << u.encoded_path()      << "\n"
    "query     : " << u.encoded_query()     << "\n"
    "fragment  : " << u.encoded_fragment()  << "\n";
}