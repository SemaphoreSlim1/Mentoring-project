using System;
using System.Collections.Generic;
using System.Text;

namespace Logorder
{
    internal class ConsoleHelper
    {
        public string Prompt(string message)
        {
            Console.Write(message + ":");
            var input = Console.ReadLine();
            return input;
        }
    }
}
