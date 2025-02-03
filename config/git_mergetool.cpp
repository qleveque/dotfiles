#include <fstream>
#include <string>
#include <vector>
#include <filesystem>
#include <cstdlib>

bool has_conflict_markers(const std::string &content) {
    return content.find("<<<<<<<") != std::string::npos &&
           content.find("|||||||") != std::string::npos &&
           content.find("=======") != std::string::npos &&
           content.find(">>>>>>>") != std::string::npos;
}

int main(int argc, char *argv[]) {
    std::string tmpdir = "/tmp/merge.XXXXXX";
    mkdtemp(&tmpdir[0]);
    std::string filename = std::filesystem::path(argv[1]).filename().string();

    std::vector<std::string> paths = {
        tmpdir + "/local_" + filename,
        tmpdir + "/base_" + filename,
        tmpdir + "/remote_" + filename
    };

    std::ifstream input(argv[1]);
    std::vector<std::ofstream> outputs;
    for (const auto &path : paths) {
        outputs.emplace_back(path);
    }

    std::string line;
    bool marker = false;
    int c = 0;

    while (std::getline(input, line)) {
        if (line.rfind("<<<<<<<", 0) == 0) {
            c = 1;
        } else if (line.rfind("|||||||", 0) == 0) {
            c = 2;
        } else if (line.rfind("=======", 0) == 0) {
            c = 3;
        } else if (line.rfind(">>>>>>>", 0) == 0) {
            c = 0;
        } else {
            if (c == 0) {
                for (auto &out : outputs) {
                    out << line << '\n';
                }
            } else {
                outputs[c - 1] << line << '\n';
            }
        }
        if(c) {
            marker = true;
        }
    }

    input.close();
    for (auto &out : outputs) {
        out.close();
    }

    if(!marker) {
        std::system(("nvim " + std::string(argv[1])).c_str());
        return EXIT_SUCCESS;
    }

    std::string nvim_cmd = "nvim -c \":nn dp 1dp3dp:wa<CR>\""
                           " -c \":nm doh 1dodp\""
                           " -c \":nm dol 3dodp\""
                           " -c ':au VimEnter * :winc h' -d " +
                           paths[0] + " " + paths[1] + " " + paths[2];
    std::system(nvim_cmd.c_str());

    std::string merge_cmd = "git merge-file --diff3 -p " + paths[0] + " " + paths[1] + " " + paths[2];
    FILE *pipe = popen(merge_cmd.c_str(), "r");
    std::string merged_content;
    char buffer[4096];
    while (fgets(buffer, sizeof(buffer), pipe) != nullptr) {
        merged_content += buffer;
    }
    pclose(pipe);

    std::ofstream output(argv[1]);
    output << merged_content;
    output.close();

    if (!has_conflict_markers(merged_content)) {
        std::system(("git add " + std::string(argv[1])).c_str());
    }

    return EXIT_SUCCESS;
}
