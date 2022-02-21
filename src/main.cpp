#include <iostream>
#include <filesystem>
#include <cstdlib>

#define ROOT_PATH "/Users/dludwig/code"

int main()
{
    const std::string_view completion{getenv("COMP_LINE")};
    const std::string::size_type space_pos = completion.find(' ');
    if (space_pos == std::string_view::npos) {
        return 0;
    }

    const std::string_view completion_dir = completion.substr(space_pos + 1, std::string_view::npos);
    const std::filesystem::path root{ROOT_PATH};
    for (auto const& dir_entry : std::filesystem::directory_iterator{root})
    {
        const std::string basename = dir_entry.path().stem().string() ;
        if (basename[0] == '.') {
            continue;
        }
        if (basename.starts_with(completion_dir)) {
            std::cout << basename << '\n';
        }
    }
    return 0;
}
