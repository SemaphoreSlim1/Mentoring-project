using Logorder;
using System.Text.Json;
using System.Text.Json.Nodes;

//var consolehelper = new ConsoleHelper();
//var input = consolehelper.Prompt("give me some data");
//Console.WriteLine(input);

//var filecontents = File.ReadAllText("c:\\myfile.txt");
//Console.WriteLine(filecontents);
var fileinfo = new FileInfo("log20251015.json");
foreach (var line in File.ReadLines(fileinfo.FullName))   
{
    var json = JsonSerializer.Deserialize<JsonObject>(line);
    Console.WriteLine(json);
    Console.WriteLine(json["timestamp"]);
}
