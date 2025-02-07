#include <fstream>
#include <iostream>
#include <vector>
#include <filesystem>

using namespace std;

bool has_conflict_markers(const string &content) { return content.find("<<<<<<<") != string::npos; }

int main(int argc, char *argv[]) {
    string tmp = "/tmp/merge.XXXXXX";
    mkdtemp(&tmp[0]);
    string filename = filesystem::path(argv[1]).filename().string();
    vector<string> paths = { tmp + "/local_" + filename, tmp + "/base_" + filename, tmp + "/remote_" + filename };

    ifstream input(argv[1]);
    vector<ofstream> outputs; for (const auto &path : paths) outputs.emplace_back(path);
    string line; bool marker = false; int c = 0;
    while (getline(input, line)) {
        if (line.rfind("<<<<<<<", 0) == 0)  c = 1;
        else if (line.rfind("|||||||", 0) == 0)  c = 2;
        else if (line.rfind("=======", 0) == 0) c = 3;
        else if (line.rfind(">>>>>>>", 0) == 0) c = 0;
        else if (c == 0) for (auto &out : outputs) out << line << '\n';
        else { marker = true; outputs[c - 1] << line << '\n'; }
    }
    input.close();
    for (auto &out : outputs) out.close();

    if(!marker) { cout << "No git conflicts found." << endl; cin.get(); return EXIT_SUCCESS; }

    string listed_paths = paths[0] + " " + paths[1] + " " + paths[2];

    system(("nvim -d " + listed_paths).c_str());

    string merged_content; char buffer[4096];
    FILE *pipe = popen(("git merge-file --diff3 -p " + listed_paths).c_str(), "r");
    while (fgets(buffer, sizeof(buffer), pipe) != nullptr) merged_content += buffer;
    pclose(pipe);

    ofstream output(argv[1]); output << merged_content; output.close();

    if (!has_conflict_markers(merged_content)) {
        cout << "No remaining git conflicts, adding the file to the staging area." << endl;
        system(("git add " + string(argv[1])).c_str());
    } else cout << "git conflicts are still present." << endl;
    cin.get();

    return EXIT_SUCCESS;
}
